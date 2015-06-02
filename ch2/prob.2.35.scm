(load "prob.2.33.scm")

(define (flatten t)
  (cond ((null? t) '())
        ((not (pair? t)) (list t))
        (else (append (flatten (car t))
                      (flatten (cdr t))))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) 1) (flatten t))))

(define x (cons (list 1 2) (list 3 4)))
