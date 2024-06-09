#CopiarPares

.text:

la a0, s
la a1, q
lw a2, length
jal ra, copyPar

addi a7, zero, 10
ecall

copyPar:
addi t0, zero, 0    #Indice
addi t1, zero, 1    #Mascara 
j while

while:
blt a2, t0, return
lw t2, 0(a1)        #Cargo el valor de q[i]
and t3, t1, t2      #Me quedo con el bit menos significativo para saber si es par o no

beq t3, zero, esPar
sw zero, 0(a0)
addi a0, a0, 4
addi a1, a1, 4
addi t0, t0, 1
j while
esPar:
sw t2, 0(a0)
addi a0, a0, 4
addi a1, a1, 4
addi t0, t0, 1
j while

return:
ret

.data:

s: .word 0x00000001 0x00000001 0x00000001 0x00000001
q: .word 0x00000001 0x00000002 0x00000003 0x00000004
length: .word 4