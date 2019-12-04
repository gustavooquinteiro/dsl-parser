#lang brag

mips-program: (mips-branch | mips-instruction)*
mips-instruction: ADD (BR | CR | DR) (BR | CR | DR) (BR | CR | DR) | ADDI (BR | CR | DR) (BR | CR | DR) INTEGER |
                  SUB (BR | CR | DR) (BR | CR | DR) (BR | CR | DR) | SUBI (BR | CR | DR) (BR | CR | DR) INTEGER |
                  LW (BR | CR | DR) (BR | CR | DR) INTEGER | SW (BR | CR | DR) (BR | CR | DR) INTEGER |
                  WRITE (BR | CR | DR)
mips-branch: BEQ (mips-branch | mips-instruction)* END | BNE (mips-branch | mips-instruction)* END |
             J (mips-branch | mips-instruction)* END