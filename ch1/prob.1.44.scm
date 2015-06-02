(load "prob.1.40.scm")
(load "prob.1.43.scm")

(define (smooth f)
  (lambda (x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
       3.0)))

(define (n-fold-smooth f n)
  (repeated smooth n))
