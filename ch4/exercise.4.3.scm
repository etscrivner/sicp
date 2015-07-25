;; To rewrite the interpret in a data-directed style (object-oriented style) is
;; simply to lean even less on the underlying scheme implementation and to
;; instead make everything a list. This will be some gnarly work
(load "interpreter.scm")
(load "../ch3/table.scm")

(define *evaluation-table* (make-table-object))

(define (expression-type exp)
  (car exp))

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((assoc (expression-type exp) *evaluation-table*)
         (let (( (lookup (expression-type exp) *evaluation-table*)))
           (result exp env)))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else (error "Unknown expression type -- EVAL" exp))))
