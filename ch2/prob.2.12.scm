(load "prob.2.7.scm")

(define (make-center-width center width)
  (make-interval (- center width) (+ center width)))

(define (make-center-percent center percent)
  (make-center-width center (* center percent)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (percent i)
  (/ (width i) (center i)))

(define p1 (make-center-percent 2 0.001))
(define p2 (make-center-percent 3 0.001))
