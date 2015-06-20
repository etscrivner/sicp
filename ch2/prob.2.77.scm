(load "generic-operations.scm")
;; Firstly, we assume magnitude is defined as follows

(define (magnitude x)
  (apply-generic 'magnitude x))

;; This fails for the complex number because the only types that have
;; registered a 'magnitude method are 'polar and 'rectangular. Since the first
;; result from (type-tag ...) on x is 'complex the lookup in the global table
;; fails. Giving the error described.

(put 'magnitude 'complex magnitude)

;; (magnitude ..) will be called twice - once for the complex object, where
;; apply-generic will attempt to recursively apply magnitude to the contents of
;; the initial value, stripping off the 'complex tag. The recursive call to
;; magnitude will then use the 'rectangular or 'polar tag remaning to forward
;; the call on to the appropriate method.
