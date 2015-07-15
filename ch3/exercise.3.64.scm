(load "streams.scm")
(load "exercise.3.50.scm")

(define (stream-limit stream tolerance)
  (let ((s0 (stream-ref stream 0))
        (s1 (stream-ref stream 1)))
    (if (< (abs (- s0 s1)) tolerance)
        s1
        (stream-limit (stream-cdr stream) tolerance))))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))
