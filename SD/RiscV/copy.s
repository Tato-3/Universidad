#Copy
la a0, s
la a1, q
addi a2, zero, 4
jal ra, copiar

mv a1, a1
li a7, 1
ecall

li a7, 10
ecall

copiar:
addi t0, t0, 0
j while

while:
blt a2, t0, return
lw t1, 0(a0)
sw t1, 0(a1)
addi a0, a0, 4
addi a1, a1, 4
addi t0, t0, 1
j while

return:
ret

.data:

s: .word 0x00000001 0x00000002 0x00000003 0x00000004
q: .word 0x00000005 0x00000006 0x00000007 0x00000008
