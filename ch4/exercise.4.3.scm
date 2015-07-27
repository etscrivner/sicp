(load "interpreter.scm")
(load "../ch3/table.scm")

(define *evaluation-table* (make-table))

(define (expression-type exp)
  (car exp))

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((assoc (expression-type exp) *evaluation-table*)
         (let ((result (lookup (expression-type exp) *evaluation-table*)))
           (result exp env)))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else (error "Unknown expression type -- EVAL" exp))))
