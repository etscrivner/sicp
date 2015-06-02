(load "prob.2.36.scm")

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (row) (accumulate + 0 (map * v row))) m))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row)) m)))

(define (transpose mat)
  (accumulate-n cons '() mat))

(define m '((1 2 3 4) (4 5 6 6) (6 7 8 9)))
(define v '(2 3 4 5))

(define m1 '((1 2) (3 4)))
(define n1 '((2 3) (4 5)))
