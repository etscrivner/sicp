(load "circuits.scm")

(define (or-gate a1 a2 output)
  (let ((c (make-wire))
        (d (make-wire))
        (e (make-wire)))
    (inverter a1 c)
    (inverter a2 d)
    (and-gate c d e)
    (inverter e output)
    'ok))

;;; Total delay = (+ (* 3 inverter-delay) and-gate-delay)
