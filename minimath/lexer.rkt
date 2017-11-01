#lang racket
(require brag/support)

(define-lex-abbrev digits (:+ (char-set "0123456789")))

(define minimath-lexer
  (lexer-srcloc
   [(eof) (return-without-srcloc eof)]
   [whitespace (token lexeme #:skip? #t)]
   [digits (token 'INTEGER (string->number lexeme))]
   [(:or "true" "false") (token 'BOOLEAN lexeme)]
   [(:or "=" "<=" ">=" "<" ">" "!=") (token 'COMPARISON lexeme)]
   [(:or "(" ")" "+" "*") (token lexeme lexeme)]))

(provide minimath-lexer)