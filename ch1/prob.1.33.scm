(define (filtered-accumulate pred? combiner null-value term a next b)
  (cond ((> a b) null-value)
        ((pred? a) (combiner (term a)
                                    (filtered-accumulate pred?
                                                         combiner
                                                         null-value
                                                         term
                                                         (next a)
                                                         next
                                                         b)))
        (else (filtered-accumulate pred?
                                   combiner
                                   null-value
                                   term
                                   (next a)
                                   next
                                   b))))

(define (filtered-accumulate-iter pred? combiner null-value term a next b)
  (define (iter a result)
    (cond ((> a b) result)
          ((pred? a) (iter (next a) (combiner (term a) result)))
          (else (iter (next a) result))))
  (iter a null-value))

(define (square x) (* x x))
(define (inc x) (+ x 1))
(define (identity x) x)

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (sum-square-primes a b)
  (filtered-accumulate-iter prime? + 0 square a inc b))

(define (product-of-relative-primes n)
  (define (relatively-prime? i)
    (= 1 (gcd i n)))
  (filtered-accumulate-iter relatively-prime? * 1 identity 1 inc n))
