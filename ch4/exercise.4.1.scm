(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))

(define (list-of-values-ltor exps env)
  (if (no-operands? exps)
      '()
      (let ((left-result (eval (first-operand exps) env)))
        (cons left-result
              (list-of-values-ltor (rest-operands exps) env)))))

(define (list-of-values-rtol exps env)
  (if (no-operands? exps)
      '()
      (let ((right-result (list-of-values-rtol 
                           (rest-operands exps) env)))
        (cons (eval (first-operand exps) env)
              right-result))))
