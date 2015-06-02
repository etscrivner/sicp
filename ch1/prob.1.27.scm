(define (total-fermat-test n)
  (define (recursive-try-it a)
    (cond ((>= a n) true)
          ((not (= (expmod a n n) a)) false)
          (else (recursive-try-it (+ a 1)))))
  (recursive-try-it 1))

(total-fermat-test 561)
(total-fermat-test 1105)
(total-fermat-test 1729)
(total-fermat-test 2465)
(total-fermat-test 2821)
(total-fermat-test 6601)

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (square x)
  (* x x))

(define (even? x)
  (= (remainder x 2) 0))
