datos: .byte 0x05 0x04 0x02 0x03
mascara: .word 0xFF
lw t0, datos
lw t1, mascara
srli a3, t0, 24

slli a2, t0, 12
srli a2, a2, 28

add a0, a2, a3