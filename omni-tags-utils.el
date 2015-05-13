;;; omni-tags-utils.el --- Macro utils and else for `omni-tags-mode'
;;
;; Copyright (C) 2014 Adrien Becchis
;;
;; Author: Adrien Becchis <adriean.khisbe@live.fr>
;; Keywords: convenience

;; This file is not part of GNU Emacs.

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

;;; Commentary:
;; Utils macros and function for `omni-tags'

;;; Code:

(require 'cl-lib)

;; ¤> Universal Commands
;;  rafinate commands to change pattern behavior based on Universal arguments/
;; §later: extract non interactive function, and pass the mode as optional argument.
(defmacro defun-tagary (function-name args doc &rest body) ;§todo:rename omni-tags-defun-tags
  "Macro to create interactive FUNCTION-NAME commands where \\[universal-argument]s
 would enable switch between primary and secondary tag" ; §todo: add doc about other functions
  `(defun ,function-name ,args ,doc  ;; ¤see:(intern function-name)
     (interactive) ; §see: maybe not good idea to grab the interactive there... [see with extract fnon interactive functino]
     ;; see if generate also the non interactive command.?
     (let ((omni-tags-navigation-regexp (cl-case (car-safe current-prefix-arg)  ;; §extract macro
                                   (4  (nth 1 omni-tags-navigation-regexps)); uninversal arg
                                   (16 (nth 2 omni-tags-navigation-regexps)); Double uninversal arg -> relative
                                   (t (nth 0 omni-tags-navigation-regexps)))))
       (progn ,@body))))

;; ¤note: [si pattern wrap en faire vrai macro, pattern, de spécialisation commandes]
;; §later? add message, §todo: extract custom
;; §bonux: find a way this persist for next invocations? [last command + last value var!]

;; ¤>> color goodi for macros.
(defconst omni-tags-defun-tagary-keyword
  '(("(\\(defun-tagary\\)\\_>[ \t']*\\(\\(?:\\sw\\|\\s_\\)+\\)"
     (1 font-lock-keyword-face) ; ¤note: inspired from usepackage
     (2 font-lock-constant-face))))

(font-lock-add-keywords 'emacs-lisp-mode omni-tags-defun-tagary-keyword)
;; ¤maybe: extract this and specific macro in thir own file {utils}
;; §maybe: do the same thing to set value and refresh? : tagsymbolcompute. (hook a list)


;; ¤> resetable vars!!
;; for tags and so on.
;; ¤what en gros la macro devrait s'enreistrer, et le contenu etre réévalue.
;; contrainte: doit se faire dans l'ordre
;; idéalement faudrait capturer l'eval quote, et la reevaluer
;; should capture the "structure" (backquote STRUCTURE) and reexpand.

(provide 'omni-tags-utils)

;;; omni-tags-utils.el ends here
