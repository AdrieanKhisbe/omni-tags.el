;;; Specials faces for `omni-tags-mode'
;;; `ot' is the namepace prefix

;; fichier temporaire pour la définition de mes faces perso:
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Defining-Faces.html#Defining-Faces
;; §TD:adddoc!! change default
;; Each of these symbols is both a face name, and a variable whose default value is the symbol itself.

;; §DOING: add some doc, and `inheritance'! (might help to benefit from font look priority)
;;         also copy paste doc in the defvar. (eventdualy defined doc in a (setq a b c d e f...=! :)
;; §maybe: pass color as custom. (at least mine. haha.
;; §maybe: switch about face occurs here? (option require?)

;; §TODO: def group
(defvar ot:tag-symbol-face 'ot:tag-symbol-face)
(defface ot:tag-symbol-face
  '((t (:inherit font-lock-keyword-face
		 :weight bold :foreground "DeepSkyBlue2")))
  "Font Lock mode face used for begining of a tag."
  :group 'font-lock-faces) ;; §maybe: change group: use omni-tag one. (not that need of this inheritence anymore.-> maybe create support)

(defvar  ot:tag-symbols-face 'ot:tag-symbols-face)
(defface ot:tag-symbols-face
  '((t (:inherit font-lock-keyword-face
		 :weight bold :foreground "DeepSkyBlue3")))
  "§TODOC"
  :group 'font-lock-faces)

(defvar  ot:name-face 'ot:name-face)
(defface ot:name-face
  '((t (:inherit font-lock-type-face ;§maybe reverse then
		 :weight bold :foreground "SteelBlue1"   )))
  "§TODOC"
  :group 'font-lock-faces)

(defvar  ot:details-face 'ot:details-face)
(defface ot:details-face
  '((t (:inherit font-lock-comment-delimiter-face ;§maybe change
		 :slant italic :foreground "LightSteelBlue1" )))
  "§TODOC"

  :group 'font-lock-faces)

(defvar ot:ponctuation-face 'ot:ponctuation-face)

(defvar  ot:ponctuation-face 'ot:ponctuation-face)
(defface ot:ponctuation-face
  '((t (:inherit font-lock-warning-face
		   :weight bold :foreground "red3")))
  "§TODOC"
  :group 'font-lock-faces)

(defvar  ot:separation-face 'ot:separation-face)
(defface ot:separation-face
  '((t (:inherit font-lock-warning-face
		 :weight bold :foreground "OrangeRed1" )))
  "§TODOC"
  :group 'font-lock-faces)

(provide 'omni-tags-face)
