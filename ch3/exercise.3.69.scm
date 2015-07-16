(load "streams.scm")
(load "exercise.3.50.scm")
(load "exercise.3.54.scm")

(define (triples s t u)
  (cons-stream
   (list (stream-car s) (stream-car t) (stream-car u))
   (interleave
    (stream-map (lambda (x) (append (list (stream-car s)) x))
                (stream-cdr (pairs t u)))
    (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))

(print-partial-stream (triples integers integers integers) 20)
