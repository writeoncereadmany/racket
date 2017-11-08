#lang racket

(define (check-types parse-tree)
  (if (eq? 'TypeError (determine-program-type (syntax->datum parse-tree)))
      (raise "Type error in program")
      (void)))
(provide check-types)

(define (determine-program-type prog)
  (match prog
    [`(minimath-program ,expr) (determine-type expr)]))

(define (determine-type expr)
  (match expr
    [`(minimath-boolean ,_) 'Boolean]
    [(? number?) 'Number]
    [`(minimath-comparison ,a ,(or "=" "!=") ,b)
     #:when (equal? (determine-type a) (determine-type b))
     'Boolean]
    [`(minimath-comparison ,a ,(or "<" "<=" ">" ">=") ,b)
     #:when (and (eq? 'Number (determine-type a))
                 (eq? 'Number (determine-type b)))
     'Boolean]
    [`(minimath-addition ,a ,b)
     #:when (and (eq? 'Number (determine-type a))
                 (eq? 'Number (determine-type b)))
     'Number]
    [`(minimath-multiplication ,a ,b)
     #:when (and (eq? 'Number (determine-type a))
                 (eq? 'Number (determine-type b)))
     'Number]
    [_ 'TypeError]))