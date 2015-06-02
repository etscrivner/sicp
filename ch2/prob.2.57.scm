(load "prob.2.56.scm")

(define (variable-or-pair? x)
  (or (pair? x) (variable? x)))

(define (extract-vars exps)
  (filter variable-or-pair? exps))

(define (reduce-numbers op start args)
  (reduce op start (filter number? args)))

(define (make-sum . args)
  (let ((vars (extract-vars args))
        (num (reduce-numbers + 0 args)))
    (cond ((null? vars) num)
          ((= num 0)
           (if (= (length vars) 1)
               (car vars)
               (append '(+) vars)))
          (else 
           (append '(+) vars (list num))))))

(define (addend s)
  (cadr s))

(define (augend s)
  (apply make-sum (cddr s)))

(define (make-product . args)
  (let ((vars (extract-vars args))
        (prod (reduce-numbers * 1 args)))
    (cond ((null? vars) prod)
          ((= prod 0) 0)
          ((= prod 1)
           (if (= (length vars) 1)
               (car vars)
               (append '(*) vars)))
          (else (append '(*) (list prod) vars)))))

(define (multiplier p)
  (cadr p))

(define (multiplicand p)
  (apply make-product (cddr p)))
