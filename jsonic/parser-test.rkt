#lang br
(require jsonic/parser jsonic/tokenizer brag/support rackunit)

(define (do-parse program)
  (parse-to-datum
    (apply-tokenizer-maker make-tokenizer program)))

(check-equal? (do-parse "// line comment \n") '(jsonic-program))
(check-equal? (do-parse "@$ (+ 6 7) $@") '(jsonic-program (jsonic-sexp " (+ 6 7) ")))
(check-equal?
  (do-parse "hey")
  '(jsonic-program
    (jsonic-char "h")
    (jsonic-char "e")
    (jsonic-char "y")))