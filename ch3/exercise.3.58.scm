;;; Constructs a stream representing the decimal expansion of a fraction
(load "streams.scm")

(define (expand num den radix)
  (cons-stream (quotient (* num radix) den)
               (expand (remainder (* num radix) den) den radix)))
