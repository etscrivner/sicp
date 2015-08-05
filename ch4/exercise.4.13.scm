(load "interpreter.scm")
(load "exercise.4.12.scm")

(define test-env (extend-environment '(a b c) '(1 2 3) the-empty-environment))
(define test-env-2 (extend-environment '(a d) '(12 "h") test-env))
(define test-frame (first-frame test-env-2))

;; Unbind from all environments

;; This is a bit messy, but it creates a pretty looking list
(define (create-unbound-environment var env)
  (define (env-loop new-env env)
    (define (scan new-frame vars vals)
      (cond ((null? vars)
             (env-loop (cons new-frame new-env) (enclosing-environment env)))
            ((eq? var (car vars))
             (scan new-frame (cdr vars) (cdr vals)))
            (else
             (add-binding-to-frame! (car vars) (car vals) new-frame)
             (scan new-frame (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        new-env
        (let ((frame (first-frame env)))
          (scan (make-frame '() '())
                (frame-variables frame)
                (frame-values frame)))))
  (reverse (env-loop the-empty-environment env)))

(define (make-unbound! var env)
  (let ((result (create-unbound-environment var env)))
    (set-car! env (car result))
    (set-cdr! env (cdr result))))

;; Unbind only from enclosing environment

(define (make-unbound! var env)
  (if (eq? env the-empty-environment)
      (error "Empty environment given -- MAKE-UNBOUND!")
      (let ((frame (first-frame env)))
        (define (scan vars vals)
          (cond ((null? vars)
                 (error "Unbound variable -- MAKE-UNBOUND!" var))
                ((eq? var (car vars))
                 (set-car! vars '())
                 (set-car! vals '()))
                (else (scan (cdr vars) (cdr vals)))))
        (scan (frame-variables frame)
              (frame-values frame)))))
