(load "prob.2.67.scm")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (define (encoding result current-branch)
    (cond ((leaf? current-branch)
           (if (eq? symbol (symbol-leaf current-branch))
               result
               (error "bad symbol -- ENCODE-SYMBOL")))
          ((eq? (car (symbols current-branch)) symbol)
           (encoding (append result '(0)) (left-branch current-branch)))
          (else
           (encoding (append result '(1)) (right-branch current-branch)))))
  (encoding '() tree))
