#lang scribble/doc
@(require (planet cce/scheme:4:1/planet)
          scribble/manual
          (for-label scheme/base
                     scheme/contract
                     "main.ss"))

@title{Semi-persistent Matrices}
@author{@(author+email "Jay McCarthy" "jay@plt-scheme.org")}

@defmodule/this-package[]

This package defines matrices using semi-persistent vectors from the @schememodname[(planet jaymccarthy/spvector)] package.

@defproc[(build-matrix [rows exact-positive-integer?]
                       [cols exact-positive-integer?]
                       [cell-f (exact-nonnegative-integer? exact-nonnegative-integer? . -> . any/c)])
         matrix?]{
 Constructs a matrix @scheme[_m] such that @scheme[(matrix-ref _m ri ci)] is @scheme[(cell-f ri ci)].
}
                 
@defproc[(matrix? [v any/c])
         boolean?]{
 Determines if @scheme[v] is a valid matrix.
}
                  
@defproc[(matrix-rows [m matrix?])
         exact-positive-integer?]{
 Returns how many rows @scheme[m] has.
}
                                 
@defproc[(matrix-cols [m matrix?])
         exact-positive-integer?]{
 Returns how many cols @scheme[m] has.
}

@defproc[(matrix-valid-ref? [m matrix?]
                            [ri exact-nonnegative-integer?]
                            [ci exact-nonnegative-integer?])
         boolean?]{
 Determines if @scheme[(matrix-ref m ri ci)] would error.
}
                  
@defproc[(matrix-ref [m matrix?]
                     [ri exact-nonnegative-integer?]
                     [ci exact-nonnegative-integer?])
         any/c]{
 Extracts the value of a cell in the matrix.
}
               
@defproc[(matrix-set [m matrix?]
                     [ri exact-nonnegative-integer?]
                     [ci exact-nonnegative-integer?]
                     [v any/c])
         matrix?]{
 Semi-persistently modifies @scheme[m].
}
                 
@defproc[(matrix-set! [m matrix?]
                      [ri exact-nonnegative-integer?]
                      [ci exact-nonnegative-integer?]
                      [v any/c])
         void]{
 Destructively modifies @scheme[m].
}

@defproc[(matrix-fold [m matrix?]
                      [row-f (exact-nonnegative-integer? any/c . -> . any/c)]
                      [cell-f (exact-nonnegative-integer? exact-nonnegative-integer? any/c any/c . -> . any/c)]
                      [acc any/c])
         any/c]{
 Like @scheme[foldr] but for matrices. @scheme[row-f] is called with the result of @scheme[cell-f] from the last column in the row.
 @scheme[cell-f] is called from left to right.
}
               
@defproc[(display-matrix [m matrix?])
         void]{
 @scheme[display]s the cells of @scheme[m] with @scheme[(newline)] separating rows.
}