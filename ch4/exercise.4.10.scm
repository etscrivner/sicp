(load "interpreter.scm")

;; Function definitions are now separate from variables.
;; (define VARNAME STMT)
;; (defun FUNCNAME (PARAM1 PARAM2 ...) <BODY>)
(define (definition? exp)
  (or (tagged-list? exp 'define)
      (tagged-list? exp 'defun)))

(define (definition-variable define)
  (cadr exp))

(define (definition-value exp)
  (if (tagged-list? exp 'define)
      (caddr exp)
      (make-lambda (caddr test)
                   (cdddr test))))
