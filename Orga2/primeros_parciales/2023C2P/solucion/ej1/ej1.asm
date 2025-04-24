section .text
global contar_pagos_asm

global contar_pagos_aprobados_asm
global contar_pagos_rechazados_asm

global split_pagos_usuario_asm

extern malloc
extern free
extern strcmp

PAGO_MONTO EQU 0
PAGO_APROBADO EQU 1
PAGO_PAGADOR EQU 8
PAGO_COBRADOR EQU 16

CANT_APROBADOS EQU 0
CANT_RECHAZADOS EQU 1
APROBADOS EQU 8
RECHAZADOS EQU 16

USER_DATA EQU 0
LIST_NEXT EQU 8
LIST_PREV EQU 16

LIST_FIRST EQU 0
LIST_LAST EQU 8

SPLITTED_SIZE EQU 24
PAGO_SIZE EQU 24
;########### SECCION DE TEXTO (PROGRAMA)

;uint8_t contar_pagos(list_t* pList, char* usuario, uint8_t tipoDePago);
contar_pagos_asm:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    xor r13, r13    ;Va a ser mi contador
    ;r8 apunta al primer elemento de la lista
    mov r8, qword [rdi+LIST_FIRST]
    ;r9 el ultimo
    mov r12, qword [rdi+LIST_LAST]
    .while:
        cmp r8, r12
        je .end

        mov r9, qword [r8 + USER_DATA]
        mov rdi, [r9 + PAGO_COBRADOR]
        call strcmp

        cmp rax, 0
        jne .next
        
        cmp dl, byte [r9 + PAGO_APROBADO]
        jne .next
        
        inc r13

        .next:
            mov r8, [r8 + LIST_NEXT]
            jmp .while
    .end:
        mov rax, r13
        pop r13
        pop r12
        pop rbp
        ret

; uint8_t contar_pagos_aprobados_asm(list_t* pList, char* usuario);
contar_pagos_aprobados_asm:
    push rbp
    mov rbp, rsp

    mov dl, 1
    call contar_pagos_asm

    pop rbp
    ret

; uint8_t contar_pagos_rechazados_asm(list_t* pList, char* usuario);
contar_pagos_rechazados_asm:
    push rbp
    mov rbp, rsp

    mov dl, 0
    call contar_pagos_asm

    pop rbp
    ret

; pagoSplitted_t* split_pagos_usuario_asm(list_t* pList, char* usuario);
split_pagos_usuario_asm:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    sub rsp, 32


    ;R12 apunta a pList y R13 al Usuario
    mov r12, rdi
    mov r13, rsi
    ;Llamo a cant aprobados y rechazados
    call contar_pagos_aprobados_asm
    mov r14b, al
    ;Restauro rdi y rsi por si cambiaron por el call
    mov rdi, r12
    mov rsi, r13

    call contar_pagos_rechazados_asm
    mov r15b, al
    
    ;En R14b cant de Aprobados y R15B Rechazados

    ;Pido memoria para el puntero a pagoSplitted
    mov rdi, SPLITTED_SIZE
    call malloc
    ;RDI apunta a pagoSplitted
    mov rdi, rax
    ;Guardo en pagoSplitted la cant de aprobados y rechazados
    mov byte [rdi+CANT_APROBADOS], r14b
    mov byte [rdi+CANT_RECHAZADOS], r15b
    ;Pido memoria para un puntero de los aprobados y rechazados
    ;Como ya guarde R14 y R15 los uso para otra cosa
    ;R14 ahora apunta a mi pagoSplitted
    mov r14, rdi
    ;En RDI pongo la cant neceseria para la memoria
    ;Aprobados
    movzx rdi, byte [r14+CANT_APROBADOS]
    test rdi, rdi
    jz _0_aprobados
    shl rdi, 3
    call calloc
    mov qword [r14+APROBADOS], rax
    _0_aprobados:
    ;Rechazados
    movzx rdi, byte [r14+CANT_RECHAZADOS]
    test rdi, rdi
    jz _0_rechazados
    shl rdi, 3
    call calloc
    mov qword [r14+RECHAZADOS], rax
    _0_rechazados:
    ;En R12 voy a tener el primer elemto de la lista y en [rsp] el ultimo
    mov rdi, qword [r12+LIST_LAST]
    mov [rsp], rdi
    mov r12, qword [r12+LIST_FIRST]

    ;Voy a usar dos iteradores en la pila
    mov qword [rsp+8], 0      ;Iterador para aprobados
    mov qword [rsp+16], 0     ;Iterador para rechazados

    _while:
        ;Uso R15 para la data del user
        mov r15, [r12+USER_DATA]
        ;Comparo si son el mismo user
        mov rdi, [r15+PAGO_COBRADOR]
        mov rsi, r13
        call strcmp

        cmp rax, 0
        jne _next

        ;Me fijo si agrego el pago en aprobado o rechazado
        cmp byte [r15+PAGO_APROBADO], 1
        jne _rechazados
        ;Aprobados
        mov rdi, [r14+APROBADOS]
        mov rsi, [rsp+8]
        shl rsi, 3
        add rdi, rsi
        mov [rdi], r15
        inc qword [rsp+8]
        jmp _next

        ;Rechazados
        _rechazados:
            mov rdi, [r14+RECHAZADOS]
            mov rsi, [rsp+16]
            shl rsi, 3
            add rdi, rsi
            mov [rdi], r15
            inc qword [rsp+16]
        
        _next:
            cmp r12, [rsp] ;Verifico si ya estoy en el ultimo elem
            je _fin
            mov r12, [r12+LIST_NEXT]            
            jmp _while
    

    _fin:
    mov rax, r14
    add rsp, 32
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret