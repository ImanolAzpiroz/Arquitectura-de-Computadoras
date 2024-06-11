.data
tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
num: .word 7
long: .word 10


.code
ld r1, long(r0)                 ; r1 = 9  (cant elementos)
ld r2, num(r0)                  ; r2 = 7  (nro a buscar)
dadd r3, r0, r0                 ; r3 = 8   (indice)
dadd r10, r0, r0                ; r10 = 0  
loop: ld r4, tabla(r3)          ; r4 = 20     (Tabla[r3])
beq r4, r2, listo
daddi r1, r1, -1
daddi r3, r3, 8
bnez r1, loop
j fin
listo: daddi r10, r0, 1
fin: halt


; A) Recorre un vector en busca de un numero, si lo encuentra devuelve 1 en r1, en caso contrario 0
; B) Los Atascos