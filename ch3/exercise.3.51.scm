(load "exercise.3.50.scm")
(load "streams.scm")

(define (show x)
  (display x)
  (newline)
  x)

(define x (stream-map show (stream-enumerate-interval 0 10)))
;;; Prints: 0

(stream-ref x 5)
;;; Prints 1 - 5

(stream-ref x 7)
;;; Prints 6, 7
