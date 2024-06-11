.data   
control: .word 0x10000
data: .word 0x10008


.code
ld $s0, control ($zero)   ; $s0 = control
ld $s1, data ($zero)      ; $s1 = data

daddi $t0, $zero, -85     ; $t0 = - 85
sd $t0, 0 ($s1)          ; Mando el dato a data

daddi $t0, $zero, 2
sd $t0, 0 ($s0)           ; control = 2

daddi $t0, $zero, 6
sd $t0, 0 ($s0)           ; control = 6  (Limpia)

halt