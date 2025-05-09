	section .rodata
	; Poner acá todas las máscaras y coeficientes que necesiten para el filtro
	align 16
	mascara_alfa: db 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255
	align 16
	mascara_notAlfa: db 255, 255, 255, 0, 255, 255, 255, 0, 255, 255, 255, 0, 255, 255, 255, 0
	;Mascaras para extraer los colores
	align 16
	mascara_rojo db 0x00, 0x04, 0x08, 0x0C
	align 16
	mascara_verde db 0x01, 0x05, 0x09, 0x0D
	align 16
	mascara_azul db 0x02, 0x06, 0x0A, 0x0E
	;Para reordenar al final los colores a sus posiciones
	align 16
	shuffle_rojo db 0, -1, -1, -1, 1, -1, -1, -1, 2, -1, -1, -1, 3, -1, -1, -1
	align 16
	shuffle_verde db -1, 0, -1, -1, -1, 1, -1, -1, -1, 2, -1, -1, -1, 3, -1, -1
	align 16
	shuffle_azul db  -1, -1, 0, -1, -1, -1, 1, -1, -1, -1, 2, -1, -1, -1, 3, -1
	;Mascaras para mis calculos
	align 16
	mascara_div3: dd 0.3333333, 0.3333333, 0.3333333, 0.3333333
	align 16
	mascara_192 dd 192, 192, 192, 192
	align 16
	mascara_384 dd 384, 384, 384, 384
	align 16
	mascara_255 dd 255, 255, 255, 255
	align 16
	mascara_64 dd 64, 64, 64, 64
	align 16
	mascara_128 dd 128, 128, 128, 128
	
	section .text



	; Marca un ejercicio como aún no completado (esto hace que no corran sus tests)
	FALSE EQU 0
	; Marca un ejercicio como hecho
	TRUE  EQU 1

	; Marca el ejercicio 2 como hecho (`true`) o pendiente (`false`).
	;
	; Funciones a implementar:
	;   - ej1
	global EJERCICIO_2_HECHO
	EJERCICIO_2_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

	; Aplica un efecto de "mapa de calor" sobre una imagen dada (`src`). Escribe la
	; imagen resultante en el canvas proporcionado (`dst`).
	;
	; Para calcular el mapa de calor lo primero que hay que hacer es computar la
	; "temperatura" del pixel en cuestión:
	; ```
	; temperatura = (rojo + verde + azul) / 3
	; ```
	;
	; Cada canal del resultado tiene la siguiente forma:
	; ```
	; |          ____________________
	; |         /                    \
	; |        /                      \        Y = intensidad
	; | ______/                        \______
	; |
	; +---------------------------------------
	;              X = temperatura
	; ```
	;
	; Para calcular esta función se utiliza la siguiente expresión:
	; ```
	; f(x) = min(255, max(0, 384 - 4 * |x - 192|))
	; ```
	;
	; Cada canal esta offseteado de distinta forma sobre el eje X, por lo que los
	; píxeles resultantes son:
	; ```
	; temperatura  = (rojo + verde + azul) / 3
	; salida.rojo  = f(temperatura)
	; salida.verde = f(temperatura + 64)
	; salida.azul  = f(temperatura + 128)
	; salida.alfa  = 255
	; ```
	;
	; Parámetros:
	;   - dst:    La imagen destino. Está a color (RGBA) en 8 bits sin signo por
	;             canal.
	;   - src:    La imagen origen A. Está a color (RGBA) en 8 bits sin signo por
	;             canal.
	;   - width:  El ancho en píxeles de `src` y `dst`.
	;   - height: El alto en píxeles de `src` y `dst`.
	global ej2
	ej2:
		; Te recomendamos llenar una tablita acá con cada parámetro y su
		; ubicación según la convención de llamada. Prestá atención a qué
		; valores son de 64 bits y qué valores son de 32 bits.
		;
		; r/m64 = rgba_t*  dst		rdi
		; r/m64 = rgba_t*  src		rsi
		; r/m32 = uint32_t width	edx
		; r/m32 = uint32_t height	ecx
		push rbp
		mov rbp, rsp

		movdqa xmm0, [mascara_alfa]

		movdqa xmm1, [mascara_rojo]
		movdqa xmm2, [mascara_verde]
		movdqa xmm3, [mascara_azul]

		movdqa xmm7, [shuffle_rojo]
		movdqa xmm8, [shuffle_verde]
		movdqa xmm9, [shuffle_azul]

		imul rdx, rcx	;rdx va a ser la cant total de pixeles
		xor r8, r8		;Contador
		
		.while:
			cmp rdx, r8
			je .fin

			movdqa xmm14, [rsi]

			movdqa xmm4, xmm14
			movdqa xmm5, xmm14
			movdqa xmm6, xmm14	

			;Extraigo Colores
			pshufb xmm4, xmm1		;Me quedo solo con los rojos
			pshufb xmm5, xmm2		;Me quedo solo con los verdes
			pshufb xmm6, xmm3		;Me quedo solo con los azules

			;Ahora paso los bytes a dwords
			pmovzxbd xmm4, xmm4		;Expando a dword
			pmovzxbd xmm5, xmm5		;Expando a dword
			pmovzxbd xmm6, xmm6		;Expando a dword

			;Calculo la temperatura
			paddd xmm4, xmm5	
			paddd xmm4, xmm6

			;Lo paso a float para multiplicar por 1/3
			CVTDQ2PS xmm4, xmm4
			mulps xmm4, [mascara_div3]

			;Los convierto a dword
			CVTPS2DQ xmm4, xmm4	;Float a dword
			
			; Copio a xmm5 y xmm6
			movdqa xmm5, xmm4	; Representa a los verdes
			movdqa xmm6, xmm4	; Representa a los azules

			paddd xmm5, [mascara_64]	; Para f(temperatura + 64)
			paddd xmm6, [mascara_128]	; Para f(temperatura + 128)

			; Calculo x-192
			psubd xmm4, [mascara_192]
			psubd xmm5, [mascara_192]
			psubd xmm6, [mascara_192]

			; Calculo |x - 192|
			pabsd xmm4, xmm4
			pabsd xmm5, xmm5
			pabsd xmm6, xmm6

			; Calculo 4*
			pslld xmm4, 2
			pslld xmm5, 2
			pslld xmm6, 2

			; Calculo 384 -
			movdqa xmm15, [mascara_384]

			psubd xmm15, xmm4
			movdqa xmm4, xmm15

			movdqa xmm15, [mascara_384]
			psubd xmm15, xmm5
			movdqa xmm5, xmm15

			movdqa xmm15, [mascara_384]
			psubd xmm15, xmm6
			movdqa xmm6, xmm15

			; Max (0, x)
			pxor xmm15, xmm15	; xmm15 = 0
			pmaxsd xmm4, xmm15
			pmaxsd xmm5, xmm15
			pmaxsd xmm6, xmm15

			; Min 255, x
			pminsd xmm4, [mascara_255]
			pminsd xmm5, [mascara_255]
			pminsd xmm6, [mascara_255]

			;Los paso a byte
			packusdw xmm4, xmm4	;Dword a word
			packusdw xmm5, xmm5	;Dword a word
			packusdw xmm6, xmm6	;Dword a word
			
			packuswb xmm4, xmm4	;Word a byte
			packuswb xmm5, xmm5	;Word a byte
			packuswb xmm6, xmm6	;Word a byte

			pshufb xmm4, xmm7
			pshufb xmm5, xmm8
			pshufb xmm6, xmm9

			por xmm4, xmm5
			por xmm4, xmm6
			
			pand xmm4, [mascara_notAlfa]
			por xmm4, [mascara_alfa]

			movdqa [rdi], xmm4

			add r8, 4
			add rdi, 16
			add rsi, 16
			jmp .while


		.fin:
			pop rbp
			ret