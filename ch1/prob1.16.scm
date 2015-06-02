(define (square x)
  (* x x))

(define (even? n)
  (= 0 (remainder n 2)))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (iter-fast-expt b n)
  (define (iter-expt a b n)
    (cond ((= 0 n) a)
          ((even? n) (iter-expt a (square b) (/ n 2)))
          (else (iter-expt (* a b) b (- n 1)))))
  (iter-expt 1 b n))

;; (iter-expt 1 5 5)
;; (iter-expt 5 5 4)
;; (iter-expt 5 25 2)
;; (iter-expt 5 625 1)
;; (iter-expt 3125 625 0)
