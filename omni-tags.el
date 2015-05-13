;;; omni-tags.el --- Highlight and Actions for 'Tags'
;;
;; Copyright (C) 2014-2015 Adrien Becchis
;;
;; Author: Adrien Becchis <adriean.khisbe@live.fr>
;; Version: 0.1
;; Package-Requires: ((pcre2el "1.7") (cl-lib "0.5"))
;; Keywords: convenience
;; URL: http://github.com/AdrieanKhisbe/omni-tags.el

;; This file is not part of GNU Emacs.

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

;;; Commentary:
;; This mode is to support “tag”, annotation in org-files or comments in
;; programming mode. A tags looks like a java annotation with § (primary)
;; or ¤ (secondary) instead of the @.
;; This emacs mode currently support highlighting and basic navigation
;; between these tags.
;;
;; For more details refer to the the README.org file, and for examples of
;; what theses "tags", comments, you can look at the code source of the library.

;;; Code:

(require 'pcre2el) ;§maybe: only use in development for starting performance issue
(require 'omni-tags-utils)
(require 'omni-tags-face)
(require 'omni-tags-navigation)

;; §TOFIX: Make it appear in org comment!!! (probably something to see with `org-mode')
;; §Tosee: ! ?? what _ symbolize in regexp? match ;?
;; §Todo: make list of different keyword, more highlighted! for instance: TD TF TI TM

;; ¤> Customs
(defgroup omni-tags nil
  "Customs for `omni-tags' modes."
  :group 'convenience) ; ¤note: hesitated with tools

(defcustom omni-tags-primary-tag "§" "Primary Tag Symbol (associated with actions)."
  :type 'string  :group 'omni-tags) ; §maybe:char? ;§todo:add syze constraint

(defcustom omni-tags-secondary-tag "¤" "Secondary Tag Symbol (associated with descriptions)."
  :type 'string  :group 'omni-tags)
;; ¤maybe: special tag for headings? [and special face: easier to identify: for navigation, map..]

(defvar omni-tags-tag-patterns nil "Ensemble des patterns à matcher.")
;; §HERE : todo ;: créer variables spécifiques: single, composed, complex.
;; §see comment late bind le tag. [ ou refresh ]

(defvar omni-tags-override t
  "Value to use in keyword pattern, possible values:
- t: override existing fontification
- append/prepend: merge of existing fontification (prepend comes first)

- keep: only parts not already fontified are highlighted") ;; ¤maybe:try change
(defconst omni-tags-optional "laxmatch"
  "Specify that this part of the keyword is not compulsary: don't throw error if a subexp is not match.")

;; ¤maybe (defvar omni-tags-pattern-simple  "Pattern for single" )
;; maybe could enforce number of matching () to validate a pattern [special vaildation function for custom]

(defun omni-tags-make-pattern (regexp)
  "Create a pattern.  Replace first %s with tag symbol, and convert REGEXP writen in pcre format to Emacs regexp."
  (rxt-pcre-to-elisp (format regexp (format "(%s+|%s+)" omni-tags-primary-tag omni-tags-secondary-tag)))
  ;; §maybe: get ride of pcre2el dependecy?
  )

;;; ¤> Keywords Definition:

;; ¤doc: Keyword: form: more doc at `font-lock-keywords'
;; MATCH-HIGHLIGH (SUBEXP FACENAME [OVERRIDE [LAXMATCH]])

(defvar omni-tags-tag-wonder-keyword
  `(,(omni-tags-make-pattern "%s([!?¿¡]+)");; §TODO: extract to custom
    (1 'omni-tags-face-symbol  ,omni-tags-override)
    (2 'omni-tags-face-ponctuation ,omni-tags-override))
  "Wonder/expression tag.")
;; §maybe; extract defintion in function to enable to reevalute it (after change pattern)

(defvar omni-tags-tag-detailed-keyword
  `(,(omni-tags-make-pattern "%s(['@\-_ [:alnum:]]+)(([:])([_,-;/[:alnum:]]+))*([?!¡¿]+)?") ;§todo: exlude :
    ;; §tofix: combo a:b:c -> might need to specify something. or hackyhacky for combo.
    ;; ¤note: semblerait que les répétition écrase les présents matching.
    ;;        [ce qui est normalement le cas avec les regexp]
    (1 'omni-tags-face-symbol      ,omni-tags-override)
    (2 'omni-tags-face-name        ,omni-tags-override)
    (4 'omni-tags-face-separator   ,omni-tags-override ,omni-tags-optional) ;§maybe, delete (), and use wrapping.
    (5 'omni-tags-face-details     ,omni-tags-override ,omni-tags-optional)
    (6 'omni-tags-face-ponctuation ,omni-tags-override ,omni-tags-optional))
  "Complex Tag §todo: repeat the same one without quotes")

;; §TODO: extract to custom [word components and so]
(defvar omni-tags-whatever-follow-keyword ;§torename
  `(,(omni-tags-make-pattern "%s(['@\-_ [:alnum:]]+)(:)( [^¤§\n]*| +$)")
    ;; ¤note: [^ … ] matches all characters not in the list, even newlines
    (1 'omni-tags-face-symbol      ,omni-tags-override)
    (2 'omni-tags-face-name        ,omni-tags-override)
    (3 'omni-tags-face-separator   ,omni-tags-override) ;§maybe, delete (), and use wrapping.
    (4 'omni-tags-face-details     ,omni-tags-override ,omni-tags-optional))
  "Tag that grab all that follow on the current line.")

;; §version :: qui prendrait tout jusqu'à ligne vide (ou fin du commentaire!!!)
;; §see: \s<   comment starter \s(   open delimiter character    \s>   comment ender \s)   close delimiter character   \s!   generic comment delimiter
;; §see: set up system to be able to proto more easily. [and light launch]

;; §maybe; extract defintion in function to enable to reevalute it (after change pattern)


(defvar omni-tags-tag-heading ;name to find
  `(,(rxt-pcre-to-elisp (format "(%s)(>+)" omni-tags-secondary-tag))
    (1 'omni-tags-face-symbol  ,omni-tags-override) ;§maybe: try <¤>
    (2 'omni-tags-face-ponctuation ,omni-tags-override)) ;§maybe: grab the rest of the line (eventual title)
  "heading tag")

;; §later: add funtions. and specific navigation to emulate org

;; ¤note: New tags to create
;; §todo: symple tag not in bold
;;        just symbol. <¤> <<¤>>
;;        place holder. (temporary): (¤) [¤] {¤}
;;        wrapped tag:  [§ abcb ]

(setq omni-tags-tag-patterns
      (list `(,omni-tags-primary-tag  . 'omni-tags-face-symbol) ; Inline
            omni-tags-tag-detailed-keyword
            omni-tags-tag-wonder-keyword
            omni-tags-tag-heading
            omni-tags-whatever-follow-keyword
            ))

  ;;; Coloration des tags des tags
(defun omni-tags-font-on ()
  "Add fontifications for `omni-tags'.
Keywords are stored in list `omni-tags-tag-patterns'."
  (font-lock-add-keywords
   nil  ; ¤doc: Mode, if nil means that it's applied to current buffer. otherwise specify mode
   omni-tags-tag-patterns)
  (font-lock-fontify-buffer))

(defun omni-tags-font-off ()
  "Remove fontifications for `omni-tags'."                                       ;
  (mapcar (lambda (keyword) (font-lock-add-keywords nil keyword)) omni-tags-tag-patterns)
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
            (define-key map (kbd "M-§") 'omni-tags-next-tags) ;; ¤note: key should also be reevaluated.
            (define-key map (kbd "C-§") 'omni-tags-previous-tags)
            (define-key map (kbd "C-M-§") 'omni-tags-occur-tags)
            map)
  (progn (if omni-tags-mode
             (omni-tags-font-on)
           (omni-tags-font-off))))

;; §config:
;; §idée: move dans `omni-tags-default-config' ?
;; (add-hook 'org-mode-hook 'omni-tags-mode)
;; (add-hook 'prog-mode-hook 'omni-tags-mode)

(provide 'omni-tags)

;;; omni-tags.el ends here
