(define tolerance 0.00001)

(define (iterative-improve good-enough? improve)
  (define (iter guess)
    (let ((next (improve guess)))
      (if (good-enough? next guess)
        next
        (iter next))))
  iter)

(define (within-tolerance? v1 v2)
  (< (abs (- v1 v2)) tolerance))

(define (sqrt x)
  ((iterative-improve within-tolerance?
                      (lambda (y) (/ (+ y (/ x y)) 2.0)))
   1.0))

(define (fixed-point f first-guess)
  ((iterative-improve within-tolerance? f) first-guess))
