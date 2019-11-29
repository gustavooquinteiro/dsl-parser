#lang brag

mips-program: (mips-loop | mips-instruction)*
mips-instruction: ADD (BR | CR | DR) INTEGER | SUB (BR | CR | DR) INTEGER | WRITE
mips-loop: MIPS-LOOP