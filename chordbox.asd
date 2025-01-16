;;; This Source Code Form is subject to the terms of the Mozilla Public
;;; License, v. 2.0. If a copy of the MPL was not distributed with this
;;; file, You can obtain one at http://mozilla.org/MPL/2.0/.

(defsystem "chordbox"
  :author "Sebastian Christ <rudolfo.christ@proton.me>"
  :maintainer "Sebastian Christ <rudolfo.christ@proton.me>"
  :mailto "rudolfo.christ@proton.me"
  :license "MPL-2.0"
  :homepage "https://github.com/rudolfochrist/chordbox"
  :bug-tracker "https://github.com/rudolfochrist/chordbox/issues"
  :source-control (:git "https://github.com/rudolfochrist/chordbox.git")
  :version (:read-file-line "version")
  :depends-on ((:require "uiop")
               "esrap"
               "lquery")
  :serial t
  :components ((:file "package")
               (:file "chordbox"))
  :description "Generate chord diagrams the easy way."
  :long-description
  #.(uiop:read-file-string
     (uiop:subpathname *load-pathname* "README.org"))
  :in-order-to ((test-op (test-op "chordbox/test"))))


(defsystem "chordbox/test"
  :description "Tests for chordbox"
  :depends-on ((:require "uiop")
               "fiveam"
               "fiveam-matchers"
               "chordbox")
  :pathname "t/"
  :components ((:file "tests"))
  :perform (test-op (op c)
                    (unless (uiop:symbol-call :fiveam :run! :chordbox)
                      #+(not (or :swank :slynk))
                      (uiop:quit 1))))


(defsystem "chordbox/executable"
  :build-operation program-op
  :build-pathname "chordbox"
  :entry-point "chordbox/main:main"
  :description "chordbox Executable"
  :depends-on ("adopt" "chordbox")
  :components ((:file "main")))

#+sb-core-compression
(defmethod asdf:perform ((o asdf:image-op) (c asdf:system))
  (uiop:dump-image (asdf:output-file o c)
                   :executable t
                   :compression t))
