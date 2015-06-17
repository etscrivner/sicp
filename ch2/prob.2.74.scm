;; We would implement this using the same data-directed programming approach.
;; Each division would write its own installation package. Each package will
;; contain record construction and retrieval procedures specific to that
;; package. All outgoing records are tagged, all incoming records have their
;; tags checked. Then a set of generic procedures for constructing, reading,
;; and writing records is provided and placed into the global operation table
;; by each division's installation method. The remaining work of writing the
;; procedures is as simle as follows.

(define (get-record employee-name record-file)
  ;;; At this point we don't require any special structuring of the file, just
  ;;; that the table installation for the given record file has occurred and
  ;;; that the result of calling get-record comes back in an accessible format
  ;;; or returns '() if no record could be found.
  ((get 'get-record record-file) employee-name))

(define (get-salary employee-name record-file)
  ;;; Still no special structuring required
  ((get 'get-attribute 'salary record-file)
   (get-record employee-name record-file)))

(define (find-employee-record employee-name files)
  (define (iter remaining-files)
    (if (null? remaining-files)
        return '()
        (let ((record (get-record employee-name (car files))))
          (if (null? record)
              (iter employee-name (cdr files))
              record))))
  (iter employee-name files))

;; (d) a package installing interfaces for the new personnel files must be
;; provided.
