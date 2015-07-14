(load "exercise.3.59.scm")
(load "exercise.3.61.scm")

(define (div-series s1 s2)
  (if (= 0 (stream-car s2))
      (error "DIV-SERIES -- Denominator with 0 constant term.")
      (mul-series s1 (invert-unit-series s2))))

(define tangent-series (div-series sine-series cosine-series))
