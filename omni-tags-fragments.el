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
(setq ot:fragment:SYMB `(,(format "\\(%s\\|%s\\)" ot:primary-tag ot:secondary-tag)
			 'ot:face:symbol))
(setq ot:fragment:TAG '("\\(['@\\-_ [:alnum:]]\\)" ; ¤note:novarfornow
			'ot:face:ponctuation))
;; §maybe: add leading symbol?

;; §maybe:rename
(defun build-pattern (&rest fragments)
  (mapconcat 'car fragments  ""))
(defun build-keywords-attributes( &rest fragments) ;§rename
  (let ((current-index 1)
	(current-list '()))
    (mapc (lambda(frag)
	    ;; §maybe: build pattern here.
	    (add-to-list current-list `(,current-index ,(cadr frag) ,ot:override)))
	    ;; §later: override(late eval) + optional? [build recipe before]
	  fragments)
    )
  current-list
  )
(build-pattern ot:fragment:SYMB ot:fragment:TAG)
(build-keywords-attributes ot:fragment:SYMB ot:fragment:TAG)
;; §maybe: do all at once?
(cadr ot:fragment:TAG)

;; §maybe: customize component

(provide 'omni-tags-fragments)

;;; omni-tags-fragments.el ends here
