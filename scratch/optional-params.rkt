#lang racket
(define (sum . xs) (apply + xs))

(define (average x . xs)
  (define total (+ x (apply + xs)))
  (define count (+ 1 (length xs)))
  (/ total count))

(define lammy (lambda args (apply + args)))

(define (greet #:first [first "Tom"] #:last [last "Jones"]) (format "Hello ~a ~a" first last))