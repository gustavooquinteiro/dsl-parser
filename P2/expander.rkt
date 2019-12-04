#lang br/quicklang

(define-macro (mips-module-begin PARSE-TREE)
  #'(#%module-begin PARSE-TREE))

(provide (rename-out 
            [mips-module-begin #%module-begin]))


(define-macro (mips-program OPERATION-ARGS ...)
  #'(void OPERATION-ARGS ...))

(provide mips-program)

(define memory (make-vector 65536 0))
(define pc 0)
(define stk 0)
(define frp 0)
(define acc 0)
(define br 0)
(define cr 0)
(define dr 0)


(define-macro-cases mips-branch
  [(mips-branch "beq" OPERATION-OR-LOOP-ARGS ... "end")] #'(if (zero? br) OPERATION-OR-LOOP-ARGS ...)
  [(mips-branch "bne" OPERATION-OR-LOOP-ARGS ... "end")] #'(if (not (zero? br)) OPERATION-OR-LOOP-ARGS ...)
  [(mips-branch "j" OPERATION-OR-LOOP-ARGS ... "end")] #'(until (zero? br) OPERATION-OR-LOOP-ARGS ...))

(provide mips-branch)

(define-macro-cases mips-instruction
  [(mips-instruction "addi" "br" "br" INTEGER) #'(increment-immediate br br INTEGER)]
  [(mips-instruction "addi" "br" "cr" INTEGER) #'(increment-immediate br cr INTEGER)]
  [(mips-instruction "addi" "br" "dr" INTEGER) #'(increment-immediate br dr INTEGER)]
  [(mips-instruction "addi" "cr" "cr" INTEGER) #'(increment-immediate cr cr INTEGER)]
  [(mips-instruction "addi" "cr" "br" INTEGER) #'(increment-immediate cr br INTEGER)]
  [(mips-instruction "addi" "cr" "dr" INTEGER) #'(increment-immediate cr dr INTEGER)]
  [(mips-instruction "addi" "dr" "br" INTEGER) #'(increment-immediate dr br INTEGER)]
  [(mips-instruction "addi" "dr" "cr" INTEGER) #'(increment-immediate dr cr INTEGER)]
  [(mips-instruction "addi" "dr" "dr" INTEGER) #'(increment-immediate dr dr INTEGER)]

  [(mips-instruction "subi" "br" "br" INTEGER) #'(decrement-immediate br br INTEGER)]
  [(mips-instruction "subi" "br" "cr" INTEGER) #'(decrement-immediate br cr INTEGER)]
  [(mips-instruction "subi" "br" "dr" INTEGER) #'(decrement-immediate br dr INTEGER)]
  [(mips-instruction "subi" "cr" "cr" INTEGER) #'(decrement-immediate cr cr INTEGER)]
  [(mips-instruction "subi" "cr" "br" INTEGER) #'(decrement-immediate cr br INTEGER)]
  [(mips-instruction "subi" "cr" "dr" INTEGER) #'(decrement-immediate cr dr INTEGER)]
  [(mips-instruction "subi" "dr" "br" INTEGER) #'(decrement-immediate dr br INTEGER)]
  [(mips-instruction "subi" "dr" "cr" INTEGER) #'(decrement-immediate dr cr INTEGER)]
  [(mips-instruction "subi" "dr" "dr" INTEGER) #'(decrement-immediate dr dr INTEGER)]

  [(mips-instruction "add" "br" "cr" "dr") #'(increment br cr dr)]
  [(mips-instruction "add" "br" "dr" "cr") #'(increment br dr cr)]
  [(mips-instruction "add" "cr" "br" "dr") #'(increment cr br dr)]
  [(mips-instruction "add" "cr" "dr" "br") #'(increment cr dr br)]
  [(mips-instruction "add" "dr" "cr" "br") #'(increment dr cr br)]
  [(mips-instruction "add" "dr" "br" "cr") #'(increment dr br cr)]

  [(mips-instruction "sub" "br" "cr" "dr") #'(decrement br cr dr)]
  [(mips-instruction "sub" "br" "dr" "cr") #'(decrement br dr cr)]
  [(mips-instruction "sub" "cr" "br" "dr") #'(decrement cr br dr)]
  [(mips-instruction "sub" "cr" "dr" "br") #'(decrement cr dr br)]
  [(mips-instruction "sub" "dr" "cr" "br") #'(decrement dr cr br)]
  [(mips-instruction "sub" "dr" "br" "cr") #'(decrement dr br cr)]
  
  [(mips-instruction "lw" "br" "br" INTEGER) #'(load-word br br INTEGER)]
  [(mips-instruction "lw" "br" "cr" INTEGER) #'(load-word br cr INTEGER)]
  [(mips-instruction "lw" "br" "dr" INTEGER) #'(load-word br dr INTEGER)]
  [(mips-instruction "lw" "cr" "cr" INTEGER) #'(load-word cr cr INTEGER)]
  [(mips-instruction "lw" "cr" "br" INTEGER) #'(load-word cr br INTEGER)]
  [(mips-instruction "lw" "cr" "dr" INTEGER) #'(load-word cr dr INTEGER)]
  [(mips-instruction "lw" "dr" "br" INTEGER) #'(load-word dr br INTEGER)]
  [(mips-instruction "lw" "dr" "cr" INTEGER) #'(load-word dr cr INTEGER)]
  [(mips-instruction "lw" "dr" "dr" INTEGER) #'(load-word dr dr INTEGER)]

  [(mips-instruction "sw" "br" "br" INTEGER) #'(store-word br br INTEGER)]
  [(mips-instruction "sw" "br" "cr" INTEGER) #'(store-word br cr INTEGER)]
  [(mips-instruction "sw" "br" "dr" INTEGER) #'(store-word br dr INTEGER)]
  [(mips-instruction "sw" "cr" "cr" INTEGER) #'(store-word cr cr INTEGER)]
  [(mips-instruction "sw" "cr" "br" INTEGER) #'(store-word cr br INTEGER)]
  [(mips-instruction "sw" "cr" "dr" INTEGER) #'(store-word cr dr INTEGER)]
  [(mips-instruction "sw" "dr" "br" INTEGER) #'(store-word dr br INTEGER)]
  [(mips-instruction "sw" "dr" "cr" INTEGER) #'(store-word dr cr INTEGER)]
  [(mips-instruction "sw" "dr" "dr" INTEGER) #'(store-word dr dr INTEGER)]
 
  [(mips-instruction "write" "br") #'(write br)]
  [(mips-instruction "write" "cr") #'(write cr)]
  [(mips-instruction "write" "dr") #'(write dr)])

(provide mips-instruction)

(define (next-pc [branch 0][jump #f])
  (if jump
      (set! pc branch)
      (set! pc (+ pc 4 branch))
  ))

(define (get-from-memory reg1 integer)
  (vector-ref memory (+ reg1 integer)))


(define (increment-immediate register1 register2 integer)
  (set! register2 (+ register1 integer))
  (next-pc))

(define (decrement-immediate register1 register2 integer)
  (set! register2 (- register1 integer))
  (next-pc))

(define (increment register1 register2 register3)
  (set! register2 (+ register1  register3))
  (next-pc))

(define (decrement register1 register2 register3)
  (set! register2 (- register1 register3))
  (next-pc))

(define (load-word register1 register2 integer)
  (set! register2 (get-from-memory register1 integer))
  (next-pc))

(define (store-word register1 register2 integer)
  (vector-set! memory (+ register1 integer) register2)
  (next-pc))

(define (jump integer)
  (next-pc integer #t))

(define (write reg)
  (write-byte reg)
  (next-pc))
 

