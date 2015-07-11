;;; This was cobbled together from a handful of stack overflow tickets then
;;; tweaked to actually work by myself. Should work in MIT Scheme.

;;; delay/force

(define (memo-proc proc)
  (let ((already-run? false)
        (result false))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (proc))
                 (set! already-run? true)
                 result)
          result))))

(define-syntax delay
  (syntax-rules ()
    ((_ expr)
     (memo-proc (lambda () expr)))))

(define (force delayed-object)
  (delayed-object))

;;; streams

(define the-empty-stream '())

(define-syntax cons-stream
  (syntax-rules ()
    ((_ a b)
     (cons a (delay b)))))

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))
