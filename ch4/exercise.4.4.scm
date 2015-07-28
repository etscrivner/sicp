(load "interpreter.scm")

(define (eval-and clauses env)
  (cond ((last-exp? clauses) (true? (eval (first-exp clauses) env)))
        (else (let ((eval-result (eval (first-exp clauses) env)))
                (if (true? eval-result)
                    (eval-and (rest-exps clauses) env)
                    eval-result)))))

(define (eval-or clauses env)
  (cond ((last-exp? clauses) (true? (eval (first-exp clauses) env)))
        (else (let ((eval-result (eval (first-exp clauses) env)))
                (if (true? eval-result)
                    eval-result
                    (eval-or (rest-exps clauses) env))))))


(define (eval-and-derived clauses env)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (make-if first (eval-and-derived rest env) 'false))))

(define (eval-or-derived clauses env)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (make-if first 'true (eval-or-derived rest env)))))
