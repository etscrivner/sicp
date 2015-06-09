(load "tree-set.scm")

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))


;;; a) Both produce the same results as both amount to an in-order traversal.

;;; b) Both or Theta(n) unless we dig into the implementation of append in the
;;; first method in which case tree->list-1 = Theta(nlogn) and tree->list-2 =
;;; Theta(n).
