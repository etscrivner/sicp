(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc n)
  (+ n 1))

(define (cube x)
  (* x x x))

(define (even? n)
  (= 0 (remainder n 2)))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(define (simpson-integral f a b n)
  (define h (/ (- b a) n))
  (define (y k)
    (f (+ a (* k h))))
  (define (y-term k)
    (cond ((= k 0) (y k))
          ((even? k) (* 2 (y k)))
          (else (* 4 (y k)))))
  (* (/ h 3) (sum y-term 0 inc n)))
