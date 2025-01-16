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

(defun main (&optional args)
  (declare (ignore args))
  (sb-sys:enable-interrupt sb-unix:sigint #'handle-interrupt)
  (sb-sys:enable-interrupt sb-unix:sigterm #'handle-interrupt)
  ;; run program
  )
