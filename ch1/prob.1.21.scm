(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (next n)
  (cond ((< n 3) (+ n 1))
        (else (+ n 2))))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

;; (smallest-divisor 199) 
;; 199
;; (smallest-divisor 1999)
;; 1999
;; (smallest-divisor 19999)
;; 7
