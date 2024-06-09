#MaximoArray
.text:
la a0, numbers
li a1, 6
jal ra, maxArr

mv a0, a0
li a7, 1
ecall

li a7, 10
ecall

maxArr:

li t0, 0 #Indice
li t1, 0 #Max
j while

while:
beq a1, t0, return
lw t2, 0(a0)
addi a0, a0, 4
addi t0, t0, 1

blt t1, t2, max
j while
max:
mv t1, t2
j while

return:
mv a0, t1
jr ra

.data:
numbers: .word 1 11 2 5 1 3
length: .word 6