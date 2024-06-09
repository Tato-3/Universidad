.multiplicacion:

lw a0, n1
lw a1, n2
li t0, 1
add t1, t1, a0
jal ra ,multiplicar

mv a0, a0
li a7, 1
ecall

li a7, 10
ecall

multiplicar:

#Caso 0
beq a0, zero, cero
beq a1, zero, cero


beq t0, a1, fin
add a0, a0, t1
addi t0, t0, 1

j multiplicar


cero:
li a0, 0
li a1, 0
ret

fin:
mv a0, a0
ret

.factorial:
    
li x9, 0



.data:    
n1: .word 9
n2: .word 3