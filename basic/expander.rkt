#lang br/quicklang

(struct end-program-signal ())
(struct change-line-signal (line))

(define-macro (b-line NUM STATEMENT ...)
  (with-pattern ([LINE-NUM (prefix-id "line-" #'NUM
                                      #:source #'NUM)])
  (syntax/loc caller-stx (define (LINE-NUM) (void) STATEMENT ...))))

(define-macro (b-module-begin (b-program LINE ... ))
  (with-pattern
      ([((b-line NUM STATEMENT ...) ...) #'(LINE ...)]
       [(LINE-FUNC ...) (prefix-id "line-" #'(NUM ...))])
    #'(#%module-begin
       LINE ...
       (define line-table
         (apply hasheqv (append (list NUM LINE-FUNC) ...)))
       (void (run line-table)))))
(provide (rename-out [b-module-begin #%module-begin]))

(define (run line-table)
  (define line-vec
    (list->vector (sort (hash-keys line-table) <)))
  (with-handlers ([end-program-signal? (lambda (ex) (void))])
    (for/fold ([line-idx 0])
              ([i (in-naturals)]
              #:break (>= line-idx (vector-length line-vec)))
      (define line-num (vector-ref line-vec line-idx))
      (define line-func (hash-ref line-table line-num))
      (with-handlers
          ([change-line-signal?
            (lambda (ex)
              (define target (change-line-signal-line ex))
              (or
               (and (exact-positive-integer? target)
                    (vector-member target line-vec))
               (error
                (format "error in line ~a: line ~a not found" line-num target))))])
      (line-func)
      (add1 line-idx)))))

(define (b-comment text) (void))
(define (b-print . vals) (displayln (string-append* (map ~a vals))))
(define (b-sum . nums) (apply + nums))
(define (b-expression exp) (if (integer? exp) (inexact->exact exp) exp))
(define (b-end) (raise (end-program-signal)))
(define (b-goto expr) (raise (change-line-signal expr)))

(provide (matching-identifiers-out #rx"^b-" (all-defined-out)))