;;; §building: for nom, just import


(require 'mypersonaltagface)

  ;;; Définition des tags
(defun add-personal-tags(); Tat
  "adds font-lock for my personals §Tags"                                       ;
  (font-lock-add-keywords
   nil  ; §doc: Mode, if nil means that it's applied to current buffer. otherwise specify mode
   '(
     ;; §doc: Keyword: form: more doc at =font-lock-keywords=
     ;; Regexp or matcher(function to search)
     ;; (regexp-opt)
     ;; MATCH-HIGHLIGH (SUBEXP FACENAME [OVERRIDE [LAXMATCH]])
     ;; override: t:overidde, append/preprend: merge of existing fontification!
     ;; LAXMATCH: dont throw error if a sibexp is not matchd

     ;; online si pas de sousexpr
     ;;   ( "§+\\w*\\>"  . 'change-log-list-face ) ; Inline, to test

     ;; §fontlist: mytag-tagsymbol mytag-tagsymbols mytag-ponctuation mytag-separation mytag-name mytag-details
     ;; §todo: defface inheritance!
     ;; §test function

     ("\\(§+\\)\\(tartiflette\\|choucroute\\)\\>"
      (1 mytag-tagsymbol append)
      (2 mytag-name t))
     ;; wonder/expression tag
     ( "\\(§+\\)\\([!?¿¡]+\\)"
       (1 mytag-tagsymbol append)
       (2 mytag-name  append)
       )

     ;; MultiTags!!
     ;; §original: \(§+\)\([[:alnum:]-_]+\)\(\(:\)\([[:alnum:],_-/;]+\)\)?\([!¡?¿:]+\)?
     ;;§old: "\\(§+\\)\\(\\w+\\)\\(\\(:\\)\\(\\w+\\)\\)+\\([!?]+\\)?"

     ;; Complex Tag §TD: repeat the same one without quotes
     ( "\\(§+\\)\\([[:alnum:]-_@ ']+\\)\\(\\(:\\)\\([[:alnum:],_-/;]+\\)\\)?\\([!¡?¿:]+\\)?"
       ;; §tovar!!
       (1 font-lock-keyword-face prepend) ;§test:append
       (2 font-lock-comment-delimiter-face  prepend)
       (4 font-lock-warning-face  prepend  "l")
       (5 font-lock-type-face   prepend "l")
       (6 font-lock-warning-face prepend "l")
       ;;§TOFIX!
       ;;    (1 mytag-tagsymbol append) ;§test:append
       ;;    (2 mytag-name append)
       ;;    (4 mytag-separation  append "laxmatch")
       ;;    (5 mytag-details append "lax")
       ;;    (6 mytag-ponctuation append "laxmatch")
       ) ;;
     )
   )
  ;; §doc: HOW: default: at begining: set:ecrase, othervalues: at the end
  ;; §TOFIX: inorg commment not working!
  ;; §TOFIX: Make it appear in comment!!!
  ;; §TF! ?? what _ symbolisze in regexp? match ;?
  ;; §TD: make list of different keyword, more highlighted! TD TF TI TM
  )

  ;;; Utils fonctions

(defun occur-tags ()
  "Call occur on My §tags"
  (interactive)
  (occur "§\\w+"))
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

(add-hook 'org-mode-hook 'add-personal-tags)
(add-hook 'prog-mode-hook 'add-personal-tags)

(provide 'mytag-mode)
