#lang scheme
(require (planet jaymccarthy/spvector))

(define-struct matrix (rows cols cells)
  #:transparent)

(define (build-matrix rs cs f)
  (make-matrix
   rs cs
   (build-spvector
    rs
    (lambda (r)
      (build-spvector
       cs
       (lambda (c)
         (f r c)))))))

(define (validate-ref f m r c)
  (cond
    [(r . >= . (matrix-rows m))
     (error f "no row ~a" r)]
    [(c . >= . (matrix-cols m))
     (error f "no column ~a" c)]))

(define (matrix-valid-ref? m r c)
  (with-handlers ([exn:fail? (lambda _ #f)])
    (validate-ref 'valid-ref? m r c)
    #t))

(define (matrix-ref m r c)
  (validate-ref 'matrix-ref m r c)
  (spvector-ref (spvector-ref (matrix-cells m) r) c))

(define (matrix-set m vr vc v)
  (validate-ref 'matrix-set m vr vc)
  (make-matrix (matrix-rows m)
               (matrix-cols m)
               (spvector-set (matrix-cells m) vr
                             (spvector-set (spvector-ref (matrix-cells m) vr) vc v))))

(define (matrix-set! m vr vc v)
  (validate-ref 'matrix-set! m vr vc)
  (spvector-set! (spvector-ref (matrix-cells m) vr) vc v))

(define (matrix-fold m row-f col-f a)
  (for/fold ([a a])
    ([r (matrix-cells m)]
     [ri (in-range 0 (matrix-rows m))])
    (row-f
     ri
     (for/fold ([a a])
       ([v r]
        [ci (in-range 0 (matrix-cols m))])
       (col-f ri ci v a)))))

(define (display-matrix m)
  (for ([ri (in-range 0 (matrix-rows m))])
    (for ([ci (in-range 0 (matrix-cols m))])
      (display (matrix-ref m ri ci)))
    (unless (= ri (sub1 (matrix-rows m)))
      (newline))))

(provide/contract
 [matrix-rows (matrix? . -> . exact-positive-integer?)]
 [matrix-cols (matrix? . -> . exact-positive-integer?)]
 [matrix? (any/c . -> . boolean?)]
 [build-matrix
  (exact-positive-integer?
   exact-positive-integer?
   (exact-nonnegative-integer? exact-nonnegative-integer? . -> . any/c)
   . -> .
   matrix?)]
 [matrix-valid-ref? (matrix? exact-nonnegative-integer? exact-nonnegative-integer? . -> . boolean?)]
 [matrix-ref (matrix? exact-nonnegative-integer? exact-nonnegative-integer? . -> . any/c)]
 [matrix-set (matrix? exact-nonnegative-integer? exact-nonnegative-integer? any/c . -> . matrix?)]
 [matrix-set! (matrix? exact-nonnegative-integer? exact-nonnegative-integer? any/c . -> . void)]
 [matrix-fold (matrix? 
               (exact-nonnegative-integer? any/c . -> . any/c)
               (exact-nonnegative-integer? exact-nonnegative-integer? any/c any/c . -> . any/c)
               any/c . -> . any/c)]
 [display-matrix (matrix? . -> . void)])