(load "exercise.3.60.scm")

(define (invert-unit-series series)
  (cons-stream 1
               (mul-series (scale-stream (stream-cdr series) -1)
                           (invert-unit-series series))))
