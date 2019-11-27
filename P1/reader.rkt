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
       ["fwd" (token 'FWD lexeme)]
       ["rwd" (token 'RWD lexeme)]
       ["inc" (token 'INC lexeme)]
       ["dec" (token 'DEC lexeme)]
       ["begin" (token 'BEGIN lexeme)]
       ["end" (token 'END lexeme)]
       ["write" (token 'WRITE lexeme)]
       ["read" (token 'READ lexeme)]
       [digits (token 'INTEGER (string->number lexeme))]
       [any-char (next-token)]))
    (bf-lexer port))
  next-token) 
