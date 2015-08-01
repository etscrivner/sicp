;; (until <pred>
;;   <body>)
;;
;; Transforms to:
;;
;; (let until-loop ((result <pred>))
;;   (if result
;;     'done
;;     (begin <body>
;;            (until-loop))))
(load "interpreter.scm")

(define until-test
  '(until (= x 3)
          (set! x (+ x 1))))

(define (until? exp)
  (tagged-list? exp 'until))

(define (until-predicate exp)
  (cadr exp))
(define (until-body exp)
  (cddr exp))

(define (until->named-let exp)
  (list 'let 'until-loop
        '()
        (make-if (until-predicate exp)
                 '(quote done)
                 (make-begin (append (until-body exp)
                                     (list 'until-loop))))))
