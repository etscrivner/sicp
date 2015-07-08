(load "serializer.scm")

(define (make-semaphore-mutex n)
  (let ((s (make-serializer)))
    (define (check-and-update!)
      ((s (lambda ()
            (if (> n 0)
                (begin (set! n (- n 1))
                       false)
                true)))))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
              (if (check-and-update!)
                  (the-semaphore 'acquire)))
            ((eq? m 'release)
             ((s (lambda () (set! n (+ n 1))))))
            ((eq? m 'can-acquire?)
             ((s (lambda () (> n 0)))))))
    the-semaphore))

(define (make-semaphore-tas n)
  (let ((cells '()))
    (define (the-semaphore m)
      (cond ((eq? m' acquire)
             (if (can-acquire?)
                 ()))))))
