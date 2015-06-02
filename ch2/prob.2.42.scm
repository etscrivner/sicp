(load "prob.2.40.scm")

(define empty-board '())

(define (make-position row col)
  (cons row col))

(define (position-row pos)
  (car pos))

(define (position-col pos)
  (cdr pos))

(define (position-equal? pos1 pos2)
  (and (= (position-row pos1) (position-row pos2))
       (= (position-col pos1) (position-col pos2))))

(define (dangerous-positions curr-row curr-col board-size)
  (flatmap
   (lambda (x) (list (make-position (- curr-row x) (- curr-col x))
                     (make-position (- curr-row x) (+ curr-col x))
                     (make-position (+ curr-row x) (- curr-col x))
                     (make-position (+ curr-row x) (+ curr-col x))
                     (make-position curr-row (- curr-col x))
                     (make-position curr-row (+ curr-col x))))
   (enumerate-interval 1 (- board-size 1))))
  
(define (safe? board-size positions)
   (let ((bad-positions (dangerous-positions (position-row (car positions))
                                             (position-col (car positions))
                                             board-size))
        (rest (cdr positions)))
    (reduce (lambda (a b) (and a b))
            #t
            (flatmap 
             (lambda (x) (map (lambda (y) (not (position-equal? x y)))
                              bad-positions))
             rest))))

(define (adjoin-position new-row board-size rest-of-queens)
  (append (list (make-position new-row board-size)) rest-of-queens))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))
