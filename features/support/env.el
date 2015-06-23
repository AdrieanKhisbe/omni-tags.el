(require 'f)

(defvar omni-tags-support-path
  (f-dirname load-file-name))

(defvar omni-tags-features-path
  (f-parent omni-tags-support-path))

(defvar omni-tags-root-path
  (f-parent omni-tags-features-path))

(add-to-list 'load-path omni-tags-root-path)

(require 'undercover)
(undercover "*.el" "omni-tags/*.el"
            (:exclude "*-test.el")
            (:report-file "/tmp/undercover-report.json"))
(require 'omni-tags)
(require 'espuds)
(require 'ert)

(Setup
 ;; Before anything has run
 )

(Before
 ;; Before each scenario is run
 )

(After
 ;; After each scenario is run
 )

(Teardown
 ;; After when everything has been run
 )
