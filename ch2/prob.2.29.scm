(define (make-branch length structure)
  (cons length structure))
(define (make-mobile left right)
  (cons left right))

;; Part a

(define (left-branch m)
  (car m))
(define (right-branch m)
  (cdr m))

(define (branch-length b)
  (car b))
(define (branch-structure b)
  (cdr b))

;; Part b

(define (total-weight-branch branch)
  (let ((st (branch-structure branch)))
    (if (not (pair? st))
        st
        (total-weight st))))

(define (total-weight mobile)
  (+ (total-weight-branch (left-branch mobile))
     (total-weight-branch (right-branch mobile))))

;; Part c

(define (torque-branch branch)
  (let ((st (branch-structure branch)))
    (if (not (pair? st))
        (* (branch-length branch) st)
        (torque-mobile st))))

(define (torque-mobile mobile)
  (+ (torque-branch (left-branch mobile))
     (torque-branch (right-branch mobile))))

(define (is-balanced-branch? branch)
  (let ((st (branch-structure branch)))
    (if (not (pair? st))
      true
      (is-balanced? st))))

(define (is-balanced? mobile)
  (and (= (torque-branch (left-branch mobile))
          (torque-branch (right-branch mobile)))
       (is-balanced-branch? (left-branch mobile))
       (is-balanced-branch? (right-branch mobile))))

(define test-mobile (make-mobile (make-branch 1 (make-mobile (make-branch 1 2)
                                                             (make-branch 2 1)))
                                 (make-branch 1 (make-mobile (make-branch 1 2)
                                                             (make-branch 2 1)))))
