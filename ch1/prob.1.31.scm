(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (product-recur term a next b)
  (if (> a b)
      1
      (* (term a) (product-recur term (next a) next b))))

(define (factorial n)
  (product identity 1 inc n))

(define (compute-pi n)
  (define (term x)
    (let ((two-x (* 2 x)))
      (if (= x 1)
          (/ two-x (+ two-x 1))
          (* (/ two-x (- two-x 1))
             (/ two-x (+ two-x 1))))))
  (* 4.0 (product term 1 inc n)))

(define (even? x)
  (= 0 (remainder x 2)))

(define (identity x) x)

(define (inc x) (+ x 1))
