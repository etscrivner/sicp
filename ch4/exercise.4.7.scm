(load "exercise.4.6.scm")

(define (let*? exp)
  (tagged-list? exp 'let*))
(define (make-let defs body)
  (list 'let defs body))

(define (let*->nested-lets exp)
  (expand-let*-clauses (let-definitions exp)
                       (let-body exp)))
(define (expand-let*-clauses defs body)
  (if (null? defs)
      body
      (make-let (list (car defs))
                (expand-let*-clauses (cdr defs) body))))

(define test '(let* ((x 3) (y (+ x 2)) (z (+ x y 5))) (* x z)))
;; It is sufficient to add the given clause, as eval will then evaluate
;; the nested lets.
