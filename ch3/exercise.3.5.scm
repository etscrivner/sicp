(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))


;; Cesaro test
(define (cesaro-test)
  (= (gcd (random (expt 10 30)) (random (expt 10 30))) 1))
(define (cesaro-estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

;; Integral estimation
(define (make-experiment pred x1 y1 x2 y2)
  (lambda ()
    (pred (random-in-range x1 x2) (random-in-range y1 y2))))
(define (estimate-integral pred x1 y1 x2 y2 trials)
  (define (experiment)
    (pred (random-in-range x1 x2) (random-in-range y1 y2)))
  (monte-carlo trials experiment))

(define (make-circle-predicate cx cy r)
  (lambda (x y)
    (<= (+ (expt (- x cx) 2) (expt (- y cy) 2))
        (expt r 2))))
(define (integral-estimate-pi trials)
  (let ((area-ratio (estimate-integral (make-circle-predicate 2 2 1)
                                       1 1 3 3 trials)))
    (* area-ratio 4.0)))
