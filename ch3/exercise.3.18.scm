(load "exercise.3.13.scm")

(define (has-cycle? x)
  (define (iter x already-seen)
    (cond ((not (pair? x)) #f)
          ((memq x already-seen) #t)
          (else (iter (cdr x) (cons x already-seen)))))
  (iter x '()))

(has-cycle? '())
(has-cycle? '(a b c))
(has-cycle? (make-cycle '(a b c)))
