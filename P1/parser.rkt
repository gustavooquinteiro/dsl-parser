#lang brag

rbf-program: (rbf-op | rbf-loop)*
rbf-op: FWD [integer] | RWD [integer] | INC [integer] | DEC [integer] | WRITE | READ
rbf-loop: BEGIN (rbf-op | rbf-loop)* END
integer: digit+
digit: INTEGER
