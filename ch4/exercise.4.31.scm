(load "interpreter.scm")

;; Eval/Apply

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((let? exp) (eval (let->combination exp) env))
        ((letrec? exp) (eval (letrec->let exp) env))
        ((application? exp)
         (apply (actual-value (operator exp) env)
                (operands exp)
                env))
        (else
         (error "Unknown expression type -- EVAL" exp))))

(define (apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
          procedure
          (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           (procedure-parameter-names procedure)
           (list-of-thunked-arguments
            (procedure-parameters procedure) arguments env)
           (procedure-environment procedure))))
        (else
         (error
          "Unknown procedure type -- APPLY" procedure))))

;; Evaluation

(define (eval-if exp env)
  (if (true? (actual-value (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))


;; Thunks

(define (thunk? obj)
  (tagged-list? obj 'thunk))
(define (thunk-memo? obj)
  (tagged-list? obj 'thunk-memo))
(define (evaluated-thunk? obj)
  (tagged-list? obj 'evaluated-thunk))

(define (thunk-exp thunk)
  (cadr thunk))
(define (thunk-env thunk)
  (caddr thunk))
(define (thunk-value evaluated-thunk)
  (cadr evaluated-thunk))

(define (delay-it exp env)
  (list 'thunk exp env))
(define (delay-it-memo exp env)
  (list 'thunk-memo exp env))

(define (force-it obj)
  (cond ((thunk? obj)
         (actual-value (thunk-exp obj) (thunk-env obj)))
        ((thunk-memo? obj)
         (let ((result (actual-value (thunk-exp obj) (thunk-env obj))))
           (set-car! obj 'evaluated-thunk)
           (set-car! (cdr obj) result)
           (set-cdr! (cdr obj) '())
           result))
        ((evaluated-thunk? obj)
         (thunk-value obj))
        (else obj)))

(define (actual-value exp env)
  (force-it (eval exp env)))

;; List of arguments

(define (lazy-param? param)
  (and (pair? param) (eq? 'lazy (cadr param))))
(define (lazy-memo-param? param)
  (and (pair? param) (eq? 'lazy-memo (cadr param))))

(define (list-of-thunked-arguments params exps env)
  (if (no-operands? exps)
      '()
      (let ((curr-param (car params))
            (curr-operand (first-operand exps)))
        (cond ((lazy-param? curr-param)
               (cons (delay-it curr-operand env)
                     (list-of-thunked-arguments
                      (cdr params) (rest-operands exps) env)))
              ((lazy-memo-param? curr-param)
               (cons (delay-it-memo curr-operand env)
                     (list-of-thunked-arguments
                      (cdr params) (rest-operands exps) env)))
              (else (cons (actual-value curr-operand the-global-environment)
                          (list-of-thunked-arguments
                           (cdr params) (rest-operands exps) env)))))))

(define (list-of-arg-values exps env)
  (if (no-operands? exps)
      '()
      (cons (actual-value (first-operand exps) env)
            (list-of-arg-values (rest-operands exps) env))))

;; Miscellaneous

(define (extract-param-name param)
  (if (or (lazy-memo-param? param) (lazy-param? param))
      (car param)
      param))

(define (procedure-parameters p)
  (cadr p))
(define (procedure-parameter-names p)
  (map extract-param-name (cadr p)))

;; Driver loop

(define input-prompt ";;; LM-Eval input:")
(define output-prompt ";;; LM-Eval value:")

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output
           (actual-value input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))
