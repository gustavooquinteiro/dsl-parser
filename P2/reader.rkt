#lang br/quicklang

(require "parser.rkt")

(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port)))
  (define module-datum `(module bf-mod "expander.rkt"
                          ,parse-tree))
  (datum->syntax #f module-datum))
(provide read-syntax)

(require brag/support)

(define-lex-abbrev digits (:+ (char-set "0123456789")))

(define (make-tokenizer port)
  (define (next-token)
    (define bf-lexer
      (lexer
       ["add" (token 'ADD lexeme)]
       ["addi" (token 'ADDI lexeme)]
       ["sub" (token 'SUB lexeme)]
       ["subi" (token 'SUBI lexeme)]
       ["br" (token 'BR lexeme)]
       ["cr" (token 'CR lexeme)]
       ["dr" (token 'DR lexeme)]
       ["beq" (token 'BEQ lexeme)]
       ["bne" (token 'BNE lexeme)]
       ["end" (token 'END lexeme)]
       ["j" (token 'J lexeme)]
       ["lw" (token 'LW lexeme)]
       ["sw" (token 'SW lexeme)]
       ["write" (token 'WRITE lexeme)]
       [digits (token 'INTEGER (string->number lexeme))]
       [any-char (next-token)]))
    (bf-lexer port))
  next-token)  
