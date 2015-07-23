# Part A

Since the special forms are evaluated after method application his interpreter
will attempt to call special forms as methods, thus failing.

# Part B

(define (application? exp) (tagged-list? exp 'call))
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))
