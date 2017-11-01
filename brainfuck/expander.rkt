#lang br/quicklang

(define-macro (bf-module-begin PARSE-TREE)
  #'(#%module-begin PARSE-TREE)
)

(provide (rename-out [bf-module-begin #%module-begin]))

(define-macro (bf-program OP-OR-LOOP-ARG ...)
  #'(void OP-OR-LOOP-ARG ...)
)

(provide bf-program)

(define-macro (bf-loop "[" OP-OR-LOOP-ARG ... "]")
  #'(until (zero? (current-byte))
      OP-OR-LOOP-ARG ...
  )
)

(provide bf-loop)

(define-macro-cases bf-op
  [(bf-op ">") #'(advance) ]
  [(bf-op "<") #'(retreat) ]
  [(bf-op "+") #'(increment) ]
  [(bf-op "-") #'(decrement) ]
  [(bf-op ".") #'(output) ]
  [(bf-op ",") #'(input) ]
)
(provide bf-op)

(define arr (make-vector 30000 0))
(define ptr 0)

(define (current-byte) (vector-ref arr ptr))
(define (set-current-byte! val) (vector-set! arr ptr val))

(define (advance) (set! ptr (add1 ptr)))
(define (retreat) (set! ptr (sub1 ptr)))
(define (increment) (set-current-byte! (add1 (current-byte))))
(define (decrement) (set-current-byte! (sub1 (current-byte))))
(define (output) (write-byte (current-byte)))
(define (input) (set-current-byte! (read-byte)))
