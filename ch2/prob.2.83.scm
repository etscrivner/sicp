;; I'm going to skip installing in packages so we can actually test.
(load "generic-operations.scm")

(define (type-tag datum)
  (cond ((pair? datum) (car datum))
        ((integer? datum) 'scheme-number)
        ((real? datum) 'scheme-real)
        (else (error "Bad typed datum -- TYPE-TAG" datum))))

(define (contents datum)
  (cond ((pair? datum) (cdr datum))
        ((integer? datum) datum)
        ((real? datum) datum)
        (else (error "Bad type datum -- CONTENTS" datum))))

(define (raise x)
  (let ((proc (get 'raise (list (type-tag x)))))
    (if proc
        (proc (contents x))
        (error "No method for type -- RAISE" x))))

(put 'raise '(scheme-number)
     (lambda (x) (make-rational x 1)))
(put 'raise '(rational)
     (lambda (x) (attach-tag 'scheme-real (/ (car x) (cdr x)))))
(put 'raise '(scheme-real)
     (lambda (x) (make-complex-from-real-imag x 0)))

;; To actually implement we'd just given rational and real packages their
;; respective 'raise methods from the next lowest type.
