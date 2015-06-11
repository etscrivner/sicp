(load "prob.2.69.scm")

(define letters '(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z))

(define (generate-powers-of-two-freq-list current-exponent)
  (if (= 0 current-exponent)
      (list (list (list-ref letters 0) 1))
      (append (generate-powers-of-two-freq-list (- current-exponent 1))
              (list (list (list-ref letters current-exponent)
                          (expt 2 current-exponent))))))

;; Requires 5 symbols to encode 'A
(define pow-2-5 (generate-huffman-tree (generate-powers-of-two-freq-list 5)))
(length (encode-symbol 'A pow-2-5))
(length (encode-symbol 'F pow-2-5))

;; Requires 10 symbols to encode 'A
(define pow-2-10 (generate-huffman-tree (generate-powers-of-two-freq-list 10)))
(length (encode-symbol 'A pow-2-10))
(length (encode-symbol 'K pow-2-10))

;; In general, constructing a tree from items with frequencies that are
;; successive powers of two results in the least frequent symbol requiring
;; log_2(n) bits where n is the frequency of the most frequency element.
;; The most frequency symbol, on the other hand, always requires one bit.
