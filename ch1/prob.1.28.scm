(define (rabin-miller-test n)
  (define (try-it a)
    (let ((val (expmod a n n)))
      (and (= a val) (not (= val  0)))))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (define (root-or-remainder val)
    (if (non-trivial-root? val exp)
        0
        (remainder val m)))
  (cond ((= exp 0) 1)
        ((even? exp)
         (root-or-remainder (square (expmod base (/ exp 2) m))))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (non-trivial-root? m n)
  (cond ((or (= m 1) (>= m n)) false)
        (else (= 1 (remainder (square m) n)))))

(define (square x)
  (* x x))

(define (even? x)
  (= (remainder x 2) 0))
