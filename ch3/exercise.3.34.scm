(load "constraints.scm")

(define (squarer a b)
  (multiplier a a b))

(define a1 (make-connector))
(define b1 (make-connector))

(squarer a1 b1)

(probe "A" a1)
(probe "B" b1)

(set-value! a1 -12 'user)
(forget-value! b1 'user)

;;; You can't back propagate to determine the square-root of a value
