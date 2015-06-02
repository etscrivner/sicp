(define (unique-triples n)
  (flatmap
   (lambda (i)
     (flatmap (lambda (j) (map (lambda (k) (list i j k)) (enumerate-interval 1 (- j 1))))
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 3 n)))

(define (sum-to? triple n)
  (= n (+ (car triple) (cadr triple) (caddr triple))))

(define (triples-that-sum-to n)
  (filter (lambda (tr) (sum-to? tr n)) (unique-triples 10)))
