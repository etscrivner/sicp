(define (even? x)
  (= 0 (remainder x 2)))

(define (double x)
  (* 2 x))

(define (halve x)
  (/ x 2))

(define (recursive-mult a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))

(define (fast-mult a b)
  (cond ((<= b 1) a)
        ((even? b) (double (fast-mult a (halve b))))
        (else (+ a (fast-mult a (- b 1))))))

(define (faster-mult a b)
  (define (iter-mult a b n)
    (cond ((= n 0) a)
          ((even? n) (iter-mult a (double b) (halve n)))
          (else (iter-mult (+ a b) b (- n 1)))))
  (iter-mult 0 a b))
