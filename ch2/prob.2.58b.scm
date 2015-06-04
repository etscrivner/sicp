(load "prob.2.58a.scm")

;; The general strategy here derives from the observation that even in infix
;; form the operators are still binary operators of the from lv op rv. So when
;; we take the derivative and reduce we simply process three items at a time.
;; One will the the left-hand value (lv), one will be the operator (op), and
;; one will be the right-hand value (rv). We might eventually group values with
;; similar expressions together for reduction. Additionally operator
;; precendence needs to be taken into account, so the computation can likely
;; only be performed after a full scan of the expression that rewrites with
;; correct operator precendence.
(define example '(3 + 2 + x))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else
         (append (if (pair? a1) a1 (list a1))
                 '(+)
                 (if (pair? a2) a2 (list a2))))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else
         (append (list m1)
                 '(*)
                 (list m2)))))

(define (sum? x)
  (eq? (cadr x) '+))

(define (addend s)
  (car s))
