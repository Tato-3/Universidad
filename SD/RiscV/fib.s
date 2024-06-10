.text:
    
li a0, 7
jal ra, fibonacci

mv a0, a0
li a7, 1
ecall

li a7, 10
ecall

fibonacci:
li t2, 2

addi sp, sp, -8
sw a0, 0(sp)
sw ra, 4(sp)

bge a0, t2, recursivo

li a0, 1
j fin

recursivo:
addi a0, a0, -1
jal fibonacci

lw t1, 0(sp)
sw a0, 0(sp)
addi a0, t1, -2
jal fibonacci

lw t0, 0(sp)
add a0, t0, a0


fin:
lw ra, 4(sp)
addi sp, sp, 8
ret
