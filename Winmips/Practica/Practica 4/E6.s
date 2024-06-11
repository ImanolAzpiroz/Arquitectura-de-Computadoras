; 6) Escribir un programa que lea tres números enteros A, B y C de la memoria de datos y determine cuántos de ellos son iguales
; entre sí (0, 2 o 3). El resultado debe quedar almacenado en la dirección de memoria D.

.data
A: .word 3
B: .word 2
C: .word 1
D: .word 0

.code
ld r1, A (r0)
ld r2, B (r0)
ld r3, C (r0)
dadd r4, r0, r0
; comparar A y B
bne r1, r2, si1
daddi r4, r4, 1

; Comparar B y C
si1: bne r2, r3, si2
daddi r4, r4, 1

; Comparar A y C
si2: bne r1, r3, si3
daddi r4, r4, 1

si3: sd r4, D (r0)


halt
