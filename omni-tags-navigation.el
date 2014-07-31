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

;; §next with helm ;moccur...
;; couper en deux avec 1&2ary?


(defvar oq:navigation-regexp "§\\w+"
  ;; §note: try, but crashed (format "\\(%s\\|%s\\)%s\\w+" oq:primary-tag oq:secondary-tag)
  ;;        §maybe -> loading mode would reset theses variables (and font patterns)
  ;;        factorize in refresh methods?
  "Navigation regexp used in all the navigation function")
;; §maybe: distinguish primary, secondary
;; §todo: adapt to customs.

;; §todo: autoload [might be more complicate since in subfile: (require omni-tags?? -> cyclic dep)]
(defun ot:occur-tags ()
  "Call occur on My §tags.

Pattern is specified by `oq:navigation-regexp'."
  (interactive)
  (push-mark)
  (occur oq:navigation-regexp)) ;; §TODO: use pattern!

;; §maybe cycle?
(defun ot:next-tags ()
  "Go to next §tags.

Pattern is specified by `oq:navigation-regexp'."
  (interactive)
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


(defun ot:previous-tags ()
  "Go to prev §tags.

Pattern is specified by `oq:navigation-regexp'."
  (interactive)
  (push-mark)
  (unless (search-backward-regexp oq:navigation-regexp nil t)
    (message "No Tags Before!")
    (pop-mark)))

(provide 'omni-tags-navigation)

;;; omni-tags-navigation.el ends here
