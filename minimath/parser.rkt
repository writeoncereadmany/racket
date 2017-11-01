#lang brag
minimath-program : minimath-level1
@minimath-level1 : minimath-comparison | minimath-level2
minimath-comparison : minimath-level1 COMPARISON minimath-level1
@minimath-level2 : minimath-addition | minimath-level3
minimath-addition : minimath-level2 /"+" minimath-level2
@minimath-level3 : minimath-multiplication | minimath-atom
minimath-multiplication : minimath-level3 /"*" minimath-level3
@minimath-atom : minimath-literal | minimath-group
@minimath-literal : minimath-number | minimath-boolean
@minimath-number : INTEGER
minimath-boolean : BOOLEAN

@minimath-group: /"(" minimath-level1 /")"