(load "prob.1.43.scm")
(load "prob.1.40.scm")

(define (fourth-root x)
  (fixed-point-of-transform (lambda (y) (/ x (* y y y)))
                            (repeated average-damp 2)
                            1.0))


;; n=2, (average-damp (average-damp ...))
;; n=8, (average-damp (average-damp (average-damp ...)))
;; looks like ceiling(log_2(n)) is number of damps
(define (nth-root n x)
  (fixed-point-of-transform (lambda (y) (/ x (expt y (- n 1))))
                            (repeated average-damp (ceiling (/ (log n) (log 2))))
                            1.0))
