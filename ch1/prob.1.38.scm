;; D_i = 1   2   1   1   4   1   1   6   1   1   8 ...
;;   i = 1   2   3   4   5   6   7   8   9  10  11 ...
;;        (- i 0)     (- i 1)     (- i 2)     (- i 3)
;; When i%3 == 2 then D_i = (- i (floor (/ i 3)))
(load "prob.1.37.scm")

(define (d k)
  (if (= 2 (modulo k 3))
      (- k (floor (/ k 3.0)))
      1))

(cont-frac-iter (lambda (i) 1.0) d 20)
