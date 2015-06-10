(load "prob.2.63.scm")
(load "prob.2.64.scm")

(define (union-lists lst1 lst2)
  (cond ((null? lst1) lst2)
        ((null? lst2) lst1)
        (else
         (let ((x1 (car lst1)) (x2 (car lst2)))
           (cond ((= x1 x2)
                  (cons x1
                        (sorted-merge-lists (cdr lst1)
                                            (cdr lst2))))
                 ((< x1 x2)
                  (cons x1
                        (sorted-merge-lists (cdr lst1)
                                            lst2)))
                 ((> x1 x2)
                  (cons x2
                        (sorted-merge-lists lst1
                                            (cdr lst2)))))))))

(define (intersection-lists lst1 lst2)
  (if (or (null? lst1) (null? lst2))
      '()
      (let ((x1 (car lst1)) (x2 (car lst2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-lists (cdr lst1)
                                       (cdr lst2))))
              ((< x1 x2)
               (intersection-lists (cdr lst1) lst2))
              ((< x2 x1)
               (intersection-lists lst1 (cdr lst2)))))))

(define (union-set set1 set2)
     (let ((lst1 (tree->list-2 set1))
           (lst2 (tree->list-2 set2)))
       (list->tree (sorted-merge-lists lst1 lst2))))


(define (intersection-set set1 set2)
  (let ((lst1 (tree->list-2 set1))
        (lst2 (tree->list-2 set2)))
    (list->tree (intersection-lists lst1 lst2))))
