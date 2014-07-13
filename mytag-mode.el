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

;; §todo: tell appart (utiliser fonction pour générer la pattern (pase le préfixe))
(setq mt:tag-patterns
      `(
	;; §doc: Keyword: form: more doc at `font-lock-keywords'
	;; MATCH-HIGHLIGH (SUBEXP FACENAME [OVERRIDE [LAXMATCH]])
	;; override: t:overidde, append/preprend: merge of existing fontification!
	;; use prepend to "override" comment face  §idea: make this behavior configurable
	;; LAXMATCH: dont throw error if a sibexp is not matchd

	;; online si pas de sousexpr
	( ,(mt:make-pattern "%s:\w*>")  . 'font-lock-warning-face) ; Inline, MArche en principe, pattern tofix

	;; wonder/expression tag
	(,(mt:make-pattern "%s([!?¿¡]+)");; §TODO: extract to var
	  (1 mt:fsymb t)
	  (2 mt:fponct t))

	;;§todo: symple tag not in bold

	;; MultiTags §idea: separateur spécial pour faire tdu genre §todo-see

	;; Detailed Tags
	;; §original: \(§+\)\([[:alnum:]-_]+\)\(\(:\)\([[:alnum:],_-/;]+\)\)?\([!¡?¿:]+\)?
	;; §old: "\\(§+\\)\\(\\w+\\)\\(\\(:\\)\\(\\w+\\)\\)+\\([!?]+\\)?"

	;; Complex Tag §TD: repeat the same one without quotes
	(,(mt:make-pattern "%s(['@\-_ [:alnum:]]+)(([:])([_,-;/[:alnum:]]+))*([:?!¡¿]+)?")
	 ;; §tofix: combo a:b:c
	  (1 mt:fsymb t)
	  (2 mt:fname t)
	  (4 mt:fsep t "laxmatch")
	  (5 mt:fdet t "lax")
	  (6 mt:fponct t "laxmatch"))

	;; §maybe: final : that match till the end of line
	))

  ;;; Définition des tags
(defun add-personal-tags(); Tat
  "adds font-lock for my personals §Tags"                                       ;
  ;; §idea: sith for primary,seondart
  (font-lock-add-keywords
   nil  ; §doc: Mode, if nil means that it's applied to current buffer. otherwise specify mode
   mt:tag-patterns))
;; §idea: fonction à réappeler, pour ractuliser suite changement de config
;; (fonction regénérerais les variables)

  ;;; ¤* Utils fonctions
;; §todo: autoload
(defun occur-tags ()
  "Call occur on My §tags"
  (interactive)
  (occur "§\\w+" )) ;; §TODO: use pattern!
;;§fix?
;; couper en deux avec 1&2ary?

(defun next-tags ()
  "Go to next §tags"
  (interactive)
  (search-forward-regexp "§\\w+"))

(defun previous-tags ()
  "Go to prev §tags"
  (interactive)
  (search-forward-regexp "§\\w+"))

;; §todo: impr: message erreur
;; org opening of folding
;; §next: tagépuration?

(global-set-key (kbd "M-§") 'next-tags)
(global-set-key (kbd "C-§") 'previous-tags)
(global-set-key (kbd "C-M-§") 'occur-tags)

;; §todo; create minor mode
;; move to hook?
;; §idée: move dans `mt:default-config' ?
;; §TODO: proposer dans la documentation un use!!
(add-hook 'org-mode-hook 'add-personal-tags)
(add-hook 'prog-mode-hook 'add-personal-tags)

(provide 'mytag-mode)
