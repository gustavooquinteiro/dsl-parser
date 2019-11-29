#lang br/quicklang

(define-macro (rbf-module-begin PARSE-TREE)
  #'(#%module-begin PARSE-TREE))

(provide (rename-out 
            [rbf-module-begin #%module-begin]))


(define-macro (rbf-program OPERATION-OR-LOOP-ARGS ...)
  #'(void OPERATION-OR-LOOP-ARGS ...))

(provide rbf-program)

(define-macro (rbf-loop "begin" OPERATION-OR-LOOP-ARGS ... "end")
  #'(until (zero? (current-byte))
      OPERATION-OR-LOOP-ARGS ...))

(provide rbf-loop)

(define-macro-cases rbf-op
  [(rbf-op "inc" INTEGER) #'(increment-n INTEGER)]
  [(rbf-op "dec" INTEGER) #'(decrement-n INTEGER)]
  [(rbf-op "fwd" INTEGER) #'(foward-n INTEGER)]
  [(rbf-op "rwd" INTEGER) #'(rewind-n INTEGER)]
  [(rbf-op "inc") #'(increment-n)]
  [(rbf-op "dec") #'(decrement-n)]
  [(rbf-op "fwd") #'(foward-n)]
  [(rbf-op "rwd") #'(rewind-n)]
  [(rbf-op WRITE) #'(write)]
  [(rbf-op READ) #'(read)])

(provide rbf-op)

(define tape (make-vector 3000 0))
(define ptr 0)

(define (current-byte)
  (vector-ref tape ptr))

(define (increment-n [integer 1])
  (set-current-byte! (+ (current-byte) integer)))

(define (decrement-n [integer 1])
  (set-current-byte! (- (current-byte) integer)))

(define (foward-n [integer 1])
  (set! ptr (+ integer ptr)))

(define (rewind-n [integer 1])
  (set! ptr (- ptr integer)))

(define (set-current-byte! val)
  (vector-set! tape ptr val))

(define (write)
  (write-byte (current-byte)))

(define (read)
  (set-current-byte! (read-byte)))
  

