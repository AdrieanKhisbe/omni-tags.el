;;; Specials faces for `omni-tags-mode'
;;; `ot' is the namepace prefix

;; §maybe: pass color as custom. (at least mine. haha.)
;; §maybe: switch about face occurs here? (option require?)
;; §maybe: specify mode according light/dark. and tty.

;; ¤maybe:doc add reference to the mode?
;;        trailing dot?
;; ¤maybe:renaming with other naming scheme `ot:face:'

(defgroup omni-tags-face nil
  "Faces for `omni-tags'."
  :group 'omni-tags)

;; ¤note: defface variable with value is symbol (itself)
(defface ot:tag-symbol-face
  '((t (:inherit font-lock-keyword-face  ; §todo:maybe change inheritence
		 :weight bold :foreground "DeepSkyBlue2"))) ;; §maybe: change with tags [and tag darker]
  "Face used for the tag symbol (leading character)"
  :group 'omni-tags-faces)

(defface ot:tag-symbols-face
  '((t (:inherit font-lock-keyword-face
		 :weight bold :foreground "DeepSkyBlue3")))
  "Face used for the consecutive tag symbols"
  :group 'omni-tags-faces)

(defface ot:name-face
  '((t (:inherit font-lock-type-face ;§maybe reverse then
		 :weight bold :foreground "SteelBlue1"   )))
  "Face used for the first keyword of the tag"
  :group 'omni-tags-faces)

(defface ot:details-face
  '((t (:inherit font-lock-comment-delimiter-face ;§maybe change
		 :slant italic :foreground "LightSteelBlue1" )))
  "Face used for addition details inside a tag"
  :group 'omni-tags-faces)

(defface ot:ponctuation-face
  '((t (:inherit font-lock-warning-face
		 :weight bold :foreground "red3")))
  "Face used for the separators inside a tag"
  :group 'omni-tags-faces)

(defface ot:separation-face
  '((t (:inherit font-lock-warning-face
		 :weight bold :foreground "OrangeRed1" )))
  "Face used for trailing ponctuation"
  :group 'omni-tags-faces)

(provide 'omni-tags-face)
