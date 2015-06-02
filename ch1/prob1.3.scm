;; Structure and Interpretation of Computer Programs
;; Chapter 1, Problem 1.3
;;
;;
(define (square a) (* a a))

(define (sum-squares a b)
  (+ (square a) (square b)))

(define (sum-square-largest a b c)
  (if (> a b)
      (sum-squares a (if (> b c) b c))
      (sum-squares b (if (> a c) a c))))
