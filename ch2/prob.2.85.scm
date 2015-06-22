(load "prob.2.79.scm")
(load "prob.2.83.scm")

(define (has-projection? x)
  (get 'project (list (type-tag x))))

(define (project x)
  (let ((proc (get 'project (list (type-tag x)))))
    (if proc
        (proc (contents x))
        (error "No method for type -- PROJECT" x))))

(put 'project '(complex)
     (lambda (x) (attach-tag 'scheme-real (real-part x))))
(put 'project '(scheme-real)
     (lambda (x) (make-rational (inexact->exact (round x)) 1)))
(put 'project '(rational)
     (lambda (x) (make-scheme-number (car x))))

(define (can-drop? x)
  (and (has-projection? x) (equ? (raise (project x)) x)))

(define (drop x)
  (if (can-drop? x)
      (drop (project x))
      x))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (let ((result (apply proc (map contents args))))
            (if (can-drop? result)
                (drop result)
                result))
          (if (= (length args) 2)
              (let ((raises-a1 (num-raises-to-top (car args)))
                    (raises-a2 (num-raises-to-top (cadr args)))
                    (a1 (car args))
                    (a2 (cadr args)))
                (cond ((< raises-a1 raises-a2)
                       (apply-generic op a1 (n-raises a2 (- raises-a2 raises-a1))))
                      ((< raises-a2 raises-a1)
                       (apply-generic op (n-raises a1 (- raises-a1 raises-a2)) a2))
                      (else
                       (error "Items are of incompatible types" (list op a1 a2)))))
              (error "No method for these types"
                     (list op type-tags)))))))
