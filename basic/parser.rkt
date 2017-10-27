#lang brag
program : [line] (/NEWLINE [line])*
line : line-num [statement] (/":" [statement])* [comment]
@line-num : INTEGER
@statement : end | goto | print
comment : REM
end : /"end"
goto : /"goto" expression
print : /"print" [printable] (/";" [printable])*
@printable : STRING | expression
expression : sum
sum : number (/"+" number)*
@number : INTEGER | DECIMAL