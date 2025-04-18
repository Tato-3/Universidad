extern malloc
extern free
extern fprintf

section .data
fmt_str: db "%s", 0   ; string de formato para fprintf
section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
strCmp:
	;a en rdi
	;b en rsi
	push rbp
	mov rbp, rsp


	.loop:
		mov rdx, [rdi]	;Muevo cada carater a un registro de un byte
		mov rcx, [rsi]

		cmp dl, cl
    	jl .ret_1         ; a < b
    	jg .ret_minus1 
		je .equal
	
	.equal:
		cmp dl, 0
		je .ret_0
		inc rdi
		inc rsi
		jmp .loop


	.ret_minus1:
		mov eax, -1
		jmp .fin

	.ret_1:
		mov eax, 1
		jmp .fin

	.ret_0:			
		mov eax, 0
		jmp .fin

	.fin:
		pop rbp
		ret

; char* strClone(char* a)
strClone:
	push rbp
	mov rbp, rsp
	push r12
	push r13
	push r14
	push r15
	mov r12, rdi	;preservo el valor de rdi
	call strLen	
	mov edi, eax
	inc edi
	mov r13d, edi	;preservo el len
	call malloc		;rax tiene el puntero a la nueva memoria
	mov r14, rax	;preservo para que rax apunte al primer caracter
	mov r15, rax	;guardo rax en r15 porque r15 apunta al primer char
	xor rax, rax
	.loop_clone:
		cmp r13d, 1
		je fin_clone

		mov al, [r12]
		mov [r14], al
		
		inc r14
		inc r12
		dec r13d
		jmp .loop_clone

	fin_clone:
		mov byte [r14], 0
		mov rax, r15
		pop r15
		pop r14	
		pop r13 
		pop r12
		pop rbp	
		ret

; void strDelete(char* a)
strDelete:
	push rbp
	mov rbp, rsp
	call free
	pop rbp
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
	push rbp
	mov rbp, rsp

	mov rdx, rdi
	mov rdi, rsi
	mov rsi, [rel fmt_str]

	call fprintf

	pop rbp
	ret

; uint32_t strLen(char* a)
strLen:
	mov rsi, rdi
	xor rdx, rdx
	xor eax, eax
	.loop_len:
		mov dl, [rsi]

		cmp dl, 0
		je .fin_len

		inc rsi
		inc eax
		jmp .loop_len

	.fin_len:
		ret


