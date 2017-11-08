#lang scribble/manual
@(require (for-label json))

@title{jsonic: because JSON is boring}
@author{Tom Johnson}

@defmodulelang[jsonic]

@section{Introduction}

This is a domain specific language that relies on
the @racketmodname[json] library

@section{Detail}

This is some detail. Here's some code:
@verbatim|{
#lang jsonic
[
  @$ 'null $@
]
}|
