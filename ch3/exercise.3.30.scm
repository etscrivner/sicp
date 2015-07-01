(load "circuits.scm")

(define (ripple-carry-adder a_k b_k s_k c)
  (define (iter a_r b_r s_r c-in)
    (if (or (null? a_r) (null? b_r) (null? s_r))
        'done
        (let ((c-out (make-wire)))
          (full-adder (car a_r)
                      (car b_r)
                      c-in
                      (car s_r)
                      c-out)
          (iter (cdr a_r) (cdr b_r) (cdr s_r) c-out))))
  (iter a_k b_k s_k c))

(define (ripple-carry-adder-delay n)
  (* n (+ (* 4 and-gate-delay)
          (* 3 or-gate-delay)
          (* 2 inverter-delay))))
