.data
num1: .word 15


.code
; Inicializamos un registro en 8 y le sumamos 10
DADDI r1, r0, 8
DADDI r2, r1, 10

LD r7, num1 (r0)
HALT