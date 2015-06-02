(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

(define (pow x n)
  (if (<= n 1)
      x
      (* x (pow x (- n 1)))))

(define (f n) (A 2 n))

(define (other-f n)
  (if (= 1 n)
      2
      (pow 2 (other-f (- n 1)))))

;; (A 2 n)
;; (A 2 0) = 0
;; (A 2 1) = 2
;; (A 2 2) = 4
;; (A 2 3) = 16
;; (A 2 4) = 65536
