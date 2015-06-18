;; I'm going to skip installing in packages so we can actually test.
(load "prob.2.1.scm")

(define (raise x)
  (cond ((integer? x) (/ x 1))
        ((rational? x) x)
        ((real? x) (make-rectangular x 1))
        (else (error "Cannot raise type" x))))

;; To actually implement we'd just given rational and real packages their
;; respective 'raise methods from the next lowest type.
