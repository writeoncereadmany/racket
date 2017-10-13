#lang br/quicklang

(define-macro (bf-module-begin PARSE-TREE)
  #'(#%module-begin PARSE-TREE)
)

(provide (rename-out [bf-module-begin #%module-begin]))

(define (fold-funcs state bf-funcs)
  (for/fold ([current-state state])
            ([bf-func (in-list bf-funcs)])
    (apply bf-func current-state)
  )
)

(define-macro (bf-program OP-OR-LOOP-ARG ...)
  #'(begin
      (define initial-state (list (make-vector 30000 0) 0))
      (void (fold-funcs initial-state (list OP-OR-LOOP-ARG ...)))
  )
)
(provide bf-program)

(define-macro (bf-loop "[" OP-OR-LOOP-ARG ... "]")
  #'(lambda (arr ptr)
      (for/fold ([current-state (list arr ptr)])
                ([i (in-naturals)] #:break (zero? (apply current-byte current-state)))
        (fold-funcs current-state (list OP-OR-LOOP-ARG ...))
      )
  )
)
(provide bf-loop)

(define-macro-cases bf-op
  [(bf-op ">") #'advance]
  [(bf-op "<") #'retreat]
  [(bf-op "-") #'decrement]
  [(bf-op "+") #'increment]
  [(bf-op ".") #'output]
  [(bf-op ",") #'input]
)
(provide bf-op)

(define (current-byte arr ptr)
  (vector-ref arr ptr)
)

(define (set-current-byte arr ptr val)
  (define new-arr (vector-copy arr))
  (vector-set! new-arr ptr val)
  new-arr
)


(define (advance arr ptr) (list arr (add1 ptr)))
(define (retreat arr ptr) (list arr (sub1 ptr)))
(define (increment arr ptr)
  (define incremented (add1 (current-byte arr ptr)))
  (list (set-current-byte arr ptr incremented) ptr)
)
(define (decrement arr ptr)
  (define decremented (sub1 (current-byte arr ptr)))
  (list (set-current-byte arr ptr decremented) ptr)
)
(define (output arr ptr)
  (write-byte (current-byte arr ptr))
  (list arr ptr)
)
(define (input arr ptr)
  (list (set-current-byte arr ptr (read-byte)) ptr)
)