(load "prob.2.2.scm")


(define (make-rect bottom-left top-right)
  (cons bottom-left top-right))

(define (bottom-left-rect rect) (car rect))
(define (top-right-rect rect) (cdr rect))

(define (width-rect rect)
  (abs (- (x-point (bottom-left-rect rect))
          (x-point (top-right-rect rect)))))
(define (height-rect rect)
  (abs (- (y-point (bottom-left-rect rect))
          (y-point (top-right-rect rect)))))

(define (area-rect rect)
  (* (width-rect rect) (height-rect rect)))
(define (perimeter-rect rect)
  (+ (* 2 (width-rect rect))
     (* 2 (height-rect rect))))
