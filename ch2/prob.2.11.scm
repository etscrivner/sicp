(load "prob.2.7.scm")

;; I got lazy and didn't finish this, but you can work it out on paper
;; pretty quickly.

(define (mul-negative? a b)
  (or (and (< a 0) (> b 0))
      (and (> a 0) (< b 0))))

(define (mul-positive? a b)
  (or (and (> a 0) (> b 0))
      (and (< a 0) (< b 0))))

(define (mul-interval x y)
  (let ((a (lower-bound x))
        (b (upper-bound x))
        (c (lower-bound y))
        (d (upper-bound y)))
    (cond ((and (> a 0) (> b 0) (> c 0) (> d 0))
           (make-interval (* a c) (* b d)))
          ((and (< a 0) (> b 0) (> c 0) (> d 0))
           (make-interval (* a d) (* b d)))
          ((and (> a 0) (< b 0) (> c 0) (> d 0))
           (make-interval (* b d) (* a d)))
          ((and (> a 0) (> b 0) (< c 0) (> d 0))
           (make-interval (* b c) (* b d)))
          ((and (> a 0) (> b 0) (> c 0) (< d 0))
           (make-interval (* b d) (* b c)))
          ((and (< a 0) (< b 0) (> c 0) (> d 0))
           (make-interval (* b d) (* a c)))
          ((and (< a 0) (< b 0) (< c 0) (> d 0))
           (make-interval (* b d) (* b c))))))
