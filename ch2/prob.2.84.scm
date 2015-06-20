(load "prob.2.83.scm")

(define (num-raises-to-top arg)
  (define (iter num-raises curr-arg)
    (let ((proc (get 'raise (list (type-tag curr-arg)))))
      (if proc
          (iter (+ 1 num-raises) (raise curr-arg))
          num-raises)))
  (iter 0 arg))

(define (n-raises arg num-raises)
  (if (<= num-raises 0)
      arg
      (n-raises (raise arg) (- num-raises 1))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((raises-a1 (num-raises-to-top (car args)))
                    (raises-a2 (num-raises-to-top (cadr args)))
                    (a1 (car args))
                    (a2 (cadr args)))
                (cond ((< raises-a1 raises-a2)
                       (apply-generic op a1 (n-raises a2 (- raises-a2 raises-a1))))
                      ((< raises-a2 raises-a1)
                       (apply-generic op (n-raises a1 (- raises-a1 raises-a2)) a2))
                      (else
                       (error "Items cannot be raised" (list op a1 a2)))))
              (error "No method for these types"
                     (list op type-tags)))))))
