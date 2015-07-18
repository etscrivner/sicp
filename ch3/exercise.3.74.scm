(load "streams.scm")
(load "exercise.3.50.scm")

(define (sign-change-detector current previous)
  (cond ((and (> current 0) (< previous 0)) 1)
        ((and (< current 0) (> previous 0)) -1)
        (else 0)))

(define (make-zero-crossings input-stream last-value)
  (cons-stream
   (sign-change-detector (stream-car input-stream) last-value)
   (make-zero-crossings (stream-cdr input-stream)
                        (stream-car input-stream))))

(define zero-crossings
  (stream-map sign-change-detector sense-data (stream-cdr sense-data)))
