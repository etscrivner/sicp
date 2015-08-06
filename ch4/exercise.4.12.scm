;; These can still be remolded to be a little bit nicer

(define (frame-find-variable var found-action not-found-action frame)
  (define (iter vars vals)
    (cond ((or (null? vars) (null? vals))
           (not-found-action frame))
          ((eq? var (car vars))
           (found-action vars vals))
          (else (iter (cdr vars) (cdr vals)))))
  (iter (frame-variables frame) (frame-values frame)))

(define (environment-traverse f error-action env)
  (cond ((eq? env the-empty-environment)
         (error-action))
        (else
         (let ((result (f (first-frame env))))
           (if result
               result
               (environment-traverse f error-action (enclosing-environment env)))))))

(define (lookup-variable-value var env)
  (environment-traverse
   (lambda (frame)
     (frame-find-variable var (lambda (vars vals) (car vals)) (lambda (x) false) frame))
   (lambda () (error "Unbound variable" var))
   env))

(define (set-variable-value! var val env)
  (environment-traverse
   (lambda (frame)
     (frame-find-variable
      var (lambda (vars vals) (set-car! vals val)) (lambda (x) false) frame))
   (lambda () (error "Unbound variable" var))
   env))

(define (define-variable var val env)
  (environment-traverse
   (lambda (frame)
     (frame-find-variable
      var
      (lambda (vars vals) (set-car! vals val))
      (lambda (x) (add-binding-to-frame! var val x) false)
      frame))
   (lambda () 'done)
   env))
