(load "exercise.3.70.scm")

(define (cube x)
  (* x x x))

(define (sum-of-cubes p)
  (+ (cube (car p)) (cube (cadr p))))

(define sum-of-cubes-stream (pairs-weighted integers integers sum-of-cubes))

(define other-stream (stream-map sum-of-cubes sum-of-cubes-stream))

(define (filter-consecutive stream pred)
  (if (stream-null? stream)
       the-empty-stream
       (if (pred (stream-car stream) (stream-car (stream-cdr stream)))
           (cons-stream (list (stream-car stream) (stream-car (stream-cdr stream)))
                        (filter-consecutive (stream-cdr (stream-cdr stream))
                                            pred))
           (filter-consecutive (stream-cdr stream) pred))))

(define ramanujan-stream
  (stream-map
   (lambda (x) (sum-of-cubes (stream-car x)))
   (filter-consecutive sum-of-cubes-stream
                       (lambda (x y) (= (sum-of-cubes x) (sum-of-cubes y))))))

;; (define ramanujan-stream
;;   (stream-filter
;;    same-weight sum-of-cubes-pairs))
