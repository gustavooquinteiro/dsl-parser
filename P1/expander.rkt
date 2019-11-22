#lang br/quicklang

(define-macro (rbf-module-begin PARSE-TREE)
  #'(#%module-begin PARSE-TREE))

(provide (rename-out 
            [rbf-module-begin #%module-begin]))


(define-macro (rbf-program OPERATION-OR-LOOP-ARGS ...)
  #'(void OPERATION-OR-LOOP-ARGS ...))

(provide rbf-program)

(define-macro (rbf-loop "[" OPERATION-OR-LOOP-ARGS ... "]")
  #'(until (zero? (current-byte))
      OPERATION-OR-LOOP-ARGS ...))

(provide rbf-loop)

