.text:
lw a0, n
jal ra, sumaN

mv a0, a0
li a7, 1
ecall

li a7, 10
ecall

sumaN:
addi sp, sp, -8
sw ra, 4(sp)
sw a0, 0(sp)

bgt a0, zero, while
j return


while:
addi a0, a0, -1
jal ra, sumaN
lw t0, 0(sp)
add a0, a0, t0


return:
lw ra, 4(sp)
addi sp, sp, 8
ret

.data:
n: .word 10