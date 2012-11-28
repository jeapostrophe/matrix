#lang racket/base
(require racket/package
         tests/eli-tester
         data/spmatrix)

(define m (build-matrix 10 10 +))
(for* ([i (in-range 10)]
       [j (in-range 10)])
  (test (matrix-ref m i j)
        => (+ i j)))
