;;; test-helper --- Test helper for omni-tags

;;; Commentary:
;; test helper inspired from https://github.com/tonini/overseer.el/blob/master/test/test-helper.el

;;; Code:

(require 'f)

(defvar cpt-path
  (f-parent (f-this-file)))

(defvar omni-tags-test-path
  (f-dirname (f-this-file)))

(defvar omni-tags-root-path
  (f-parent omni-tags-test-path))

(defvar omni-tags-sandbox-path
  (f-expand "sandbox" omni-tags-test-path))

(when (f-exists? omni-tags-sandbox-path)
  (error "Something is already in %s. Check and destroy it yourself" omni-tags-sandbox-path))

(defmacro within-sandbox (&rest body)
  "Evaluate BODY in an empty sandbox directory."
  `(let ((default-directory omni-tags-sandbox-path))
     (when (f-exists? omni-tags-sandbox-path)
       (f-delete default-directory :force))
     (f-mkdir omni-tags-sandbox-path)
     ,@body
     (f-delete default-directory :force)))

(require 'undercover)
(undercover "*.el" "omni-tags/*.el"
            (:exclude "*-test.el")
            (:send-report nil)
            (:report-file "/tmp/undercover-report.json"))
(require 'ert)
(require 'omni-tags (f-expand "omni-tags" omni-tags-root-path))

;;; test-helper.el ends here
