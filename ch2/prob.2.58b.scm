(load "prob.2.58a.scm")

;; I got tripped up on this problem for a while. It turns out solving the whole
;; thing is equivalent to solving part (a) and then adding specialized code to
;; remove the need for parentheses while still respecting the order of
;; operations.
(define example '(x + 3 * (x + y + 2)))

(define (simplify exp)
  (if (null? (cdr exp)) (car exp) exp))

(define (augend s) (simplify (cddr s)))
(define (multiplicand p) (simplify (cddr p)))
