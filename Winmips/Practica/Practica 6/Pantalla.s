.data
pixel: .byte 255, 0, 135, 0, 49, 49, 0, 0
control: .word 0x10000
data: .word 0x10008

.code
ld $s0, control ($zero)
ld $s1, data ($zero)

ld $t0, pixel ($zero)
sd $t0, 0 ($s1)

daddi $t0, $zero, 5
sd $t0, 0 ($s0)

halt