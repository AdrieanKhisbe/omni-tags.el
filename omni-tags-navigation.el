;;; omni-tags-navigation.el --- Navigation between omni-tags
;;
;; Copyright (C) 2014 Adrien Becchis
;;
;; Author: Adrien Becchis <adriean.khisbe@live.fr>
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:
;; `ot' is the namepace prefix


;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

;; §next with helm, moccur...

(defvar oq:navigation-regexps '("§\\w+" "\\(§\\|¤\\)\\w+" "¤\\w+")
  ;; ¤note: try, but crashed (format "\\(%s\\|%s\\)%s\\w+" oq:primary-tag oq:secondary-tag)
  ;; §maybe -> loading mode would reset theses variables (and font patterns)
  ;;        factorize in refresh methods?
  "Navigation regexp used in all the navigation function. (normal, one universal, two universal)")
;; §maybe: distinguish primary, secondary
;; §todo: adapt to customs.


;; ¤> rafinate commands to change pattern behavior based on Universal arguments/
;; §later: extract non interactive function, and pass the mode as optional argument.

;; §inspired from http://emacsredux.com/blog/2013/07/17/advise-multiple-commands-in-the-same-manner/
(defmacro defun-tagary (function-name args doc &rest body)
  "Macro to create interactive commands where \\[universal-argument] would enable switch between primary and secondary tag"
  `(defun ,function-name ,args ,doc  ;; ¤see:(intern function-name)
     (interactive) ; §see: maybe not good idea to grab the interactive there... [see with extract fnon interactive functino]
     ;; see if generate also the non interactive command.?
     (let ((oq:navigation-regexp (case (car-safe current-prefix-arg)  ;; §extract macro
				   (4  (nth 1 oq:navigation-regexps)); uninversal arg
				   (16 (nth 2 oq:navigation-regexps)); Double uninversal arg -> relative
				   (t (nth 0 oq:navigation-regexps)))))
       (progn ,@body))))

;; ¤note: [si pattern wrap en faire vrai macro, pattern, de spécialisation commandes]
;; §later? add message, §todo: extract custom
;; §bonux: find a way this persist for next invocations? [last command + last value var!]

;; ¤>> color goodi for macros.
(defconst ot:defun-tagary-keyword
  '(("(\\(defun-tagary\\)\\_>[ \t']*\\(\\(?:\\sw\\|\\s_\\)+\\)"
     (1 font-lock-keyword-face) ; ¤note: inspired from usepackage
     (2 font-lock-constant-face))))

(font-lock-add-keywords 'emacs-lisp-mode ot:defun-tagary-keyword)
;; ¤maybe: extract this and specific macro in thir own file {utils}
;; §maybe: do the same thing to set value and refresh? : tagsymbolcompute. (hook a list)

;; ¤> functions:
;; ¤>> next,previous
;; §maybe cycle?
(defun-tagary ot:next-tags ()
  "Go to next §tags.

Pattern is specified by `oq:navigation-regexps'."
  (push-mark) ;; §maybe: not if previous command was either next/previous tag? ¤maybe: configurable behavior?
  ;; §maybe: special mark ring?
  (if (search-forward-regexp oq:navigation-regexp nil t
			     ;; count value:
			     (if (looking-at oq:navigation-regexp) 2 1))
      (goto-char (match-beginning 0)); §check: might set the mark due to the advice
    (progn (message "No More Founds Tags!")
	   (pop-mark) ; avoid marks to accumulate oonce end of buffer
	   )))
;;§todo: make generic to adapt to tag symbol: : default arg symbol (that would be call by next-primary/secondary)
;; §maybe: si ressaye, revient au début? [check last command.et s'assurer qu'il y a un §]
;; §see: isearch-repeat dans isearch.el1326 [wrap function, sinon goto min/max -> var pour direction ]


(defun-tagary ot:previous-tags ()
  "Go to prev §tags.

Pattern is specified by `oq:navigation-regexps'."
  (push-mark)
  (unless (search-backward-regexp oq:navigation-regexp nil t)
    (message "No Tags Before!")
    (pop-mark)))


;; ¤>> occur, helms...

;; ¤note: malformed function is a false warning.
(defun-tagary oq:count-tags () ; §see:primary-vs-secondary.
  "count number of tag in the whole file"
  (how-many oq:navigation-regexp (point-min) (point-max))
  ;; §todo: extract intern function and make interactove say: There is ...
  ;; // make it use the region if an selected
  )

;; §todo: functions to scan accross directory, project

;; §todo: autoload [might be more complicate since in subfile: (require omni-tags?? -> cyclic dep)]
(defun-tagary ot:occur-tags ()
  "Call occur on My §tags.

Pattern is specified by `oq:navigation-regexps'."
  (push-mark)
  (occur oq:navigation-regexp)) ;; §TODO: use pattern!

;; §to apply to multuiple buffer see: [for different namespaces!]

(provide 'omni-tags-navigation)

;;; omni-tags-navigation.el ends here
