;;; omni-tags-face.el --- Specials faces for `omni-tags-mode'
;;
;; Copyright (C) 2014-2017 Adrien Becchis
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


;;; Building-Notes:
;; §maybe: pass color as custom. (at least mine. haha.)
;; §maybe: switch about face occurs here? (option require?)
;; §maybe: specify mode according light/dark. and tty.
;; ¤maybe:doc add reference to the mode?
;;        trailing dot?
;; ¤todo:custom: tweak colors

;;; Commentary:
;; This file contain the faces used in `omni-tags' highlighting

;;; Code:

(defgroup omni-tags-face nil
  "Faces for `omni-tags'."
  :group 'omni-tags)

;; §idea: make color collection matching with zenburn, etc and other favorites modes

(defface omni-tags-face-default
  '((t )) ;; §maybe: background, or properties/keymap whatever
  "SuperFace for Omni Tags"
  :group 'omni-tags-faces)

(defface omni-tags-face-symbol
  '((t (:inherit omni-tags-face-default
                 :weight bold :foreground "DeepSkyBlue2")))
  ;; §maybe: change with color tags [and tag darker]

  "Face used for the tag symbol (leading character)"
  :group 'omni-tags-faces)

(defface omni-tags-face-symbols
  '((t (:inherit omni-tags-face-default
                 :weight bold :foreground "DeepSkyBlue3")))
  "Face used for the consecutive tag symbols"
  :group 'omni-tags-faces)

(defface omni-tags-face-name
  '((t (:inherit omni-tags-face-default
                 :weight bold :foreground "SteelBlue1")))
  "Face used for the first keyword of the tag"
  :group 'omni-tags-faces)

(defface omni-tags-face-details
  '((t (:inherit omni-tags-face-default
                 :slant italic :foreground "LightSteelBlue1")))
  "Face used for addition details inside a tag"
  :group 'omni-tags-faces)

(defface omni-tags-face-separator
  '((t (:inherit omni-tags-face-default
                 :weight bold :foreground "OrangeRed1")))
  "Face used for trailing ponctuation"
  :group 'omni-tags-faces)

(defface omni-tags-face-ponctuation
  '((t (:inherit omni-tags-face-default
                 :weight bold :foreground "red3"))) ;§check:bold working.
  "Face used for the separators inside a tag"
  :group 'omni-tags-faces)


(provide 'omni-tags-face)

;;; omni-tags-face.el ends here
