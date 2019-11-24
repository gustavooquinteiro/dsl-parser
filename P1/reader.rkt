#lang br/quicklang

(require "parser.rkt")

(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port)))
  (define module-datum `(module bf-mod "expander.rkt"
                          ,parse-tree))
  (datum->syntax #f module-datum))
(provide read-syntax)

(require brag/support)

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
       ["1" (token 'ONE lexeme)]
       ["2" (token 'TWO lexeme)]
       ["3" (token 'THREE lexeme)]
       ["4" (token 'FOUR lexeme)]
       ["5" (token 'FIVE lexeme)]
       ["6" (token 'SIX lexeme)]
       ["7" (token 'SEVEN lexeme)]
       ["8" (token 'EIGHT lexeme)]
       ["9" (token 'NINE lexeme)]
       ["0" (token 'ZERO lexeme)]
       [any-char (next-token)]))
    (bf-lexer port))
  next-token) 
