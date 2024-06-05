#s0 = dir. scores, s1 = i
addi s1, zero, 0
addi t2, zero, 10
for:
bge s1, t2, fin
slli t0, s1, 2
add t0, t0 , s0
lw t1, 0(t0)
addi t1, t1, 10
sw t1, 0(t0)
addi s1,s1, 1
j for
fin: