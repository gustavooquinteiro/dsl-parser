#lang brag

rbf-program: (rbf-op | rbf-loop)*
rbf-op: FWD [INTEGER] | RWD [INTEGER] | INC [INTEGER] | DEC [INTEGER] | WRITE | READ
rbf-loop: BEGIN (rbf-op | rbf-loop)* END
