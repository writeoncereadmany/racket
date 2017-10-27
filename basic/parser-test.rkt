#lang br
(require basic/parser basic/tokenizer brag/support)

(define small-program #<<PROGRAM
10 print "hello" : print "world"
20 goto 9 + 10 + 11
30 end
PROGRAM
)

(define sample-program #<<PROGRAM
30 rem print 'ignored'
35
50 print "never gets here"
40 end
60 print 'three' : print 1.0 + 3
70 goto 11. + 18.5 + .5 rem ignored
10 print "o" ; "n" ; "e"
20 print : goto 60.0 : end
PROGRAM
)

(parse-to-datum (apply-tokenizer make-tokenizer sample-program))