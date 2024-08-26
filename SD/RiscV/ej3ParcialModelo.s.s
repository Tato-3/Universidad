.text:
lw a0, n
jal honi

li a7, 1
ecall

li a7, 10
ecall

honi:
addi sp, sp, -4
sw ra 0(sp)
li t1, 1

blt t1, a0, recursivo
li a0, 1
j fin

recursivo:
addi a0, a0, -1
jal honi
slli a0, a0,  1
addi a0, a0, 1
j fin

fin:
lw ra, 0(sp)
addi sp, sp, 4
ret

.data:
n: .byte 3

