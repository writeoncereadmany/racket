#lang br/quicklang

(require "parser.rkt" "tokenizer.rkt" "typechecker.rkt")

(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port path)))
  (check-types parse-tree)
  (strip-bindings
   #`(module minimath-mod minimath/expander #,parse-tree)))

(module+ reader (provide read-syntax))
