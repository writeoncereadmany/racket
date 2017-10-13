#lang br/quicklang
(require json)

(define-macro (jsonic-mb PARSE-TREE)
  #'(#%module-begin
     (define result-string PARSE-TREE)
     (define validated-jsexpr (string->jsexpr result-string))
     (display result-string)))

(provide (rename-out [jsonic-mb #%module-begin]))

(define-macro (jsonic-program SEXP-OR-JSON-STRING ...)
  #'(string-trim (string-append SEXP-OR-JSON-STRING ...)))
(provide jsonic-program)

(define-macro (jsonic-char CHAR_TOK_VALUE)
  #'CHAR_TOK_VALUE)
(provide jsonic-char)

(define-macro (jsonic-sexp SEXP-STR)
  (with-pattern ([SEXP-DATUM (format-datum '~a #'SEXP-STR)])
    #'(jsexpr->string SEXP-DATUM)))
(provide jsonic-sexp)