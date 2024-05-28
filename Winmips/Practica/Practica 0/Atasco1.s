.data
B: .word 5


.code
DADDI R1, R0, 1
LD R2, B (R0)
LOOP: DSLL R1, R1, 1 ; Desplazo a la izq
    DADDI R2, R2, -1
    BNEZ R2, LOOP
HALT
