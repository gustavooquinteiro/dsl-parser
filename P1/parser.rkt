#lang brag

rbf-program: (rbf-op | rbf-loop)*
rbf-op: rbf-op-n | WRITE | READ
rbf-op-n: FWD [integer] | RWD [integer] | INC [integer] | DEC [integer]
rbf-loop: BEGIN (rbf-op | rbf-loop)* END
integer: digit+
digit: INTEGER