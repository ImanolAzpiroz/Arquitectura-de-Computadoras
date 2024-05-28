; Poner el valor 4 en r2
; el valor 5 en r4
; Sumar los valores y guardarlos en r3

.code
daddi r2, r0, 4
daddi r4, r0, 5
dadd r3, r2, r4
halt