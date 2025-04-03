section .text
    global cesar_asm

cesar_asm:
    push rbp
    mov rbp, rsp

    mov rax, rdi
    mov rcx, rdi

    while:
        cmp byte [rcx], 0   ; compara el byte actual con 0 (null terminator)
        je fin         ; si es 0, salta al final

        movzx r10, byte [rcx] ; mueve el byte de [rcx] a r10 y lo extiende a 64 bits

        sub r10, 'A'      ; ajusta el valor para el rango A-Z
        add r10, rdx      ; aplica el desplazamiento (key)
        mov rsi, 26       ; prepara el divisor para módulo 26
        xor rdx, rdx      ; limpia rdx antes de la división
        div rsi           ; divide r10 entre 26; resultado en rax, resto en rdx
        add rdx, 'A'      ; ajusta de vuelta al rango de caracteres

        mov byte [rcx], dl ; almacena el resultado en el destino

        inc rcx           ; mueve al siguiente carácter
        jmp while    ; repite el bucle

    fin:
        pop rbp
        ret
