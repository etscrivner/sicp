;; Firstly, we assume magnitude is defined as follows

(define (magnitude x)
  (apply-generic 'magnitude x))

;; This fails for the complex number because the only types that have
;; registered a 'magnitude method are 'polar and 'rectangular. Since the first
;; result from (type-tag ...) on x is 'complex the lookup in the global table
;; fails. Giving the error described.

;; (apply-generic ..) will be called twice - once for the complex object,
;; returning the generic magnitude method from the rectangular/polar package.
;; This will then call (apply-generic ...) a second time to resolve down to the
;; function from either the rectangular or polar package.

