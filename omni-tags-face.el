;;; Specials faces for `omni-tags-mode'
;;; `ot' is the namepace prefix

;; fichier temporaire pour la définition de mes faces perso:
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Defining-Faces.html#Defining-Faces
;; §TD:adddoc!! change default
;; Each of these symbols is both a face name, and a variable whose default value is the symbol itself.

;; §maybe: pass color as custom. (at least mine. haha.
;; §maybe: switch about face occurs here? (option require?)
;; §maybe: specify mode according light/dark. and tty.

;; docs:

;; ¤maybe: add reference to the mode?
;; ¤why:warningfree variable? §maybe: pass to let?
;; ¤see: trailing dot?

;; §TODO: def group

(defface ot:tag-symbol-face
  '((t (:inherit font-lock-keyword-face
		 :weight bold :foreground "DeepSkyBlue2")))
  "Face used for the tag symbol (leading character)"
  :group 'font-lock-faces) ;; §maybe: change group: use omni-tag one. (not that need of this inheritence anymore.-> maybe create support)

(defvar  ot:tag-symbols-face 'ot:tag-symbols-face doc:symbols)
(defface ot:tag-symbols-face
  '((t (:inherit font-lock-keyword-face
		 :weight bold :foreground "DeepSkyBlue3")))
"Face used for the consecutive tag symbols"
  :group 'font-lock-faces)

(defvar  ot:name-face 'ot:name-face doc:name)
(defface ot:name-face
  '((t (:inherit font-lock-type-face ;§maybe reverse then
		 :weight bold :foreground "SteelBlue1"   )))
"Face used for the first keyword of the tag"
  :group 'font-lock-faces)

(defvar  ot:details-face 'ot:details-face doc:details)
(defface ot:details-face
  '((t (:inherit font-lock-comment-delimiter-face ;§maybe change
		 :slant italic :foreground "LightSteelBlue1" )))
"Face used for addition details inside a tag"
  :group 'font-lock-faces)

(defvar  ot:ponctuation-face 'ot:ponctuation-face)
(defface ot:ponctuation-face
  '((t (:inherit font-lock-warning-face
		   :weight bold :foreground "red3")))
"Face used for the separators inside a tag"
  :group 'font-lock-faces)

(defvar  ot:separation-face 'ot:separation-face doc:separation)
(defface ot:separation-face
  '((t (:inherit font-lock-warning-face
		 :weight bold :foreground "OrangeRed1" )))
  "Face used for trailing ponctuation"
  :group 'font-lock-faces)

(provide 'omni-tags-face)
