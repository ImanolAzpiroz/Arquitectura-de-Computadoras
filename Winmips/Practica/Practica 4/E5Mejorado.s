.data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0


.code
dadd r1, r0, r0                 ; r1 = 0
ld r2, cant(r0)                 ; r2 = 8
loop: ld r3, datos(r1)          ; r3 = 1      datos[0]= 1
daddi r2, r2, -1                ; dism r2 
dsll r3, r3, 1                  ; corrimiento de bits (1 = 2, 2 = 4, 3 = 6)
sd r3, res(r1)                  ; almacena el resultado
bnez r2, loop                   ; r2 es la cantidad de elementos (8) si no es cero loopea
daddi r1, r1, 8                 ; aumenta el indice
halt


; A) Activar delay slot, la instruccion siguiente al salto se ejecuta siempre