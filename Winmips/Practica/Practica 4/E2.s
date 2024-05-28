
.data
A: .word 1
B: .word 2
.code
ld r1, A(r0)
ld r2, B(r0)
sd r2, A(r0)
sd r1, B(r0)
halt

; La instruccion sd r2, A(r0) esta generando un atasco por que necesita 
; el valor de r2 y este no estara disponible hasta qu la instruccion anterior
; no llegue a la etapa de WB

; El atasco que aparece es RAW (Read After Write), Quiere leer un dato
; sin que este haya sido guardado antes

; el promedio de ciclos de instrucciones es: 
; 11 Ciclos
; 5 Instrucciones
; 2.200 Ciclos por instruccion
