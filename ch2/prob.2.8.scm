(load "prob.2.7.scm")

(define (sub-interval x y)
  (let ((p1 (- (lower-bound x) (lower-bound y)))
        (p2 (- (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2) (max p1 2))))
