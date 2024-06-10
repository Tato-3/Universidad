.data:

cyan: .word 0x009696
mascara: .word 0x00FF00
rojo: .byte 0x00 0x00 0x96 0x00



.text:
    
lw t0, cyan
lw t1, mascara
lw t2, rojo
#quiero el verde
and a0, t0, t1
#Combino verde con rojo
or a0, a0, t2     #Me queda amarillo

