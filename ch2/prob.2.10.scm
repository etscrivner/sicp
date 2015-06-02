(load "prob.2.7.scm")

(define (div-interval x y)
  (let ((lower-y (lower-bound y))
        (upper-y (upper-bound y)))
    (if (or (< 0 lower-y) (< 0 upper-y))
        (error "Denominator contains a bound that crosses 0")
        (mul-interval x
                      (make-interval (/ 1.0 (upper-bound y))
                                     (/ 1.0 (lower-bound y)))))
