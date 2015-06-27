(load "exercise.3.13.scm")

(define (constant-space-has-cycle? x)
  (define (iter rest)
    (cond ((not (pair? rest)) #f)
          ((eq? rest x) #t)
          (else (iter (cdr rest)))))
  (if (null? x)
      #f
      (iter (cdr x))))

(constant-space-has-cycle? '())
(constant-space-has-cycle? '(a b c))
(constant-space-has-cycle? (make-cycle '(a b c)))
