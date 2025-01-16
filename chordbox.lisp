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

(defrule note (or blocked
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
  </defs>
</svg>
")

(defparameter *blocked-string-map*
  (list
   (cons 1 "<use id=\"Cross4\" serif:id=\"Cross\" xlink:href=\"#_Image1\" x=\"404\" y=\"697\" width=\"297px\" height=\"298px\" transform=\"matrix(4.16667,0,0,4.16667,0,0)\"/>")
   (cons 2 "<use id=\"Cross3\" serif:id=\"Cross\" xlink:href=\"#_Image1\" x=\"404\" y=\"1320\" width=\"297px\" height=\"298px\" transform=\"matrix(4.16667,0,0,4.16667,0,0)\"/>")
   (cons 3 "<use id=\"Cross2\" serif:id=\"Cross\" xlink:href=\"#_Image1\" x=\"404\" y=\"1997\" width=\"297px\" height=\"298px\" transform=\"matrix(4.16667,0,0,4.16667,0,0)\"/>")
   (cons 4 "<use id=\"Cross1\" serif:id=\"Cross\" xlink:href=\"#_Image1\" x=\"404\" y=\"2674\" width=\"297px\" height=\"298px\" transform=\"matrix(4.16667,0,0,4.16667,0,0)\"/>")
   (cons 5 "<use id=\"Cross\" xlink:href=\"#_Image1\" x=\"404\" y=\"3351\" width=\"297px\" height=\"298px\" transform=\"matrix(4.16667,0,0,4.16667,0,0)\"/>")
   (cons 6 "<use id=\"Cross5\" serif:id=\"Cross\" xlink:href=\"#_Image1\" x=\"404\" y=\"3997\" width=\"297px\" height=\"297px\" transform=\"matrix(4.16667,0,0,4.16667,0,0)\"/>")))

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
          if (and (stringp note)
                  (string-equal note "x"))
            do (lquery:$ svg (lquery-funcs:append (cdr (assoc i *blocked-string-map*))))
          else
            do (lquery:$ svg
                 (lquery-funcs:append
                  (format nil
                          "<circle cx=\"~D\" cy=\"~D\" r=\"781.25\" style=\"stroke:#000;stroke-width:104.17px;\"/>~%"
                          (second note)
                          (first note)))))
    ;; fret marker
    (let ((fret-marker-fmt (cdr (assoc (first fret-marker) *fret-marker-map*))))
      (lquery:$ svg (lquery-funcs:append (format nil fret-marker-fmt (second fret-marker)))))))

(defun write-chordbox (chordbox file)
  (lquery:$ chordbox (lquery-funcs:write-to-file file))
  (probe-file file))

(defun parse-chord (string)
  (let ((components (uiop:split-string string :separator '(#\:))))
    (generate-chordbox (first components)
                       (second components)
                       (list (char-number (char (third components) 0))
                             (char-number (char (third components) 1))))))
