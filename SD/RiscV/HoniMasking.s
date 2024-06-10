li a0, 0x11223344

li t0, 0xFF

and a4, a0, t0

srli a3, a0, 8
and a3, t0, a3

srli a2, a0, 16
and a2, t0, a2

srli a1, a0, 24
and a1, t0, a1