(load "exercise.3.16.scm")

(define (count-unique-pairs x)
  (define (iter x already-seen)
    (if (or (memq x already-seen) (not (pair? x)))
        (begin
          (length already-seen))
        (let ((new-already-seen (cons x already-seen)))
          (max
           (iter (car x) new-already-seen)
           (iter (cdr x) new-already-seen)))))
  (iter x '()))

(= 0 (count-unique-pairs '()))
(= 1 (count-unique-pairs '(a)))
(= 2 (count-unique-pairs '(a b)))
(= 3 (count-unique-pairs '(((a)))))
(count-unique-pairs '(a b c))
(count-unique-pairs (return-4))
(count-unique-pairs '((a b) (c d) e))
(count-unique-pairs (make-cycle '(a b c)))
