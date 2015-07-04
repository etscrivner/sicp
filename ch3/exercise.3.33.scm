(load "constraints.scm")

(define (averager a b c)
  (let ((t (make-connector))
        (u (make-connector)))
    (adder a b t)
    (multiplier c u t)
    (constant 2 u)))

(define a1 (make-connector))
(define b1 (make-connector))
(define c1 (make-connector))

(averager a1 b1 c1)

(probe "A" a1)
(probe "B" b1)
(probe "C" c1)

(set-value! a1 2 'user)
(set-value! b1 6 'user)
