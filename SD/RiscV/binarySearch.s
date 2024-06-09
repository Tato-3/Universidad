#Binary Search

.text:
    
la a0, array
lw a1, target
lw a2, n

jal ra, binarySearch

mv a0, a0
li a7, 1
ecall

addi a7, zero, 10
ecall

binarySearch:
addi t0, zero, 0    #Low
add t1, zero, a2    #High
addi t1, t1, -1
addi t2, zero, 0    #Mid
li t3, 4
j while

while:
ble t0, t1, continue
ret

continue:
add t2, t0, t1
srli t2, t2, 1


mul t4, t2, t3
add a0, a0, t4
lw t5, 0(a0)
sub a0, a0, t4

beq t5, a1, return
blt t5, a1, caso1
bgt t5, a1, caso2
ret

caso1:
addi t0, t2, 1
j while

caso2:
addi t1, t2, -1
j while

return:
mv a0, t2
ret



.data:
array: .word 1, 3, 5, 7, 9, 11, 13, 15, 17, 19
target: .word 17
n: .word 10