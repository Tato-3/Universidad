section .data
align 16
mascara_ff dd 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF
section .text

; Marca un ejercicio como aún no completado (esto hace que no corran sus tests)
FALSE EQU 0
; Marca un ejercicio como hecho
TRUE  EQU 1
; Marca el ejercicio 3A como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - ej3a
global EJERCICIO_3A_HECHO
EJERCICIO_3A_HECHO: db FALSE ; Cambiar por `TRUE` para correr los tests.

; Dada una imagen origen escribe en el destino `scale * px + offset` por cada
; píxel en la imagen.
;
; Parámetros:
;   - dst_depth: La imagen destino (mapa de profundidad). Está en escala de
;                grises a 32 bits con signo por canal.
;   - src_depth: La imagen origen (mapa de profundidad). Está en escala de
;                grises a 8 bits sin signo por canal.
;   - scale:     El factor de escala. Es un entero con signo de 32 bits.
;                Multiplica a cada pixel de la entrada.
;   - offset:    El factor de corrimiento. Es un entero con signo de 32 bits.
;                Se suma a todos los píxeles luego de escalarlos.
;   - width:     El ancho en píxeles de `src_depth` y `dst_depth`.
;   - height:    El alto en píxeles de `src_depth` y `dst_depth`.
global ej3a
ej3a:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits.
	;
	; r/m64 = int32_t* dst_depth	rdi
	; r/m64 = uint8_t* src_depth	rsi
	; r/m32 = int32_t  scale		edx
	; r/m32 = int32_t  offset		ecx
	; r/m32 = int      width		r8d
	; r/m32 = int      height		r9d
	push rbp
	mov rbp, rsp

	imul r8, r9	;Cant total de px
	xor r9, r9	;Uso r9 como contador

	.while:	
		cmp r9, r8
		je .fin

		;Cargo los 4 px
		movd xmm0, [rsi]
		;Expando a dword
		pmovzxbd xmm0, xmm0		
		;Xmm1 para scale y xmm2 para offset
		movd xmm1, edx
		movd xmm2, ecx
		;Copio del valor mas bajo hasta todos
		pshufd xmm1, xmm1, 0
		pshufd xmm2, xmm2, 0
		;Hago scale * px + offset
		pmulld xmm0, xmm1
		paddd xmm0, xmm2
		;Como rdi es int32 lo paso directamente sin pack
		movdqa [rdi], xmm0

		add rdi, 16	
		add rsi, 4
		add r9, 4
		jmp .while

	.fin:
	pop rbp
	ret

; Marca el ejercicio 3B como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - ej3b
global EJERCICIO_3B_HECHO
EJERCICIO_3B_HECHO: db FALSE ; Cambiar por `TRUE` para correr los tests.

; Dadas dos imágenes de origen (`a` y `b`) en conjunto con sus mapas de
; profundidad escribe en el destino el pixel de menor profundidad por cada
; píxel de la imagen. En caso de empate se escribe el píxel de `b`.
;
; Parámetros:
;   - dst:     La imagen destino. Está a color (RGBA) en 8 bits sin signo por
;              canal.
;   - a:       La imagen origen A. Está a color (RGBA) en 8 bits sin signo por
;              canal.
;   - depth_a: El mapa de profundidad de A. Está en escala de grises a 32 bits
;              con signo por canal.
;   - b:       La imagen origen B. Está a color (RGBA) en 8 bits sin signo por
;              canal.
;   - depth_b: El mapa de profundidad de B. Está en escala de grises a 32 bits
;              con signo por canal.
;   - width:  El ancho en píxeles de todas las imágenes parámetro.
;   - height: El alto en píxeles de todas las imágenes parámetro.
global ej3b
ej3b:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits.
	;
	; r/m64 = rgba_t*  dst		rdi
	; r/m64 = rgba_t*  a		rsi
	; r/m64 = int32_t* depth_a	rdx
	; r/m64 = rgba_t*  b		rcx
	; r/m64 = int32_t* depth_b	r8
	; r/m32 = int      width	r9d
	; r/m32 = int      height	[rbp+16]
	push rbp
	mov rbp, rsp

	imul r9, [rbp+16]	;Cant total de px
	xor rax, rax ;Uso rax como mi contador
	_while:	
		cmp rax, r9
		je _fin

		;Cargo las profundidades
		movdqa xmm0, [rdx]
		movdqa xmm1, [r8]
		;Mascara de a
		movdqa xmm2, xmm1
		PCMPGTD xmm2, xmm0	;Si los valores de b > a estos pongo 1
		;Mascara de b (inivierto la mascara a)
		movdqa xmm3, [mascara_ff]
		movdqa xmm4, xmm2
		pxor xmm4, xmm3
		;Cargo los pixeles de a y b
		;Mascara de a esta en xmm2 y mascara de b esta en xmm4
		movdqa xmm0, [rsi]
		movdqa xmm1, [rcx]
		;Aplico la mascara
		pand xmm0, xmm2
		pand xmm1, xmm4
		;Combino los pixeles
		por xmm0, xmm1

		movdqa [rdi], xmm0

		add rax, 4
		add rdi, 16
		add rsi, 16
		add rcx, 16
		add rdx, 16
		add r8, 16
		jmp _while

	_fin:
	pop rbp
	ret
