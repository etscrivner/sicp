(define (let? exp)
  (tagged-list? exp 'let))
(define (let-definitions exp)
  (cadr exp))
(define (let-body exp)
  (cddr exp))

(define (named-let? exp)
  (not (list? (cadr exp))))
(define (named-let-name exp)
  (cadr exp))
(define (named-let-definitions exp)
  (caddr exp))
(define (named-let-body exp)
  (cdddr exp))

(define (let-definitions-variables defs)
  (map car defs))
(define (let-definitions-values defs)
  (map cadr defs))

(define (let->combination exp)
  (if (named-let? exp)
      (let ((defs (named-let-definitions exp)))
        (make-begin
         (list
          (list 'define (named-let-name exp)
                (make-lambda (let-definitions-variables defs)
                             (named-let-body exp)))
          (cons (named-let-name exp) (let-definitions-values defs)))))
      (let ((defs (let-definitions exp)))
        (list (make-lambda (let-definitions-variables defs)
                           (let-body exp))
              (let-definitions-values defs)))))
