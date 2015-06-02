(load "prob.2.58a.scm")

;; The general strategy here derives from the observation that even in infix
;; form the operators are still binary operators of the from lv op rv. So when
;; we take the derivative and reduce we simply process three items at a time.
;; One will the the left-hand value (lv), one will be the operator (op), and
;; one will be the right-hand value.
