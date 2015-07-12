(load "streams.scm")
(load "exercise.3.50.scm")

(define (partial-sums s)
  (define result-stream
    (cons-stream
     (stream-car s)
     (add-streams (stream-cdr s)
                  result-stream)))
  result-stream)
