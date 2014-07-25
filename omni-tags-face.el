;;; Specials faces for `omni-tags-mode'
;;; `ot' is the namepace prefix

;; fichier temporaire pour la définition de mes faces perso:
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Defining-Faces.html#Defining-Faces
;; §TD:adddoc!! change default
;; Each of these symbols is both a face name, and a variable whose default value is the symbol itself.

;; §maybe: pass color as custom. (at least mine. haha.
;; §maybe: switch about face occurs here? (option require?)
;; §maybe: speify mode according light/dark. and tty.

;; docs:
(setq doc:symbol "Face used for the tag symbol (leading character)"
      doc:symbols "Face used for the consecutive tag symbols"
      doc:name "Face used for the first keyword of the tag"
      doc:separation "Face used for the separators inside a tag" ;§maybe: rename to separator
      doc:ponctuation "Face used for trailing ponctuation"
      doc:details "Face used for addition details inside a tag")
;; ¤maybe: add reference to the mode?
;; ¤why:warningfree variable? §maybe: pass to let?
;; ¤see: trailing dot?

;; §TODO: def group

(defvar ot:tag-symbol-face 'ot:tag-symbol-face doc:symbol)
(defface ot:tag-symbol-face
  '((t (:inherit font-lock-keyword-face
		 :weight bold :foreground "DeepSkyBlue2")))
  doc:symbol
  :group 'font-lock-faces) ;; §maybe: change group: use omni-tag one. (not that need of this inheritence anymore.-> maybe create support)

(defvar  ot:tag-symbols-face 'ot:tag-symbols-face doc:symbols)
(defface ot:tag-symbols-face
  '((t (:inherit font-lock-keyword-face
		 :weight bold :foreground "DeepSkyBlue3")))
  doc:symbols
  :group 'font-lock-faces)

(defvar  ot:name-face 'ot:name-face doc:name)
(defface ot:name-face
  '((t (:inherit font-lock-type-face ;§maybe reverse then
		 :weight bold :foreground "SteelBlue1"   )))
  doc:name
  :group 'font-lock-faces)

(defvar  ot:details-face 'ot:details-face doc:details)
(defface ot:details-face
  '((t (:inherit font-lock-comment-delimiter-face ;§maybe change
		 :slant italic :foreground "LightSteelBlue1" )))
  doc:details
  :group 'font-lock-faces)

(defvar ot:ponctuation-face 'ot:ponctuation-face doc:ponctuation)
(defvar  ot:ponctuation-face 'ot:ponctuation-face)
(defface ot:ponctuation-face
  '((t (:inherit font-lock-warning-face
		   :weight bold :foreground "red3")))
  doc:ponctuation
  :group 'font-lock-faces)

(defvar  ot:separation-face 'ot:separation-face doc:separation)
(defface ot:separation-face
  '((t (:inherit font-lock-warning-face
		 :weight bold :foreground "OrangeRed1" )))
  doc:separation
  :group 'font-lock-faces)

(provide 'omni-tags-face)
