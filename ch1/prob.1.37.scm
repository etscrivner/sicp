(define (cont-frac n d k)
  (if (= k 1)
      (/ (n k) (d k))
      (/ (n k) (+ (d k) (cont-frac n d (- k 1))))))

;; 11 iterations to get 1/phi accurate to 4 decimal points

(define (cont-frac-iter n d k)
  (define (iter accum k)
    (if (= k 0)
        accum
        (iter (/ (n k) (+ (d k) accum)) (- k 1))))
  (iter (/ (n k) (d k)) (- k 1)))
