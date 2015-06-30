(load "table.scm")

(define (make-general-table)
  (let ((local-table (list '*table*)))
    (define (insert! value . keys)
      (define (iter remaining-keys table)
        (if (null? (cdr remaining-keys))
            (set-cdr! table
                      (cons (cons (car remaining-keys) value)
                            (cdr table)))
            (let ((key (car remaining-keys)))
              (let ((record (assoc key (cdr table))))
                (cond (record
                       (set-cdr! record '())
                       (iter (cdr remaining-keys) record))
                      (else
                       (set-cdr! table
                                 (cons (list key '()) (cdr table)))
                       (iter (cdr remaining-keys) (cdr table))))))))
      (iter keys local-table)
      'ok)
    (define (lookup . keys)
      (define (iter keys table)
        (cond ((null? keys) false)
              (else
               (let ((record (assoc (car keys) (cdr table))))
                 (if record
                     (if (null? (cdr keys))
                         (cdr record)
                         (iter (cdr keys) (cdr table)))
                     false)))))
      (iter keys local-table))
    (define (dispatch m)
      (cond ((eq? m 'insert-proc!) insert!)
            ((eq? m 'lookup-proc) lookup)
            ((eq? m 'get) local-table)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))
