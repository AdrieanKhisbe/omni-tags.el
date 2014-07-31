;;; omni-tags.el --- ¤Highlight and §Actions for 'Tags'
;;
;; Copyright (C) 2014 Adrien Becchis
;;
;; Author: Adrien Becchis <adriean.khisbe@live.fr>
;; Created: ...
;; Version: 0.1
;; Package-Requires: ((pcre2el "1.7"))
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:
;; §todo: install
;; §todo.. [maybe rebuilt from readme?]


;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.



;;; Code:

(require 'pcre2el) ;§maybe: only use in development for starting performance issue
(require 'omni-tags-face)
(require 'omni-tags-navigation)

;; §TOFIX: Make it appear in org comment!!! (probably something to see with `org-mode')
;; §Tose! ?? what _ symbolize in regexp? match ;?
;; §Todo: make list of different keyword, more highlighted! for instance: TD TF TI TM

;; ¤> Customs
(defgroup omni-tags nil
  "Customs for `omni-tags' modes."
  :group 'convenience) ; ¤note: hesitated with tools

(defcustom ot:primary-tag "§" "Primary Tag Symbol (associated with actions)."
  :type 'string  :group 'omni-tags) ; §maybe:char? ;§todo:add syze constraint

(defcustom ot:secondary-tag "¤" "Secondary Tag Symbol (associated with descriptions)."
  :type 'string  :group 'omni-tags)
;; ¤maybe: special tag for headings? [and special face: easier to identify: for navigation, map..]

(defvar ot:tag-patterns nil "Ensemble des patterns à matcher.")
;; §HERE : todo ;: créer variables spécifiques: single, composed, complex.
;; §see comment late bind le tag. [ ou refresh ]

(defvar ot:override t
  "Value to use in keyword pattern, possible values:
- t: override existing fontification
- append/prepend: merge of existing fontification (prepend comes first)

- keep: only parts not already fontified are highlighted") ;; ¤maybe:try change
(defconst ot:optional "laxmatch"
  "Specify that this part of the keyword is not compulsary: don't throw error if a subexp is not match.")

;; ¤maybe (defvar ot:pattern-simple  "Pattern for single" )
;; maybe could enforce number of matching () to validate a pattern [special vaildation function for custom]

(defun ot:make-pattern (regexp)
  "Create a pattern.  Replace first %s with tag symbol, and convert REGEXP writen in pcre format to Emacs regexp."
  (rxt-pcre-to-elisp (format regexp (format "(%s+|%s+)" ot:primary-tag ot:secondary-tag)))
  ;; §maybe: get ride of pcre2el dependecy?
  )

;;; ¤> Keywords Definition:

;; ¤doc: Keyword: form: more doc at `font-lock-keywords'
;; MATCH-HIGHLIGH (SUBEXP FACENAME [OVERRIDE [LAXMATCH]])

(defvar ot:tag-wonder-keyword
  `(,(ot:make-pattern "%s([!?¿¡]+)");; §TODO: extract to custom
    (1 'ot:face:symbol  ,ot:override)
    (2 'ot:face:ponctuation ,ot:override))
  "Wonder/expression tag.")
;; §maybe; extract defintion in function to enable to reevalute it (after change pattern)

(defvar ot:tag-detailed-keyword
  `(,(ot:make-pattern "%s(['@\-_ [:alnum:]]+)(([:])([_,-;/[:alnum:]]+))*([?!¡¿]+)?") ;§todo: exlude :
    ;; §tofix: combo a:b:c -> might need to specify something. or hackyhacky for combo.
    (1 'ot:face:symbol      ,ot:override)
    (2 'ot:face:name        ,ot:override)
    (4 'ot:face:separator   ,ot:override ,ot:optional) ;§maybe, delete (), and use wrapping.
    (5 'ot:face:details     ,ot:override ,ot:optional)
    (6 'ot:face:ponctuation ,ot:override ,ot:optional))
  "Complex Tag §todo: repeat the same one without quotes")

(defvar ot:whatever-follow-keyword ;§torename
  `(,(ot:make-pattern "%s(['@\-_ [:alnum:]]+)(:)( [^¤§]*|$)")
    ;; §TODO: extract to custom [word components and so
    (1 'ot:face:symbol      ,ot:override)
    (2 'ot:face:name        ,ot:override)
    (3 'ot:face:separator   ,ot:override) ;§maybe, delete (), and use wrapping.
    (4 'ot:face:details     ,ot:override ,ot:optional))
  "Wonder/expression tag.")
;; §maybe; extract defintion in function to enable to reevalute it (after change pattern)


(defvar ot:tag-heading ;name to find
  `(,(rxt-pcre-to-elisp (format "(%s)(>+)" ot:secondary-tag))
    (1 'ot:face:symbol  ,ot:override) ;§maybe: try <¤>
    (2 'ot:face:ponctuation ,ot:override)) ;§maybe: grab the rest of the line (eventual title)
  "heading tag")

;; §later: add funtions. and specific navigation to emulate org

;; ¤note: New tags to create
;; §todo: symple tag not in bold
;;        just symbol. <¤> <<¤>>
;;        place holder. (temporary): (¤) [¤] {¤}
;;        wrapped tag:  [§ abcb ]

(setq ot:tag-patterns
      (list `(,ot:primary-tag  . 'ot:face:symbol) ; Inline
	    ot:tag-detailed-keyword
	    ot:tag-wonder-keyword
	    ot:tag-heading
	    ot:whatever-follow-keyword
	    ))

  ;;; Coloration des tags des tags
(defun ot:font-on ()
  "Add fontifications for `omni-tags'.
Keywords are stored in list `ot:tag-patterns'."
  (font-lock-add-keywords
   nil  ; ¤doc: Mode, if nil means that it's applied to current buffer. otherwise specify mode
   ot:tag-patterns)
  (font-lock-fontify-buffer))

(defun ot:font-off ()
  "Remove fontifications for `omni-tags'."                                       ;
  (mapcar (lambda (keyword) (font-lock-add-keywords nil keyword)) ot:tag-patterns)
  (font-lock-fontify-buffer))

  ;;; ¤* Utils fonctions


;; §next: tagpuration?
;; §TODO: proposer dans la documentation un use!!
;; §todo:  heading. fonctions pour naviguer.
;; map à prefix pour y associer un ensemblede fonction. ex: C-x § ou s-§

;; §todo: impr: message erreur
;; org opening of folding

;; §later: add some symbol in the fringe? ¤inspiration:gitgutter-flycheck-fixmargin
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
;; §idée: move dans `ot:default-config' ?
;; (add-hook 'org-mode-hook 'omni-tags-mode)
;; (add-hook 'prog-mode-hook 'omni-tags-mode)

(provide 'omni-tags)

;;; omni-tags.el ends here
