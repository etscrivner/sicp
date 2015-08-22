(load "logic-puzzles.scm")

(define (examination-problem)
  (let ((betty (amb 1 2 3 4 5))
        (ethel (amb 1 2 3 4 5))
        (joan (amb 1 2 3 4 5))
        (kitty (amb 1 2 3 4 5))
        (mary (amb 1 2 3 4 5)))
    (require (distinct? (list betty ethel joan kitty mary)))
    (require (amb (= kitty 2) (= betty 1)))
    (require (amb (= ethel 1) (= joan 2)))
    (require (amb (= joan 3) (= ethel 5)))
    (require (amb (= kitty 2) (= mary 4)))
    (require (amb (= mary 4) (= betty 1)))
    (list (list 'betty betty)
          (list 'ethel ethel)
          (list 'joan joan)
          (list 'kitty kitty)
          (list 'mary mary))))