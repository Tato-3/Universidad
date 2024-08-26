.data:
n: .word 0x5

.text:
lw a0, n
jal ra, fact

mv a0, a0
li a7, 1
ecall

li a7, 10
ecall

fact:
addi sp, sp, -8
sw a0, 0(sp)
sw ra, 4(sp)
li t1, 1

bne a0, t1, recursivo
li a0, 1
j fin

recursivo:
addi, a0, a0, -1
jal fact
lw t0, 0(sp)
mul a0, a0, t0

fin:
lw ra, 4(sp)
addi sp, sp, 8
ret
