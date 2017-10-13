#lang br/quicklang

(define (read-syntax path port)
  (define src-lines (port->lines port))
  (define handle-datums (format-datums '~a src-lines))
  (define module-datum `(module stacker-mod "funstacker.rkt" (handle-args ,@handle-datums)))
  (datum->syntax #f module-datum))

(define-macro (funstacker-module-begin HANDLE-ARGS-EXPR)
  #'(#%module-begin
     (display (first HANDLE-ARGS-EXPR))))

(define (handle-args . args)
  (for/fold ([stack-acc empty])
            ([arg (filter-not void? args)])
    (cond
      [(number? arg) (cons arg stack-acc)]
      [(or (equal? + arg) (equal? * arg))
       (define op-result (arg (first stack-acc) (second stack-acc)))
       (cons op-result (drop stack-acc 2))
      ])))

(provide
   read-syntax
   (rename-out [funstacker-module-begin #%module-begin])
   handle-args
   +
   *
)