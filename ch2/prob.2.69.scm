(load "prob.2.68.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (make-tree elem1 elem2)
  (if (leaf? elem1)
      (make-code-tree elem1 elem2)
      (make-code-tree elem2 elem1)))

(define (successive-merge leaves)
  (if (null? leaves)
      '()
      (let ((first (car leaves)) (rest (cdr leaves)))
        (cond ((null? rest) first)
              (else (let ((partial-tree (make-tree (car rest) first)))
                      (successive-merge
                       (adjoin-set partial-tree (cdr rest)))))))))
