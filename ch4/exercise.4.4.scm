(load "interpreter.scm")

(define (eval-and exps env)
  (cond ((last-exp? exps) (true? (eval (first-exp exps) env)))
        (else (let ((eval-result (eval (first-exp exps) env)))
                (if (true? eval-result)
                    (eval-and (rest-exps exps) env)
                    eval-result)))))

(define (eval-or exps env)
  (cond ((last-exp? exps) (true? (eval (first-exp exps) env)))
        (else (let ((eval-result (eval (first-exp exps) env)))
                (if (true? eval-result)
                    eval-result
                    (eval-or (rest-exps exps) env))))))

