;;; §todo: header!!
;;; By Adriean Khisbe
;;; §building: for nom, just import

(require 'pcre2el) ;§maybe: only use in development for starting performance issue
(require 'omni-tags-face)

;; §TOFIX: Make it appear in org comment!!! (probably something to see with `org-mode')
;; §Tose! ?? what _ symbolize in regexp? match ;?
;; §Todo: make list of different keyword, more highlighted! for instance: TD TF TI TM

;; ¤> Customs
(defgroup omni-tags nil
  "Customs for `omni-tags' modes."
  );; :group 'tools ¤maybe

(defcustom ot:primary-tag "§" "Primary Tag Symbol (associated with actions)"
  :type 'string  :group 'omni-tags) ; §maybe:char? ;§todo:add syze constraint
(defcustom ot:secondary-tag "¤" "Secondary Tag Symbol. (associated with descriptions)"
  :type 'string  :group 'omni-tags)
;; ¤maybe: special tag for headings? [and special face: easier to identify: for navigation, map..]

(defvar ot:tag-patterns nil "Ensemble des patterns à matcher")
;; §HERE : todo ;: créer variables spécifiques: single, composed, complex.
;; §see comment late bind le tag. [ ou refresh ]

(defvar ot:override t "Value to use in keyword pattern: possible value: t,append/prepend") ;; try change
(defconst ot:optional "laxmatch" "Specify that this part of the keyword is not compulsary")

;; ¤maybe (defvar ot:pattern-simple  "Pattern for single" )
;; maybe could enforce number of matching () to validate a pattern [speial vaildation function for custom]

(defun ot:make-pattern (regexp)
  "Create a pattern. Replace first %s with tag symbol, and convert pcre format to emacs regexp"
  (rxt-pcre-to-elisp (format regexp (format "(%s+|%s+)" ot:primary-tag ot:secondary-tag)))
  ;; §maybe: get ride of pcre2el dependecy?
  )

;;; Keywords Definition:

;; ¤doc: Keyword: form: more doc at `font-lock-keywords'
;; MATCH-HIGHLIGH (SUBEXP FACENAME [OVERRIDE [LAXMATCH]])
;; override: t:overidde, append/preprend: merge of existing fontification!
;; use prepend to "override" comment face  §idea: make this behavior configurable
;; LAXMATCH: dont throw error if a sibexp is not match

(defvar ot:tag-wonder-keyword
  `(,(ot:make-pattern "%s([!?¿¡]+)");; §TODO: extract to var
    (1 'ot:tag-symbol-face  ,ot:override)
    (2 'ot:ponctuation-face ,ot:override))
  "wonder/expression tag")
;; §maybe; extract defintion in function to enable to reevalute it (after change pattern)

(defvar ot:tag-detailed-keyword
  `(,(ot:make-pattern "%s(['@\-_ [:alnum:]]+)(([:])([_,-;/[:alnum:]]+))*([:?!¡¿]+)?")
    ;; §tofix: combo a:b:c
    (1 'ot:tag-symbol-face  ,ot:override)
    (2 'ot:name-face        ,ot:override)
    (4 'ot:ponctuation-face ,ot:override ,ot:optional)
    (5 'ot:details-face     ,ot:override ,ot:optional)
    (6 'ot:ponctuation-face ,ot:override ,ot:optional))
  "Complex Tag §todo: repeat the same one without quotes")

(defvar ot:tag-heading ;name to find
  `(,(rxt-pcre-to-elisp (format "(%s)(>+)" ot:secondary-tag))
    (1 'ot:tag-symbol-face  ,ot:override)
    (2 'ot:ponctuation-face ,ot:override)) ;§maybe: grab the rest of the line (eventual title)
  "heading tag")
;; §later: add funtions. and specific navigation to emulate org


;; New tags to create
;; §maybe: final : that match till the end of line
;; §todo: symple tag not in bold
;;        just symbol. <¤> <<¤>>
;; §note: peut etre à supprimer
(setq ot:tag-patterns
      (list
       ;; online si pas de sousexpr:
       ;; ( ,(ot:make-pattern "%s:\w*>")  . 'font-lock-warning-face) ; Inline, MArche en principe, pattern tofix
       ot:tag-detailed-keyword
       ot:tag-wonder-keyword
       ot:tag-heading
       ))

  ;;; Coloration des tags des tags
(defun ot:font-on ()
  "Adds font-lock for my personals §Tags"                                       ;
  (font-lock-add-keywords
   nil  ; ¤doc: Mode, if nil means that it's applied to current buffer. otherwise specify mode
   ot:tag-patterns)
  (font-lock-fontify-buffer))


(defun ot:font-off ()
  "Remove font-lock for my personals §Tags"
  (mapcar (lambda (keyword) (font-lock-add-keywords nil keyword)) ot:tag-patterns)
  (font-lock-fontify-buffer))

  ;;; ¤* Utils fonctions
;; §todo: autoload
(defun ot:occur-tags ()
  "Call occur on My §tags"
  (interactive)
  (push-mark)
  (occur "§\\w+" )) ;; §TODO: use pattern!
;; §next with helm ;moccur...
;; couper en deux avec 1&2ary?

;; §maybe cycle?
(defun ot:next-tags ()
  "Go to next §tags"
  (interactive)
  (push-mark) ;; §maybe: not if previous command was either next/previous tag? ¤maybe: configurable behavior?
  ;; §maybe: special mark ring?
  (unless (search-forward-regexp "§\\w+" nil t)
    ;;§todo: make generic to adapt to tag symbol: : default arg symbol (that would be call by next-primary/secondary)
    (message "No More Founds Tags!")))
;; §maybe: si ressaye, revient au début?

(defun ot:previous-tags ()
  "Go to prev §tags"
  (interactive)
  (unless (search-backward-regexp "§\\w+" nil t)
    (message "No Tags Before!")))


;; §todo: impr: message erreur
;; org opening of folding
;; §next: tagpuration?
;; §idée: move dans `ot:default-config' ?
;; §TODO: proposer dans la documentation un use!!
;; §todo:  heading. fonctions pour naviguer.
;; map à prefix pour y associer un ensemblede fonction. ex: C-x § ou s-§

;; §later: add some simmbol in the fringe? ¤inspiration:gitgutter-flycheck-fixmargin
;; §maybe: do something with marks

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
