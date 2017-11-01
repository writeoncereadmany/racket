#lang br/quicklang

(define-macro (mm-module-begin EXPR)
  #'(#%module-begin EXPR))
(provide (rename-out [mm-module-begin #%module-begin]))

(define (minimath-boolean bool)
  (case bool
    (["true" #t]
     ["false" #f])))
(define (minimath-program ex) ex)
(define minimath-addition +)
(define minimath-multiplication *)
(define-macro-cases minimath-comparison
  [(minimath-comparison A "<" B) #'(< A B)]
  [(minimath-comparison A ">" B) #'(> A B)]
  [(minimath-comparison A "<=" B) #'(<= A B)]
  [(minimath-comparison A ">=" B) #'(>= A B)]
  [(minimath-comparison A "=" B) #'(eqv? A B)]
  [(minimath-comparison A "!=" B) #'(not (eqv? A B))])

(provide (matching-identifiers-out #rx"^minimath-" (all-defined-out)))