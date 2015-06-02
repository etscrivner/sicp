(define zero (lambda (f) (lambda (x) x)))
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define (add g h)
  (lambda (f) (lambda (x) (g f (h f x)))))


;; one by substitution
;; (add-1 (lambda (f) (lambda (x) x)))
;; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
;; (lambda (f) (lambda (x) (f ((lambda (x) x) x))))
;; (lambda (f) (lambda (x) (f x)))

;; two by substitution
;; (add-1 (lambda (f) (lambda (x) (f x))))
;; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
;; (lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
;; (lambda (f) (lambda (x) (f (f x))))
