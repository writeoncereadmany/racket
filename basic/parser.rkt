#lang brag
b-program : [b-line] (/NEWLINE [b-line])*
b-line : b-line-num [b-statement] (/":" [b-statement])* [b-comment]
@b-line-num : INTEGER
@b-statement : b-end | b-goto | b-print
b-comment : REM
b-end : /"end"
b-goto : /"goto" b-expression
b-print : /"print" [b-printable] (/";" [b-printable])*
@b-printable : STRING | b-expression
b-expression : b-sum
b-sum : b-number (/"+" b-number)*
@b-number : INTEGER | DECIMAL