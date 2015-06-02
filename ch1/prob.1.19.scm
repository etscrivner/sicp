;; Some basic algebra shows you that p' and q' must be these:
;;
;; p' = (+ (square p) (square q))
;; q' = (+ (square p) (square q) (* p q))

(define (even? x)
  (= 0 (remainder x 2)))

(define (square x)
  (* x x))

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p) (square q))
                   (+ (square p) (square q) (* p q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))
