#lang br/quicklang


(define-macro (stackerizer-mb EXPR)
  #'(#%module-begin
       (for-each displayln (reverse (flatten EXPR)))))

(define-macro (define-ops OP ...)
  #'(begin
      (define-macro-cases OP
        [(OP FIRST) #'FIRST]
        [(OP FIRST NEXT (... ...))
         #'(list 'OP FIRST (OP NEXT (... ...)))])
      ...))

(define-ops + *)

(provide
   (rename-out [stackerizer-mb #%module-begin])
   +
   *
)