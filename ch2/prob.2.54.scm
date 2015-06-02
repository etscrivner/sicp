(define (equal? lst1 lst2)
  (cond ((and (null? lst1) (null? lst2)) #t)
        ((or (null? lst1) (null? lst2)) #f)
        (else
         (and (eq? (car lst1) (car lst2)) (equal? (cdr lst1) (cdr lst2))))))

(equal? '() '())
(equal? '() '(a))
(equal? '(a) '())
(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))
