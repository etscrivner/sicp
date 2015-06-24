(define *previous* 0)

(define (f x)
  (let ((previous *previous*))
    (begin (set! *previous* x)
           previous)))      
