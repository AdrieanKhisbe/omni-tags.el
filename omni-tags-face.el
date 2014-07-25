;;; Specials faces for `omni-tags-mode'
;;; `ot' is the namepace prefix

;; §maybe: pass color as custom. (at least mine. haha.)
;; §maybe: switch about face occurs here? (option require?)
;; §maybe: specify mode according light/dark. and tty.

;; ¤maybe:doc add reference to the mode?
;;        trailing dot?
;; ¤maybe:renaming with other naming scheme `ot:face:'

;; §TODO: def group

;; ¤note: defface variable with value is symbol (itself)
(defface ot:tag-symbol-face
  '((t (:inherit font-lock-keyword-face
		 :weight bold :foreground "DeepSkyBlue2")))
  "Face used for the tag symbol (leading character)"
  :group 'font-lock-faces) ;; §maybe: change group: use omni-tag one. (not that need of this inheritence anymore.-> maybe create support)

(defface ot:tag-symbols-face
  '((t (:inherit font-lock-keyword-face
		 :weight bold :foreground "DeepSkyBlue3")))
  "Face used for the consecutive tag symbols"
  :group 'font-lock-faces)

(defface ot:name-face
  '((t (:inherit font-lock-type-face ;§maybe reverse then
		 :weight bold :foreground "SteelBlue1"   )))
  "Face used for the first keyword of the tag"
  :group 'font-lock-faces)

(defface ot:details-face
  '((t (:inherit font-lock-comment-delimiter-face ;§maybe change
		 :slant italic :foreground "LightSteelBlue1" )))
  "Face used for addition details inside a tag"
  :group 'font-lock-faces)

(defface ot:ponctuation-face
  '((t (:inherit font-lock-warning-face
		 :weight bold :foreground "red3")))
  "Face used for the separators inside a tag"
  :group 'font-lock-faces)

(defface ot:separation-face
  '((t (:inherit font-lock-warning-face
		 :weight bold :foreground "OrangeRed1" )))
  "Face used for trailing ponctuation"
  :group 'font-lock-faces)

(provide 'omni-tags-face)
