(load "exercise.3.70.scm")

(define (square x)
  (* x x))

(define (sum-of-squares p)
  (+ (square (car p)) (square (cadr p))))

(define sum-of-squares-stream (pairs-weighted integers integers sum-of-squares))

(define (ex-372-stream stream)
  (define (pred x y z)
    (= (sum-of-squares x) (sum-of-squares y) (sum-of-squares z)))
  (if (stream-null? stream)
      the-empty-stream
      (let ((s1 (stream-ref stream 0))
            (s2 (stream-ref stream 1))
            (s3 (stream-ref stream 2)))
        (if (pred s1 s2 s3)
            (cons-stream (sum-of-squares s1)
                         (ex-372-stream (stream-cdr (stream-cdr (stream-cdr stream)))))
            (ex-372-stream (stream-cdr stream))))))

(define the-stream (ex-372-stream sum-of-squares-stream))
