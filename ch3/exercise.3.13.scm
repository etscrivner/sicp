(load "exercise.3.12.scm")

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
