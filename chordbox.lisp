;;; This Source Code Form is subject to the terms of the Mozilla Public
;;; License, v. 2.0. If a copy of the MPL was not distributed with this
;;; file, You can obtain one at http://mozilla.org/MPL/2.0/.

(in-package #:chordbox)

(defrule string-name (or #\e #\B #\G #\D #\A #\E)
  (:lambda (name)
    (ecase (char name 0)
      (#\e 3472.22)
      (#\B 6250)
      (#\G 9027.78)
      (#\D 11805.6)
      (#\A 14583.3)
      (#\E 17361.1))))

(defrule fret (esrap:character-ranges (#\1 #\5))
  (:lambda (fret)
    (ecase fret
      (#\1 5621.28)
      (#\2 10067.1)
      (#\3 14802.8)
      (#\4 19261.2)
      (#\5 23719.5))))

(defrule blocked (or #\x #\X))
(defrule open (or #\o #\O))

(defrule note (or blocked
                  open
                  (and string-name fret)))

(defrule chord (* note))

(defparameter *svg-layout* "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>
<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">
<svg width=\"100%\" height=\"100%\" viewBox=\"0 0 27780 20834\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xml:space=\"preserve\" xmlns:serif=\"http://www.serif.com/\" style=\"fill-rule:evenodd;clip-rule:evenodd;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:1.5;\">
  <g id=\"Chord-Box\" serif:id=\"Chord Box\">
    <rect x=\"3518.11\" y=\"3472.22\" width=\"4513.88\" height=\"13888.9\" style=\"fill:none;stroke:#000;stroke-width:104.17px;\"/>
    <rect x=\"8032.03\" y=\"3472.22\" width=\"4513.88\" height=\"13888.9\" style=\"fill:none;stroke:#000;stroke-width:104.17px;\"/>
    <rect x=\"12545.9\" y=\"3472.22\" width=\"4513.88\" height=\"13888.9\" style=\"fill:none;stroke:#000;stroke-width:104.17px;\"/>
    <rect x=\"17059.8\" y=\"3472.22\" width=\"4513.88\" height=\"13888.9\" style=\"fill:none;stroke:#000;stroke-width:104.17px;\"/>
    <rect x=\"3518.11\" y=\"3472.22\" width=\"22569.5\" height=\"2777.78\" style=\"fill:none;stroke:#000;stroke-width:104.17px;\"/>
    <rect x=\"3518.11\" y=\"6250.01\" width=\"22569.5\" height=\"2777.78\" style=\"fill:none;stroke:#000;stroke-width:104.17px;\"/>
    <rect x=\"3518.11\" y=\"9027.76\" width=\"22569.5\" height=\"2777.78\" style=\"fill:none;stroke:#000;stroke-width:104.17px;\"/>
    <rect x=\"3518.11\" y=\"11805.6\" width=\"22569.5\" height=\"2777.78\" style=\"fill:none;stroke:#000;stroke-width:104.17px;\"/>
    <rect x=\"3518.11\" y=\"14583.3\" width=\"22569.5\" height=\"2777.78\" style=\"fill:none;stroke:#000;stroke-width:104.17px;\"/>
  </g>
  <defs>
    <image id=\"_Image1\" width=\"297px\" height=\"298px\" xlink:href=\"data:image/png;base64,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\"/>
    <image id=\"_Image2\" width=\"327px\" height=\"328px\" xlink:href=\"data:image/png;base64,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\"/>
  </defs>
</svg>
")

(defparameter *string-map*
  (list
   (cons 1 "<use id=\"Cross4\" serif:id=\"Cross\" xlink:href=\"~A\" x=\"404\" y=\"697\" width=\"297px\" height=\"298px\" transform=\"matrix(4.16667,0,0,4.16667,0,0)\"/>")
   (cons 2 "<use id=\"Cross3\" serif:id=\"Cross\" xlink:href=\"~A\" x=\"404\" y=\"1320\" width=\"297px\" height=\"298px\" transform=\"matrix(4.16667,0,0,4.16667,0,0)\"/>")
   (cons 3 "<use id=\"Cross2\" serif:id=\"Cross\" xlink:href=\"~A\" x=\"404\" y=\"1997\" width=\"297px\" height=\"298px\" transform=\"matrix(4.16667,0,0,4.16667,0,0)\"/>")
   (cons 4 "<use id=\"Cross1\" serif:id=\"Cross\" xlink:href=\"~A\" x=\"404\" y=\"2674\" width=\"297px\" height=\"298px\" transform=\"matrix(4.16667,0,0,4.16667,0,0)\"/>")
   (cons 5 "<use id=\"Cross\" xlink:href=\"~A\" x=\"404\" y=\"3351\" width=\"297px\" height=\"298px\" transform=\"matrix(4.16667,0,0,4.16667,0,0)\"/>")
   (cons 6 "<use id=\"Cross5\" serif:id=\"Cross\" xlink:href=\"~A\" x=\"404\" y=\"3997\" width=\"297px\" height=\"297px\" transform=\"matrix(4.16667,0,0,4.16667,0,0)\"/>")))

(defparameter *fret-marker-map*
  (list
   (cons 1 "<text x=\"5221.28px\" y=\"20000px\" style=\"font-size:1715.15px;\">~D</text>")
   (cons 2 "<text x=\"9667.1px\" y=\"20000px\" style=\"font-size:1715.15px;\">~D</text>")
   (cons 3 "<text x=\"14402.8px\" y=\"20000px\" style=\"font-size:1715.15px;\">~D</text>")
   (cons 4 "<text x=\"18861.2px\" y=\"20000px\" style=\"font-size:1715.15px;\">~D</text>")
   (cons 5 "<text x=\"23319.5px\" y=\"20000px\" style=\"font-size:1715.15px;\">~D</text>")))

(defun char-number (char)
  (- (char-int char) (char-int #\0)))

(defun generate-chordbox (name chord fret-marker)
  (let* ((notes (esrap:parse 'chord (string-upcase chord :start 1))) ; don't upcase first char because we use 'e' identifier for the high e-string
         (doc (lquery:$ (lquery:initialize *svg-layout*)))
         (svg (lquery:$ doc "svg")))
    (when (not (= 6 (length notes)))
      (error "Specification malfored! Exactly 6 values are required.~%~A" chord))
    ;; write chord name
    (lquery:$ svg (lquery-funcs:append
                   (format nil "<text x=\"838.404px\" y=\"1584.45px\" style=\"font-size:1381.08px;\">~A</text>" name)))
    ;; chordbox
    (loop for note in notes
          for i from 1
          when (and (stringp note)
                    (string-equal note "x"))
            do (lquery:$ svg (lquery-funcs:append (format nil (cdr (assoc i *string-map*)) "#_Image1")))
          when (and (stringp note)
                    (string-equal note "o"))
            do (lquery:$ svg (lquery-funcs:append (format nil (cdr (assoc i *string-map*)) "#_Image2")))
          when (consp note)
            do (lquery:$ svg
                 (lquery-funcs:append
                  (format nil
                          "<circle cx=\"~D\" cy=\"~D\" r=\"781.25\" style=\"stroke:#000;stroke-width:104.17px;\"/>~%"
                          (second note)
                          (first note)))))
    ;; fret marker
    (when fret-marker
      (let ((fret-marker-fmt (cdr (assoc (first fret-marker) *fret-marker-map*))))
        (lquery:$ svg (lquery-funcs:append (format nil fret-marker-fmt (second fret-marker))))))
    doc))

(defun write-chordbox (chordbox file)
  (lquery:$ chordbox (lquery-funcs:write-to-file file))
  (probe-file file))

(defun parse-chord (string)
  (let ((components (uiop:split-string string :separator '(#\:))))
    (generate-chordbox (first components)
                       (second components)
                       (unless (null (third components))
                         (list (char-number (char (third components) 0))
                               (parse-integer (third components) :start 1))))))
