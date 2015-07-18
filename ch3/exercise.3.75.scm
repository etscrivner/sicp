(define (make-zero-crossings input-stream last-value current-sum num-items-so-far)
  (let ((avpt (/ (+ (stream-car stream) current-sum) num-items-so-far)))
    (cons-stream (sign-change-detector avpt last-value)
                 (make-zero-crossings (stream-cdr input-stream)
                                      avpt
                                      (+ (stream-car input-stream) current-sum)
                                      (+ 1 num-items-so-far)))))
