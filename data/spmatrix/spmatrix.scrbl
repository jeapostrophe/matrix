#lang scribble/doc
@(require scribble/manual
          (for-label racket/base
                     racket/contract
                     data/spmatrix
                     data/spvector))

@title{Semi-persistent Matrices}
@author{@(author+email "Jay McCarthy" "jay@racket-lang.org")}

@defmodule[data/spmatrix]

This package defines matrices using semi-persistent vectors from @racketmodname[data/spvector]

@defproc[(build-matrix [rows exact-positive-integer?]
                       [cols exact-positive-integer?]
                       [cell-f (exact-nonnegative-integer? exact-nonnegative-integer? . -> . any/c)])
         matrix?]{
 Constructs a matrix @racket[_m] such that @racket[(matrix-ref _m ri ci)] is @racket[(cell-f ri ci)].
}
                 
@defproc[(matrix? [v any/c])
         boolean?]{
 Determines if @racket[v] is a valid matrix.
}
                  
@defproc[(matrix-rows [m matrix?])
         exact-positive-integer?]{
 Returns how many rows @racket[m] has.
}
                                 
@defproc[(matrix-cols [m matrix?])
         exact-positive-integer?]{
 Returns how many cols @racket[m] has.
}

@defproc[(matrix-valid-ref? [m matrix?]
                            [ri exact-nonnegative-integer?]
                            [ci exact-nonnegative-integer?])
         boolean?]{
 Determines if @racket[(matrix-ref m ri ci)] would error.
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
 Semi-persistently modifies @racket[m].
}
                 
@defproc[(matrix-set! [m matrix?]
                      [ri exact-nonnegative-integer?]
                      [ci exact-nonnegative-integer?]
                      [v any/c])
         void]{
 Destructively modifies @racket[m].
}

@defproc[(matrix-fold [m matrix?]
                      [row-f (exact-nonnegative-integer? any/c . -> . any/c)]
                      [cell-f (exact-nonnegative-integer? exact-nonnegative-integer? any/c any/c . -> . any/c)]
                      [acc any/c])
         any/c]{
 Like @racket[foldr] but for matrices. @racket[row-f] is called with the result of @racket[cell-f] from the last column in the row.
 @racket[cell-f] is called from left to right.
}
               
@defproc[(display-matrix [m matrix?])
         void]{
 @racket[display]s the cells of @racket[m] with @racket[(newline)] separating rows.
}
