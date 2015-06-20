;; The easiest way is to simply pass the buck onto the included packages
(load "generic-operations.scm")

(define (equ? x y)
  (let ((proc (get 'equ? (map type-tag (list x y)))))
    (if proc
        (apply proc (map contents (list x y)))
        #f)))

(put 'equ? '(complex complex)
     (lambda (x y) (and (= (real-part x) (real-part y))
                        (= (imag-part x) (imag-part y)))))
(put 'equ? '(rational rational)
     (lambda (x y) (and (= (car x) (car y)) (= (cdr x) (cdr y)))))
(put 'equ? '(scheme-number scheme-number)
     (lambda (x y) (and (= x y))))
(put 'equ? '(scheme-real scheme-real)
     (lambda (x y) (and (= x y))))
