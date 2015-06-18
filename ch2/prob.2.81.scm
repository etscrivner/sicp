;; a
;; The program will enter an infinite loop as it keeps calling (apply-generic
;; ...) on the same two types.

;; b
;; (apply-generic ...) works correctly as is

;; c

  (define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
      (let ((proc (get op type-tags)))
        (if proc
            (apply proc (map contents args))
            (if (= (length args) 2)
                (let ((type1 (car type-tags))
                      (type2 (cadr type-tags)))
                  ;; Go further if types are not the same, otherwise err out
                  (if (not (equal? type1 type2))
                      (let ((a1 (car args))
                            (a2 (cadr args))
                            (t1->t2 (get-coercion type1 type2))
                            (t2->t1 (get-coercion type2 type1)))
                        (cond (t1->t2
                               (apply-generic op (t1->t2 a1) a2))
                              (t2->t1
                               (apply-generic op a1 (t2->t1 a2)))
                              (else (error "No method for these types"
                                           (list op type-tags)))))
                      (error "No method for these types"
                             (list op type-tags)))))))))
