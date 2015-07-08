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
  (let ((cell (list false)))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-semaphore 'acquire)
                 (begin (set! n (- n 1))
                        (clear! cell))))
            ((eq? m 'release)
             (if (test-and-set! cell)
                 (the-semaphore 'release)
                 (begin (set! n (+ n 1))
                        (clear! cell))))
            ((eq? m 'count) n)))
    the-semaphore))
