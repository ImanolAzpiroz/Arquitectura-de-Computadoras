.data
texto: .asciiz "Hola, mundo!" ; Mensaje  a mostrar
control: .word32 0x10000
data: .word32 0x10008

.text
lwu $s0, data ($zero)       ; $s0 Direccion de data
daddi  $t0, $zero, texto    ; direccion del mensaje a mostrar
sd $t0, 0 ($s0)             ; Data recibe el puntero del comienzo del msj

lwu $s1, control($zero)     ; $s1 = dirección de control
daddi $t0, $zero, 6         ; $t0 = 6 -> función 6: limpiar pantalla alfanumérica
sd $t0, 0($s1)              ; control recibe 6 y limpia la pantalla

daddi $t0, $zero, 4         ; $t0 = 4 -> función 4: salida de una cadena ASCII
sd $t0, 0($s1)              ; control recibe 4 y produce la salida del mensaje
halt