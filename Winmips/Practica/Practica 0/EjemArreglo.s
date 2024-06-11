.data
Arreglo: .word 1, 3, 6, 4

.code
daddi r1, r0, 6
daddi r2, r0, 32
sd r1, Arreglo (r2)
halt