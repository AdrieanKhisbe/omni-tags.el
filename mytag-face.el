;; fichier temporaire pour la définition de mes faces perso:
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Defining-Faces.html#Defining-Faces
;; §TD:adddoc!! change default
;; Each of these symbols is both a face name, and a variable whose default value is the symbol itself.

; §TD: add some doc, and inheritance!

(defvar  mytag-tagsymbol 'mytag-tagsymbol)
(defface mytag-tagsymbol
  '((t (:weight bold :color "DeepSkyBlue2")))
  "Font Lock mode face used for begining of a tag."
  :group 'font-lock-faces)

(defvar  mytag-tagsymbols  'mytag-tagsymbols )
(defface mytag-tagsymbols
  '((t (:weight bold :color "DeepSkyBlue3")))    nil    :group 'font-lock-faces) ;doc to create

(defvar  mytag-name 'mytag-name	)
(defface mytag-name
  '((t (:weight bold :color "SteelBlue1"   )))    nil    :group 'font-lock-faces) ;doc to create

(defvar  mytag-details 'mytag-details	)
(defface mytag-details
  '((t (:slant italic :color "LightSteelBlue1" )))    nil    :group 'font-lock-faces) ;doc to create

(defvar  mytag-ponctuation 'mytag-ponctuation)
(defface mytag-ponctuation
  '((t (:weight bold :color "red3")))    nil    :group 'font-lock-faces) ;doc to create

(defvar  mytag-separation 'mytag-separation)
(defface mytag-separation
  '((t (:weight bold :color "OrangeRed1" )))    nil    :group 'font-lock-faces) ;doc to create


(provide 'mytag-face)
