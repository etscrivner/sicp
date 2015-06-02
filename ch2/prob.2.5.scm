(define (num-divisions accum n a)
  (if (= 0 (remainder n a))
      (clean-divisions (+ accum 1) (/ n a) a)
      accum))

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (car x) (num-divisions 0 x 2))
(define (cdr x) (num-divisions 0 x 3))
