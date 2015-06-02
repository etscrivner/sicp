;; (f 0) = 0
;; (f 1) = 1
;; (f 2) = 2
;; (f 3) = 4 = 2 + 2*1
;; (f 4) = 11 = 4 + 2*2 + 3*1

(define (recursive-f n)
  (if (< n 3)
      n
      (+ (recursive-f (- n 1))
         (* 2 (recursive-f (- n 2)))
         (* 3 (recursive-f (- n 3))))))

(define (iter-f n)
  (define (inner-iter-f a b c remaining-times)
    (if (= remaining-times 0)
        a
        (inner-iter-f b c (+ c (* 2 b) (* 3 a)) (- remaining-times 1))))
  (inner-iter-f 0 1 2 n))
