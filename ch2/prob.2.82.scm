(load "generic-operations.scm")

(define (scheme-number->complex n)
  (make-complex-from-real-imag (contents n) 0))
(define (rational->complex n)
  (make-complex-from-real-imag (/ (car (contents n))
                                  (cdr (contents n)))
                               0))
(put-coercion 'scheme-number 'complex scheme-number->complex)
(put-coercion 'rational 'complex rational->complex)

(define (not-false x) x)

(define (not-null? x)
  (not (null? x)))

(define (all f lst . reduce-fn)
  (let ((rfn (if (not-null? reduce-fn) (car reduce-fn) (lambda (x y) (and x y)))))
    (reduce rfn
            #t
            (map f lst))))

(define (apply-each fns args)
  (define (iter result remaining-fns remaining-args)
    (if (or (null? remaining-fns) (null? remaining-args))
        result
        (iter
         (append result (list ((car remaining-fns) (car remaining-args))))
         (cdr remaining-fns)
         (cdr remaining-args))))
  (iter '() fns args))

;; The basic idea is, for each argument, to try coercing all the other arguments
;; to its type. If we find a coercion that works, then we stick with it.
(define (coerce args)
  (define (get-coercion-fns to-type types)
    (map (lambda (x) (get-coercion x to-type)) types))
  (define (iter head tail)
    (if (null? tail)
        '()
        (let ((curr-type (type-tag (car tail)))
              (head-types (map type-tag head))
              (tail-types (map type-tag (cdr tail))))
          (let ((head-coercion-fns (get-coercion-fns curr-type head-types))
                (tail-coercion-fns (get-coercion-fns curr-type tail-types)))
            (if (all not-false (append head-coercion-fns tail-coercion-fns))
                (append (apply-each head-coercion-fns head)
                        (list (car tail))
                        (apply-each tail-coercion-fns (cdr tail)))
                (iter (append head (list (car tail))) (cdr tail)))))))
  (iter '() args))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((coerced-args (coerce args)))
            (if (not (null? coerced-args))
                (apply apply-generic 
                       (append (list op) coerced-args))
                (error "No method for these types"
                       (list op type-tags))))))))

;; This fails whenever there is a type, outside of the types of the given
;; arguments, that all the arguments could be coerced to.
