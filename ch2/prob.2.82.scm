(define (not-null? x)
  (not (null? x)))

(define (all f lst . reduce-fn)
  (let ((rfn (if (not-null? reduce-fn) (car reduce-fn) (lambda (x y) (and x y)))))
    (reduce rfn
            #t
            (map f lst))))

(define (get-coercion-method type-tags)
  (define (iter type-tags-idx)
    (if (= type-tags-idx 0)
        '()
        (let ((next-type (list-ref type-tags type-tags-idx)))
          (let ((coercion-methods (map (lambda (x) (get-coercion next-type x))
                                       type-types)))
            (if (all not-null? coercion-methods)
                (cons (car coercion-methods) type-tags-idx)
                (iter (+ 1 type-tags-idx)))))))
  (iter 0))

(define (apply-to-all-except coerce args n)
    (define (iter idx)
      (if (>= idx (length args))
          '()
          (if (= n idx)
              (append (list (list-ref args idx))
                      (iter (+ idx 1)))
              (append (list (coerce (list-ref args idx)))
                      (iter (+ idx 1))))))
    (iter 0))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((tx->ty (get-coercion-method type-tags)))
            (if tx->ty
                (apply apply-generic 
                       (append (list op)
                               (apply-to-all-except (car tx->ty)
                                                    args
                                                    (cdr tx->ty))))
                (error "No method for these types"
                       (list op type-tags))))))))

;; This fails most simply for the above, generalized, system as well as for the
;; two argument case whenever there is a type outside of the types of the
;; available arguments that both could be coerced to.
