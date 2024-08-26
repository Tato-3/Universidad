.text:
la a0, s
la a1, q
lw a2, largo

li t0, 0
li t1, 1

while:
bge t0, a2, print
lw t2, 0(a1)
and t3, t2, t1

beq t3, zero, par
sw zero, 0(a0)
addi t0, t0, 1
addi a0, a0, 4
addi a1, a1, 4
j while

par:
sw t2, 0(a0)
addi t0, t0, 1
addi a0, a0, 4
addi a1, a1, 4
j while

print:
li a7, 1
ecall

li a7, 10
ecall

.data:
s: .word 0x1 0x2 0x3 0x4
q: .word 0x5 0x6 0x7 0x8
largo: .byte 4