(define (let? exp)
  (tagged-list? exp 'let))

(define (let-definitions exp)
  (cadr exp))
(define (let-definitions-variables defs)
  (map car defs))
(define (let-definitions-values defs)
  (map cadr defs))

(define (let-body exp)
  (cddr exp))

(define (let->combination exp)
  (let ((defs (let-definitions exp)))
    (list (make-lambda (let-definitions-variables defs)
                       (let-body exp))
          (let-definitions-values defs))))
