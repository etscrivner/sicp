(load "symbolic-diff.scm")
(load "put-get.scm")

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else
         (let ((f (get 'deriv (list (operator exp)))))
           (if f
               (f (operands exp) var)
               (error "No derivative method for operator" (operator exp)))))))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

;; (a) Because the types of numbers and variables are defined within Scheme
;; itself rather than using our type annotation system.

;; (b)

(define (install-deriv-sum)
  ;; internal procedures
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  (define (sum? x)
    (and (pair? x) (eq? (car x) '+)))
  (define (addend s)
    (car s))
  (define (augend s)
    (cadr s))

  (define (deriv-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))
  
  ;; interface to the rest of the system
  (put 'deriv '(+) deriv-sum)
  (put 'make-sum '(+) make-sum))

(define (install-deriv-product)
  ;; internal procedures
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))
  (define (product? x)
    (and (pair? x) (eq? (car x) '*)))
  (define (multiplier p)
    (car p))
  (define (multiplicand p)
    (cadr p))
  (define (deriv-product exp var)
    ((get 'make-sum '(+))
     (make-product (multiplier exp)
                   (deriv (multiplicand exp) var))
     (make-product (multiplicand exp)
                   (deriv (multiplier exp) var))))
  ;;
  (put 'deriv '(*) deriv-product)
  (put 'make-product '(*) make-product)
)

;; (c)

(define (install-deriv-expt)
  (define (exponentation? exp)
    (and (pair? exp) (eq? (car exp) '**)))
  (define (base exp)
    (car exp))
  (define (exponent exp)
    (cadr exp))
  (define (make-exponentiation b exp)
    (cond ((or (=number? b 1) (=number? exp 0)) 1)
          ((=number? exp 1) b)
          (else (list '** b exp))))
  (define (deriv-expt exp var)
    ((get 'make-product '(*))
     ((get 'make-product '(*))
      (exponent exp)
      (make-exponentiation (base exp) (- (exponent exp) 1)))
     (deriv (base exp) var)))

  (put 'deriv '(**) deriv-expt)
)

;; (d) Every put statement also need to be swapped.
