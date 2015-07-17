(load "exercise.3.54.scm")

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (let ((s1weight (weight s1car))
                 (s2weight (weight s2car)))
             (cond ((< s1weight s2weight)
                    (cons-stream s1car (merge-weighted (stream-cdr s1) s2 weight)))
                   ((> s1weight s2weight)
                    (cons-stream s2car (merge-weighted s1 (stream-cdr s2) weight)))
                   (else
                    (cons-stream s1car
                                 (merge-weighted (stream-cdr s1) (stream-cdr s2) weight)))))))))

(define (pairs-weighted s t weight)
  (let ((all-pairs (pairs s t)))
    (merge-weighted all-pairs all-pairs weight)))

(define sum-weight
  (pairs-weighted integers integers (lambda (x) (+ (car x) (cadr x)))))

(define (not-divisible-by-values p)
  (define (is-divisible? x)
    (or (= 0 (remainder x 2))
        (= 0 (remainder x 3))
        (= 0 (remainder x 5))))
  (not (or (is-divisible? (car p)) (is-divisible? (cadr p)))))

(define (sum-of-prods p)
  (let ((i (car p))
        (j (cadr p)))
    (+ (* 2 i) (* 3 j) (* 5 i j))))

(define other-one
  (stream-filter
   not-divisible-by-values
   (pairs-weighted integers integers sum-of-prods)))
