#lang br/quicklang

(define-macro (mips-module-begin PARSE-TREE)
  #'(#%module-begin 'PARSE-TREE))

(provide (rename-out 
            [mips-module-begin #%module-begin]))


(define-macro (mips-program OPERATION-ARGS ...)
  #'(void OPERATION-ARGS ...))

(provide mips-program)

(define-macro-cases mips-instruction
  [(mips-instruction "addi" register1 register2 INTEGER) #'(increment-immediate register1 register2 INTEGER)]
  [(mips-instruction "subi" register1 register2 INTEGER) #'(decrement-immediate register1 register2 INTEGER)]
  [(mips-instruction "add" register1 register2 register3) #'(increment register1 register2 register3)]
  [(mips-instruction "sub" register1 register2 register3) #'(decrement register1 register2 register3)]
  [(mips-instruction "lw" register1 register2 INTEGER) #'(load-word register1 register2 INTEGER)]
  [(mips-instruction "sw" register1 register2 INTEGER) #'(store-word register1 register2 INTEGER)]
  [(mips-instruction "beq" register1 register2 INTEGER) #'(beq register1 register2 INTEGER)]
  [(mips-instruction "bne" register1 register2 INTEGER) #'(bne register1 register2 INTEGER)]
  [(mips-instruction "j" INTEGER) #'(jump INTEGER)]
  [(mips-instruction "write" reg) #'(write reg)])

(provide mips-instruction)

(define memory (make-vector 65536 0))
(define pc 0)
(define stk 0)
(define frp 0)
(define acc 0)
(define br 0)
(define cr 0)
(define dr 0)


(define (next-pc [branch 0][jump #f])
  (if (jump)
      (set! pc branch)
      (set! pc (+ pc 4 branch))
  ))

(define (check-register reg)
  (cond
   [(eq? reg "br") br]
   [(eq? reg "cr") cr]
   [else dr]))

(define (get-from-memory reg1 integer)
  (vector-ref memory (+ reg1 integer)))


(define (increment-immediate register1 register2 integer)
  (set! (check-register register2) (+ (check-register register1) integer))
  (next-pc))

(define (decrement-immediate register1 register2 integer)
  (set! (check-register register2) (- (check-register register1) integer))
  (next-pc))

(define (increment register1 register2 register3)
  (set! (check-register register2) (+ (check-register register1) (check-register register3)))
  (next-pc))

(define (decrement register1 register2 register3)
  (set! (check-register register2) (- (check-register register1) (check-register register3)))
  (next-pc))

(define (load-word register1 register2 integer)
  (set! (check-register register2) (get-from-memory (check-register register1) integer))
  (next-pc))

(define (store-word register1 register2 integer)
  (vector-set! memory (+ (check-register register1) integer) (check-register register2))
  (next-pc))

(define (beq reg1 reg2 integer)
  (if (eq? (check-register reg1) (check-register reg2))
      (next-pc integer)
      (next-pc)
   ))

(define (bne reg1 reg2 integer)
  (if (not (eq? (check-register reg1) (check-register reg2)))
      (next-pc integer)
      (next-pc)
   ))

(define (jump integer)
  (next-pc integer #t))

(define (write reg)
  (write-byte (check-register reg))
  (next-pc))
 

