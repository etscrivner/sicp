(define (square x)
  (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.0001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (small-enough-change? prev-guess guess)
  (< (abs (- prev-guess guess)) 0.0001))

(define (sqrt-iter-change guess prev-guess x)
  (if (small-enough-change? guess prev-guess)
      guess
      (sqrt-iter-change (improve guess x) guess x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))
