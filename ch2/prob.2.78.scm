;; Goal: Modify type tagging methods to work with built-in scheme types.

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (cond ((pair? datum) (car datum))
        ((number? datum) 'scheme-number)
        ((symbol? datum) 'scheme-symbol)
        (else
         (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (cond ((pair? datum) (cdr datum))
        ((number? datum) datum)
        ((symbol? datum) datum)
        (else
         (error "Bad tagged datum -- TYPE-TAG" datum))))
