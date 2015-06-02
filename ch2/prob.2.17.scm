(define (last-pair lst)
  (if (or (null? lst) (null? (cdr lst)))
      lst
      (last-pair (cdr lst))))
