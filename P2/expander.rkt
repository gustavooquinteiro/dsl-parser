#lang br/quicklang

(define-macro (mips-module-begin PARSE-TREE)
  #'(#%module-begin PARSE-TREE))

(provide (rename-out 
            [mips-module-begin #%module-begin]))


(define-macro (mips-program OPERATION-OR-LOOP-ARGS ...)
  #'(void OPERATION-OR-LOOP-ARGS ...))

(provide mips-program)

(define-macro (mips-loop "begin" OPERATION-OR-LOOP-ARGS ... "end")
  #'(until (zero? (current-byte))
      OPERATION-OR-LOOP-ARGS ...))

(provide mips-loop)

(define-macro-cases mips-instruction
  [(mips-instruction "add" "br" INTEGER) #'(increment "br" INTEGER)]
  [(mips-instruction "add" "cr" INTEGER) #'(increment "cr" INTEGER)]
  [(mips-instruction "add" "dr" INTEGER) #'(increment "dr" INTEGER)]
  [(mips-instruction "sub" "br" INTEGER) #'(decrement "br" INTEGER)]
  [(mips-instruction "sub" "cr" INTEGER) #'(decrement "cr" INTEGER)]
  [(mips-instruction "sub" "dr" INTEGER) #'(decrement "dr" INTEGER)]
  [(mips-instruction "fwd" INTEGER) #'(foward-n INTEGER)]
  [(mips-instruction "rwd" INTEGER) #'(rewind-n INTEGER)]
  [(mips-instruction WRITE) #'(write)])

(provide mips-instruction)

(define memory (make-vector 65536 0))
(define pc 0)
(define stk 0)
(define frp 0)
(define acc 0)
(define br 0)
(define cr 0)
(define dr 0)

(define (increment register integer)
  (cond
    [(eq? register "br") (set! br (+ br integer))]
    [(eq? register "cr") (set! cr (+ cr integer))]
    [else (set! dr (+ dr integer))]))

(define (decrement register integer)
  (cond
    [(eq? register "br") (set! br (- br integer))]
    [(eq? register "cr") (set! cr (- cr integer))]
    [else (set! dr (- dr integer))]))

(define (write)
  (write-byte br))
 

