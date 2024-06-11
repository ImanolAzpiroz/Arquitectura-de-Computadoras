; Definir A y B con 4 y  5
; Definir C sin valor
; Cargar en registros
; guardar en C
;utilizar un desplazamiento desde A para cargar en B


.data
A: .word 4
B: .word 5
C: .word 0

.code
daddi r5, r0, 0   ; mov r5, 0
ld r1, A(r5)      ; mov r1, A ; 00 + 00 = 00

daddi r5, r0, 8   ; mov r2, 8
ld r2, A (r5)     ; Cargar B desde A 

dadd r3, r1, r2

daddi
sd r3, A (10h)
halt