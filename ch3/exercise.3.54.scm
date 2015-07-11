(load "streams.scm")
(load "exercise.3.50.scm")

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))
(define factorials
  (cons-stream
   1
   (mul-streams factorials (stream-cdr integers))))
