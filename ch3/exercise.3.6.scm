(define random-init 1019823)

;; Linear congruential generator with constants from Wikipedia
(define (rand-update x)
  (modulo (+ (* 1664525 x) 1013904223) (expt 2 32)))

(define rand
  (let ((x random-init))
    (lambda (op . args)
      (cond ((eq? op 'generate)
             (set! x (rand-update x))
             x)
            ((eq? op 'reset)
             (set! x (car args)))
            (else (error "Uncrecognized operation -- RAND" op))))))
