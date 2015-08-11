(define (letrec? exp)
  (tagged-list? exp 'letrec))
(define (make-letrec vars vals body)
  (append (list 'letrec (map list vars vals)) body))
(define (letrec-definitions exp)
  (cadr exp))
(define (letrec-definitions-variables defs)
  (map car defs))
(define (letrec-definitions-values defs)
  (map cadr defs))
(define (letrec-body exp)
  (cddr exp))
(define (letrec->let exp)
  (let* ((defs (letrec-definitions exp))
         (vars (letrec-definitions-variables defs))
         (vals (letrec-definitions-values defs)))
    (make-let
     vars
     (make-list (length vars) '(quote *unassigned))
     (append (map (lambda (x y) (list 'set! x y)) vars vals)
             (letrec-body exp)))))

(define
  tricky-eval
  '(define (f x)
     (letrec ((even?
               (lambda (n)
                 (if (= n 0)
                     true
                     (odd? (- n 1)))))
              (odd?
               (lambda (n)
                 (if (= n 0)
                     false
                     (even? (- n 1))))))
       (even? x))))

(define my-letrec '(letrec ((a 5) (b (+ a 1))) (+ a b)))
