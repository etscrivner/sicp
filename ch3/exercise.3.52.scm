(load "exercise.3.50.scm")
(load "streams.scm")

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
;;; Sum is 1

(define y (stream-filter even? seq))
;;; Sum is 6 (Sums until sum is even for first time (1 + 2 + 3 = 6))

(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
;;; Sum is 10 (Sums until pred satisifed (1 + 2 + 3 + 4 = 10))

(stream-ref y 7)

;;; Sum is 136 (Sums until 7th even partial-sum)

(display-stream z)

;;; Sum is 210 (Sums all numbers)
