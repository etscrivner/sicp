;; I'm going to skip installing in packages so we can actually test.
(load "generic-operations.scm")

(define (raise x)
  (let ((proc (get 'raise (type-tag x))))
    (if proc
        (proc (contents x))
        (error "No method for type -- RAISE" x))))

(put 'raise '(scheme-number)
     (lambda (x) (make-rational x 1)))
(put 'raise '(rational)
     (lambda (x) (make-complex-from-real-imag (/ (car x) (cdr x)) 0)))

;; To actually implement we'd just given rational and real packages their
;; respective 'raise methods from the next lowest type.
