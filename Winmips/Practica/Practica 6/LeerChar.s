.data   
control: .word 0x10000
data: .word 0x10008

.code
ld $s0, control ($zero)
ld $s1, data ($zero)

; Leer Char

daddi $t0, $zero, 9
sd $t0, 0 ($s0)

halt