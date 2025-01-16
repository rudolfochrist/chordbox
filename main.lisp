;;; This Source Code Form is subject to the terms of the Mozilla Public
;;; License, v. 2.0. If a copy of the MPL was not distributed with this
;;; file, You can obtain one at http://mozilla.org/MPL/2.0/.

(defpackage #:chordbox/main
  (:use :cl)
  (:export
   #:main))

(in-package #:chordbox/main)

(defun handle-interrupt (signo info-sap context-sap)
  (declare (ignore signo info-sap context-sap))
  ;; cleanup/finalize
  (uiop:quit))

(adopt:define-string *help-text*
  "Genrate an SVG chord diagram from a input string.")

(defparameter *options-help*
  (adopt:make-option
   'help
   :long "help"
   :short #\h
   :help "Print help and exit."
   :reduce (constantly t)))

(defparameter *option-version*
  (adopt:make-option
   'version
   :long "version"
   :short #\v
   :help "Print version."
   :reduce (constantly t)))

(defparameter *option-output-file*
  (adopt:make-option
   'output-file
   :long "output-file"
   :short #\o
   :help "Path to the output file."
   :parameter "FILE"
   :initial-value "chord.svg"
   :reduce #'adopt:last))

(defparameter *ui*
  (adopt:make-interface
   :name "chordbox"
   :summary "Generate chord diagrams"
   :usage "[OPTIONS] STRING"
   :help *help-text*
   :contents (list *options-help*
                   *option-version*
                   *option-output-file*)))

(defun toplevel ()
  (handler-case
      (multiple-value-bind (arguments options)
          (adopt:parse-options *ui*)
        (when (gethash 'help options)
          (adopt:print-help-and-exit *ui*))
        (when (gethash 'version options)
          (format t "~&~A~%" (asdf:component-version (asdf:find-system "chordbox")))
          (adopt:exit))
        (chordbox:write-chordbox
         (chordbox:parse-chord (first arguments))
         (gethash 'output-file options)))
    (error (c)
      (adopt:print-error-and-exit c))))

(defun main (&optional args)
  (declare (ignore args))
  (sb-sys:enable-interrupt sb-unix:sigint #'handle-interrupt)
  (sb-sys:enable-interrupt sb-unix:sigterm #'handle-interrupt)
  ;; run program
  (toplevel))
