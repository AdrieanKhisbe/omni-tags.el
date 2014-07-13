;;; By Adriean Khisbe
;;; §building: for nom, just import

(require 'pcre2el)
(require 'mypersonaltagface)

;; §doc: HOW: default: at begining: set:ecrase, othervalues: at the end
;; §TOFIX: inorg comment not working!
;; §TOFIX: Make it appear in comment!!!
;; §TF! ?? what _ symbolize in regexp? match ;?
;; §TD: make list of different keyword, more highlighted! for instance: TD TF TI TM


;; §see: name?
(defvar mt:primary-tag "§" "Tag primaire. (associé aux actions)")
(defvar mt:secondary-tag "¤" "Tag secondaire. (associé aux descriptions)")
;; todo: add   :type 'boolean  :group 'linum)

(defvar mt:font-lock-mode t "Flag to use font lock face (until overiding is fix)")


;; Factorisation des noms de font pour facilement switcher
;; §fontlist: mytag-tagsymbol mytag-tagsymbols mytag-ponctuation mytag-separation mytag-name mytag-details
(if (not mt:font-lock-mode)
    (setq mt:fsymb mytag-tagsymbol
	  mt:fsymbss mytag-tagsymbols
	  mt:fponct mytag-ponctuation
	  mt:fsep mytag-separation
	  mt:fname mytag-name
	  mt:fd mytag-details)
  (setq mt:fsymb font-lock-keyword-face
	mt:fsymbss font-lock-keyword-face
	mt:fponct font-lock-warning-face
	mt:fsep font-lock-warning-face
	mt:fname font-lock-type-face
	mt:fdet font-lock-comment-delimiter-face))
;; note: local variables, not exported
;; §todo: defface inheritance! (maybe fix priority of face)

(defvar mt:tag-patterns nil "Ensemble des patterns à matcher")
;; §HERE : todo ;: créer variables spécifiques: single, composed, complex.
;; § voir comment late bind le tag

;; (defvar mt:pattern-simple  "Pattern for single" )
(defun mt:make-pattern (regexp)
  "Create a pattern. Replace first %s with tag symbol, and convert pcre format to emacs regexp"
  (rxt-pcre-to-elisp (format regexp (format "(%s+|%s+)" mt:primary-tag mt:secondary-tag)))
  )

;;; Keywords Definition:

;; §doc: Keyword: form: more doc at `font-lock-keywords'
;; MATCH-HIGHLIGH (SUBEXP FACENAME [OVERRIDE [LAXMATCH]])
;; override: t:overidde, append/preprend: merge of existing fontification!
;; use prepend to "override" comment face  §idea: make this behavior configurable
;; LAXMATCH: dont throw error if a sibexp is not matchd

(defvar mt:tag-wonder-keyword
  `(,(mt:make-pattern "%s([!?¿¡]+)");; §TODO: extract to var
    (1 mt:fsymb t)
    (2 mt:fponct t))
  "wonder/expression tag")
;; §maybe; extract defintion in function to enable to reevalute it (after change pattern)

(defvar mt:tag-detailed-keyword
  `(,(mt:make-pattern "%s(['@\-_ [:alnum:]]+)(([:])([_,-;/[:alnum:]]+))*([:?!¡¿]+)?")
    ;; §tofix: combo a:b:c
    (1 mt:fsymb t)
    (2 mt:fname t)
    (4 mt:fsep t "laxmatch")
    (5 mt:fdet t "lax")
    (6 mt:fponct t "laxmatch"))
  "Complex Tag §TD: repeat the same one without quotes")

;; New tags to create
;; §maybe: final : that match till the end of line
;;§todo: symple tag not in bold


;; §note: peut etre à supprimer
(setq mt:tag-patterns
      `(
	;; online si pas de sousexpr
	( ,(mt:make-pattern "%s:\w*>")  . 'font-lock-warning-face) ; Inline, MArche en principe, pattern tofix
	,mt:tag-detailed-keyword
	,mt:tag-wonder-keyword
	))

  ;;; Coloration des tags des tags
(defun mt:font-on ()
  "adds font-lock for my personals §Tags"                                       ;
  (font-lock-add-keywords
   nil  ; §doc: Mode, if nil means that it's applied to current buffer. otherwise specify mode
   mt:tag-patterns))

(defun mt:font-off ()
  "Remove font-lock for my personals §Tags"                                       ;
  (font-lock-add-keywords nil mt:tag-patterns))

  ;;; ¤* Utils fonctions
;; §todo: autoload
(defun mt:occur-tags ()
  "Call occur on My §tags"
  (interactive)
  (occur "§\\w+" )) ;; §TODO: use pattern!
;; §next with helm ;moccur...
;; couper en deux avec 1&2ary?

;; §todo:AA!! fail gracely
;; cycle?
(defun mt:next-tags ()
  "Go to next §tags"
  (interactive)
 (unless (search-forward-regexp "§\\w+" nil t)
   (message "No More Founds Tags!")))
;; §maybe: si ressaye, revient au début?

(defun mt:previous-tags ()
  "Go to prev §tags"
  (interactive)
 (unless (search-forward-regexp "§\\w+" nil t)
   (message "No Tags Before!")))


;; §todo: impr: message erreur
;; org opening of folding
;; §next: tagpuration?
;; §idée: move dans `mt:default-config' ?
;; §TODO: proposer dans la documentation un use!!

;;;###autoload
(define-minor-mode mytag-mode
  "Colorize 'Personal tags' in the buffer."
  :lighter " §"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map (kbd "M-§") 'mt:next-tags)
	    (define-key map (kbd "C-§") 'mt:previous-tags)
	    (define-key map (kbd "C-M-§") 'mt:occur-tags)
            map)
  (progn (if mytag-mode
	     (mt:font-on)
	   (mt:font-off))))

(add-hook 'org-mode-hook 'mytag-mode)
(add-hook 'prog-mode-hook 'mytag-mode)

(provide 'mytag-mode)
