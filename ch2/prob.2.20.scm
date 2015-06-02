(define (even? x) (= 0 (remainder x 2)))
(define (odd? x) (= 1 (remainder x 2)))

(define (same-parity fst . items)
  (define (filter p rest)
    (cond ((null? rest) ())
          ((p (car rest))
           (cons (car rest) (filter p (cdr rest))))
          (else
           (filter p (cdr rest)))))
  (filter (if (even? fst) even? odd?) (append (list fst) items)))
