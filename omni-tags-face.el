;;; omni-tags-face.el --- Specials faces for `omni-tags-mode'
;;
;; Copyright (C) 2014 Adrien Becchis
;;
;; Author: Adrien Becchis <adriean.khisbe@live.fr>
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:
;; `ot' is the namepace prefix

;;; Building-Notes:
;; §maybe: pass color as custom. (at least mine. haha.)
;; §maybe: switch about face occurs here? (option require?)
;; §maybe: specify mode according light/dark. and tty.
;; ¤maybe:doc add reference to the mode?
;;        trailing dot?
;; ¤todo:custom: tweak colors


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

(defgroup omni-tags-face nil
  "Faces for `omni-tags'."
  :group 'omni-tags)

(defface ot:face:default
  '((t )) ;; §maybe: background, or properties/keymap whatever
  "SuperFace for Omni Tags"
  :group 'omni-tags-faces)

(defface ot:face:symbol
  '((t (:inherit ot:face:default
		 :weight bold :foreground "DeepSkyBlue2"))) ;; §maybe: change with tags [and tag darker]
  "Face used for the tag symbol (leading character)"
  :group 'omni-tags-faces)

(defface ot:face:symbols
  '((t (:inherit ot:face:default
		 :weight bold :foreground "DeepSkyBlue3")))
  "Face used for the consecutive tag symbols"
  :group 'omni-tags-faces)

(defface ot:face:name
  '((t (:inherit ot:face:default
		 :weight bold :foreground "SteelBlue1")))
  "Face used for the first keyword of the tag"
  :group 'omni-tags-faces)

(defface ot:face:details
  '((t (:inherit ot:face:default
		 :slant italic :foreground "LightSteelBlue1")))
  "Face used for addition details inside a tag"
  :group 'omni-tags-faces)

(defface ot:face:separator
  '((t (:inherit ot:face:default
		 :weight bold :foreground "OrangeRed1")))
  "Face used for trailing ponctuation"
  :group 'omni-tags-faces)

(defface ot:face:ponctuation
  '((t (:inherit ot:face:default
		 :weight bold :foreground "red3"))) ;§check:bold working.
  "Face used for the separators inside a tag"
  :group 'omni-tags-faces)


(provide 'omni-tags-face)

;;; omni-tags-face.el ends here
