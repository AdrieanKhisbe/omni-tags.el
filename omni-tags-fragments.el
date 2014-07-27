;;; omni-tags-fragment.el --- Fragment definition pattern for `omni-tags-mode'
;;
;; Copyright (C) 2014 Adrien Becchis
;;
;; Author: Adrien Becchis <adriean.khisbe@live.fr>
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:
;; `ot' is the namepace prefix

;;; Building-Notes:
;; §note: prototype for now

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


;; §maybe: define symbol here?

;; §maybe: pattern list


;; §PROTO
;; §pattern, face.
(defconst ot:fragment:SYMB `(,(format "\\(%s\\|%s\\)" ot:primary-tag ot:secondary-tag)
			 'ot:face:symbol))
(defconst ot:fragment:TAG '("\\(['@\\-_ [:alnum:]]\\)" ; ¤note:novarfornow
			'ot:face:ponctuation))
;; §maybe: add leading symbol? [when if wont be a cons cell anymore.]


(defun build-keywords-definition(&rest fragments)
  (let ((current-index 1)
	(current-list '()))
    ;; ajoute regexp
    (push (mapconcat 'car fragments  "") current-list)
    ;; ajoute match highlights
    (mapc (lambda(frag)
	    (push  `(,current-index ,(cadr frag) ,ot:override)  ;§rename
		   current-list)
	      (setq current-index (1+ current-index)))
	  fragments)
    (reverse current-list )))
;; §later: override(late eval) + optional? [build recipe before]
;;         pattern repetition. [maybe ]
;; §tmp:
(build-keywords-attributes ot:fragment:SYMB ot:fragment:TAG)

;; §maybe: customize component

(provide 'omni-tags-fragments)

;;; omni-tags-fragments.el ends here
