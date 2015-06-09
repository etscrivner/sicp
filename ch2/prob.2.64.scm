(load "tree-set.scm")

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

;;; (A) Partial tree works by constructing a balanced tree through repeated
;;; subdivision. It does this by allocating successively smaller halves of the
;;; given list to the left and right branches respectfully. It thus constructs
;;; a balanced tree whose in-order traversal will yield the original list.

;;; (B) If we equate steps to calls to partial tree then the algorithm is
;;; Theta(n) or more closely Theta(2n) since each element in the tree requires
;;; two additional calls to partial-tree for the left and right branches.
