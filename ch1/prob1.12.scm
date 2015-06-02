;;     1
;;    1  1
;;   1  2  1
;;  1  3  3  1
;; 1  4  6  4  1
;;
;; OR, to see the recursive pattern better:
;;
;; 1
;; 1 1
;; 1 2 1
;; 1 3 3 1
;; 1 4 6 4 1
;;
;; (pascals-triangle 0 0) = 1

(define (pascals-triangle row column)
  (cond ((or (< row 0) (< column 0)) 0)
        ((or (= column 0) (= column row)) 1)
        (else (+ (pascals-triangle (- row 1) (- column 1))
                 (pascals-triangle (- row 1) column)))))
