;; Y combinator for factorials
((lambda (n)
   ((lambda (fact)
      (fact fact n))
    (lambda (ft k)
      (if (= k 1)
          1
          (* k (ft ft (- k 1)))))))
 10)

;; Y combinator for fibonacci numbers
((lambda (n)
   ((lambda (fib)
      (fib fib n))
    (lambda (fb k)
      (cond ((< k 1) 0)
            ((< k 3) 1)
            (else (+ (fb fb (- k 2)) (fb fb (- k 1))))))))
 9)

;; Y combinator for mututally recursive methods
(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) true (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) false (ev? ev? od? (- n 1))))))
