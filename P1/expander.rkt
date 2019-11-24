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
  [(rbf-op-n INC [integer]) #'(increment-n integer)]
  [(rbf-op-n DEC [integer]) #'(decrement-n integer)]
  [(rbf-op-n FWD [integer]) #'(foward-n integer)]
  [(rbf-op-n RWD [integer]) #'(rewind-n integer)]
  [(rbf-op WRITE) #'(write)]
  [(rbf-op READ) #'(read)])
(provide rbf-op)
(define tape (make-vector 3000 0))
(define ptr 0)

(define (current-byte)
  (vector-ref tape ptr))

(define (increment-n [integer 1])
  (set! ptr (+ integer ptr)))

(define (decrement-n [integer 1])
  (set! ptr (- ptr integer)))

(define (foward-n [integer 1])
  (set-current-byte! (+ integer (current-byte))))

(define (rewind-n [integer 1])
  (set-current-byte! (- integer (current-byte))))

(define (set-current-byte! val)
  (vector-set! tape ptr val))

(define (write)
  (write-byte (current-byte)))

(define (read)
  (set-current-byte! (read-byte)))
  

