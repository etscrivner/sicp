(load "exercise.3.13.scm")

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))


(define (return-4)
  (let ((front-pair '(a))
        (back-pair '(c)))
    (set-car! front-pair back-pair)
    (cons front-pair '(a))))

(count-pairs '(a b c))
(count-pairs (return-4))
(count-pairs '((a b) (c d) e))
(count-pairs (make-cycle '(a b c)))
