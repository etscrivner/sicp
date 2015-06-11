(load "prob.2.69.scm")

(define frequency-list
  '((WAH 1) (BOOM 1) (A 2) (GET 2) (JOB 2) (NA 16) (SHA 3) (YIP 9)))

(define message
  '(
    Get a job
    Sha na na na na na na na na
    Get a job
    Sha na na na na na na na na
    Wah yip yip yip yip yip yip yip yip yip
    Sha boom))

;; Number of bits w/ Huffman encoding (84 bits)
(length (encode message (generate-huffman-tree frequency-list)))

;; Smallest number of bits with fixed-length encoding (108 bits)
(* (length message) (/ (log (length frequency-list)) (log 2)))
