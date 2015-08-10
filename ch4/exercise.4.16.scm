(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (let ((result (car vals)))
               (if (eq? result '*unassigned*)
                   (error "Referenced variable before assignment" var)
                   result)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (scan-out-defines body)
  (let ((defines (filter definition? body))
        (rest-of-body (filter (lambda (x) (not (definition? x))) body)))
    (if (null? defines)
        body
        (let ((variable-names (map definition-variable defines))
              (variable-values (map definition-value defines)))
          (list (make-let variable-names
                          (make-list (length variable-names)
                                     '(quote *unassigned*))
                          (append
                           (map (lambda (x y) (list 'set! x y))
                                variable-names variable-values)
                           rest-of-body)))))))

;; make-procedure is better as this allows for a procedure to be evaluated many
;; times without having to rescan out the definitions each time.
(define (make-procedure parameters body env)
  (list 'procedure parameters (scan-out-defines body) env))

;; Testing
(define test-proc '(lambda (r) (let ((pi 3.141)) (* 2 pi r))))
(define better-test-proc
  '(lambda (r) (define pi (+ 1 m)) (define m (* 2 pi)) (* m pi r)))
