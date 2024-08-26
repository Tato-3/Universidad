dato: .word 0x37A2F011

lw s0, dato
li a0, 0
li t6, 0xFF
li t5, 1
li t0, 4

and t1, s0, t6
and t1, t1, t5

srli t2, s0, 8
and t2, t2, t6
and t2, t2, t5

srli t3, s0, 16
and t3, t3, t6
and t3, t3, t5

srli t4, s0, 24
and t4, t4, t6
and t4, t4, t5

add a0, t1, t2
add a1, t3, t4

add a0, a0, a1
sub a0, t0, a0

li a7, 1
ecall