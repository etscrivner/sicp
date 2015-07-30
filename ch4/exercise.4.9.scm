;; (until <pred>
;;   <body>)
;;
;; Transforms to:
;;
;; (let until-loop ((result <pred>))
;;   (if result
;;     'done
;;     (begin <body>
;;            until-loop)))
(load "interpreter.scm")

(define until-test
  '(until (and (= y 12) (= x 3))
          (set! x (+ x 1))
          (set! y (* y x))))

(define (until? exp)
  (tagged-list? exp 'until))

(define (until-predicate exp)
  (cadr exp))
(define (until-body exp)
  (cddr exp))

(define (until->named-let exp)
  (list 'let 'until-loop
        (list (list 'result (until-predicate exp)))
        (make-if 'result
                 '(quote done)
                 (list (until-body exp)
                       (list 'until-loop)))))
