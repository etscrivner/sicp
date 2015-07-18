(load "streams.scm")
(load "exercise.3.50.scm")

(define (RC r c dt)
  (define (result i v0)
    (add-streams (scale-stream i r)
                 (integral (scale-stream i (/ 1 c)) v0 dt)))
  result)

(define RC1 (RC 5 1 0.5))
