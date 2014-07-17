;;; Specials faces for `omni-tags-mode'
;;; `ot' is the namepace prefix

;; fichier temporaire pour la définition de mes faces perso:
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Defining-Faces.html#Defining-Faces
;; §TD:adddoc!! change default
;; Each of these symbols is both a face name, and a variable whose default value is the symbol itself.

;; §TD: add some doc, and `inheritance'! (might help to benefit from font look priority)

(defvar  ot:tag-symbol-face 'ot:tagsymbol-face)
(defface ot:tag-symbol-face
  '((t (:weight bold :color "DeepSkyBlue2")))
  "Font Lock mode face used for begining of a tag."
  :group 'font-lock-faces) ;; §maybe: change group?

(defvar  ot:tag-symbols-face  'ot:tagsymbols-face )
(defface ot:tag-symbols-face
  '((t (:weight bold :color "DeepSkyBlue3")))    nil    :group 'font-lock-faces) ;doc to create

(defvar  ot:name-face 'ot:name-face	)
(defface ot:name-face
  '((t (:weight bold :color "SteelBlue1"   )))    nil    :group 'font-lock-faces) ;doc to create

(defvar  ot:details-face 'ot:details-face	)
(defface ot:details-face
  '((t (:slant italic :color "LightSteelBlue1" )))    nil    :group 'font-lock-faces) ;doc to create

(defvar  ot:ponctuation-face 'ot:ponctuation-face)
(defface ot:ponctuation-face
  '((t (:weight bold :color "red3")))    nil    :group 'font-lock-faces) ;doc to create

(defvar  ot:separation-face 'ot:separation-face)
(defface ot:separation-face
  '((t (:weight bold :color "OrangeRed1" )))    nil    :group 'font-lock-faces) ;doc to create

(provide 'mytag-face)
