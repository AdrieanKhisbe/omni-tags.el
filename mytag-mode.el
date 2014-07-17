;;; By Adriean Khisbe
;;; §building: for nom, just import

(require 'pcre2el) ;§maybe: only use in development for starting performance issue
(require 'mypersonaltagface)

;; §doc: HOW: default: at begining: set:ecrase, othervalues: at the end
;; §TOFIX: inorg comment not working!
;; §TOFIX: Make it appear in comment!!!
;; §TF! ?? what _ symbolize in regexp? match ;?
;; §TD: make list of different keyword, more highlighted! for instance: TD TF TI TM

;; §see: name?
(defvar ot:primary-tag "§" "Tag primaire. (associé aux actions)")
(defvar ot:secondary-tag "¤" "Tag secondaire. (associé aux descriptions)")
;; todo: add   :type 'boolean  :group 'linum)

(defvar ot:font-lock-mode t "Flag to use font lock face (until overiding is fix)")

;; Factorisation des noms de font pour facilement switcher
;; §fontlist:(original) mytag-tagsymbol mytag-tagsymbols mytag-ponctuation mytag-separation mytag-name mytag-details

(if (not ot:font-lock-mode)
    (setq ot:fsymb ot:tag-symbol-face
	  ot:fsymbss ot:tag-symbols-face
	  ot:fponct ot:ponctuation-face
	  ot:fsep ot:separation-face
	  ot:fname ot:name-face
	  ot:fd ot:details-face)
  (setq ot:fsymb font-lock-keyword-face
	ot:fsymbss font-lock-keyword-face
	ot:fponct font-lock-warning-face
	ot:fsep font-lock-warning-face
	ot:fname font-lock-type-face
	ot:fdet font-lock-comment-delimiter-face))
;; note: local variables, not exported
;; §todo: defface inheritance! (maybe fix priority of face)

(defvar ot:tag-patterns nil "Ensemble des patterns à matcher")
;; §HERE : todo ;: créer variables spécifiques: single, composed, complex.
;; § voir comment late bind le tag

;; (defvar ot:pattern-simple  "Pattern for single" )
(defun ot:make-pattern (regexp)
  "Create a pattern. Replace first %s with tag symbol, and convert pcre format to emacs regexp"
  (rxt-pcre-to-elisp (format regexp (format "(%s+|%s+)" ot:primary-tag ot:secondary-tag)))
  )

;;; Keywords Definition:

;; §doc: Keyword: form: more doc at `font-lock-keywords'
;; MATCH-HIGHLIGH (SUBEXP FACENAME [OVERRIDE [LAXMATCH]])
;; override: t:overidde, append/preprend: merge of existing fontification!
;; use prepend to "override" comment face  §idea: make this behavior configurable
;; LAXMATCH: dont throw error if a sibexp is not matchd

(defvar ot:tag-wonder-keyword
  `(,(ot:make-pattern "%s([!?¿¡]+)");; §TODO: extract to var
    (1 ot:fsymb t)
    (2 ot:fponct t))
  "wonder/expression tag")
;; §maybe; extract defintion in function to enable to reevalute it (after change pattern)

(defvar ot:tag-detailed-keyword
  `(,(ot:make-pattern "%s(['@\-_ [:alnum:]]+)(([:])([_,-;/[:alnum:]]+))*([:?!¡¿]+)?")
    ;; §tofix: combo a:b:c
    (1 ot:fsymb t)
    (2 ot:fname t)
    (4 ot:fsep t "laxmatch")
    (5 ot:fdet t "lax")
    (6 ot:fponct t "laxmatch"))
  "Complex Tag §TD: repeat the same one without quotes")

;; New tags to create
;; §maybe: final : that match till the end of line
;;§todo: symple tag not in bold


;; §note: peut etre à supprimer
(setq ot:tag-patterns
      `(
	;; online si pas de sousexpr
	( ,(ot:make-pattern "%s:\w*>")  . 'font-lock-warning-face) ; Inline, MArche en principe, pattern tofix
	,ot:tag-detailed-keyword
	,ot:tag-wonder-keyword
	))

  ;;; Coloration des tags des tags
(defun ot:font-on ()
  "adds font-lock for my personals §Tags"                                       ;
  (font-lock-add-keywords
   nil  ; §doc: Mode, if nil means that it's applied to current buffer. otherwise specify mode
   ot:tag-patterns))

(defun ot:font-off ()
  "Remove font-lock for my personals §Tags"                                       ;
  (font-lock-add-keywords nil ot:tag-patterns))

  ;;; ¤* Utils fonctions
;; §todo: autoload
(defun ot:occur-tags ()
  "Call occur on My §tags"
  (interactive)
  (occur "§\\w+" )) ;; §TODO: use pattern!
;; §next with helm ;moccur...
;; couper en deux avec 1&2ary?

;; §todo:AA!! fail gracely
;; cycle?
(defun ot:next-tags ()
  "Go to next §tags"
  (interactive)
 (unless (search-forward-regexp "§\\w+" nil t)
   (message "No More Founds Tags!")))
;; §maybe: si ressaye, revient au début?

(defun ot:previous-tags ()
  "Go to prev §tags"
  (interactive)
 (unless (search-forward-regexp "§\\w+" nil t)
   (message "No Tags Before!")))


;; §todo: impr: message erreur
;; org opening of folding
;; §next: tagpuration?
;; §idée: move dans `ot:default-config' ?
;; §TODO: proposer dans la documentation un use!!

;;;###autoload
(define-minor-mode omni-tags-mode
  "Colorize 'Personal tags' in the buffer."
  :lighter " §"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map (kbd "M-§") 'ot:next-tags)
	    (define-key map (kbd "C-§") 'ot:previous-tags)
	    (define-key map (kbd "C-M-§") 'ot:occur-tags)
            map)
  (progn (if omni-tags-mode
	     (ot:font-on)
	   (ot:font-off))))

;; §config:
;; (add-hook 'org-mode-hook 'omni-tags-mode)
;; (add-hook 'prog-mode-hook 'omni-tags-mode)

(provide 'omni-tags)
