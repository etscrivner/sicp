(load "streams.scm")
(load "exercise.3.50.scm")

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

(define (div-streams s1 s2)
  (stream-map / s1 s2))

;;; Part a

(define (integrate-series stream)
  (cons-stream
   (stream-car stream)
   (div-streams (stream-cdr stream)
                (stream-cdr integers))))

;;; Part b

(define exp-series (cons-stream 1 (integrate-series exp-series)))

(define cosine-series
  (cons-stream 1
               (integrate-series (stream-map (lambda (x) (* x -1)) sine-series))))
(define sine-series (cons-stream 0 (integrate-series cosine-series)))
