(load "prob.1.37.scm")

(define (d k) (+ 1 (* 2 (- k 1))))

(define (tan-cf x k)
  (define (n k)
    (if (= k 1)
        x
        (- (* x x))))
  (cont-frac-iter n d k))
