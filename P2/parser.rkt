#lang brag

mips-program: (mips-instruction)*
mips-instruction: ADD (BR | CR | DR) (BR | CR | DR) (BR | CR | DR) | ADDI (BR | CR | DR) (BR | CR | DR) INTEGER |
                  SUB (BR | CR | DR) (BR | CR | DR) (BR | CR | DR) | SUBI (BR | CR | DR) (BR | CR | DR) INTEGER |
                  J INTEGER | BEQ (BR | CR | DR) (BR | CR | DR) INTEGER | BNE (BR | CR | DR) (BR | CR | DR) INTEGER |
                  LW (BR | CR | DR) (BR | CR | DR) INTEGER | SW (BR | CR | DR) (BR | CR | DR) INTEGER | WRITE (BR | CR | DR)