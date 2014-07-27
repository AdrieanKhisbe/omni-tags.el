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

;; §todo: autoload
(defun ot:occur-tags ()
  "Call occur on My §tags."
  (interactive)
  (push-mark)
  (occur "§\\w+" )) ;; §TODO: use pattern!
;; §next with helm ;moccur...
;; couper en deux avec 1&2ary?

;; §maybe cycle?
(defun ot:next-tags ()
  "Go to next §tags."
  (interactive)
  (push-mark) ;; §maybe: not if previous command was either next/previous tag? ¤maybe: configurable behavior?
  ;; §maybe: special mark ring?
  (if (search-forward-regexp "§\\w+" nil t)
      (backward-word) ;§todo: adapt movement
    ;;§todo: make generic to adapt to tag symbol: : default arg symbol (that would be call by next-primary/secondary)
    (message "No More Founds Tags!")))
;; §maybe: si ressaye, revient au début?

(defun ot:previous-tags ()
  "Go to prev §tags."
  (interactive)
  (unless (search-backward-regexp "§\\w+" nil t)
    (message "No Tags Before!")))

(provide 'omni-tags-navigation)

;;; omni-tags-navigation.el ends here
