(load "interpreter.scm")

(define (cond-action-recipient args)
  (caddr args))
(define (cond-action-clause? clause)
  (eq? (car (cond-actions clause)) '=>))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF"
                       clauses))
            (if (cond-action-clause? first)
                (let ((recipient (cond-action-recipient first)))
                  (list
                   (make-lambda
                    (list 'result)
                    (list (make-if 'result
                                   (list recipient 'result)
                                   (expand-clauses rest))))
                   (cond-predicate first)))
                (make-if (cond-predicate first)
                         (sequence->exp (cond-actions first))
                         (expand-clauses rest)))))))
