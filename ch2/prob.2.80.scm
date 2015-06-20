(load "generic-operations.scm")
(load "prob.2.79.scm")

(define (=zero? x)
  (apply-generic '=zero? x))

(put '=zero? '(scheme-number) (lambda (x) (= x 0)))
(put '=zero? '(rational) (lambda (x) (and (= (car x) 0) (= (cdr x) 0))))
(put '=zero? '(complex) (lambda (x) (and (= 0 (real-part x)) (= 0 (imag-part x)))))
