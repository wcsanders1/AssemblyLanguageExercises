.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data

.code
main PROC

; ---------------------------------- 1.

	mov ax, 1000000010000000b	; test value
	xor ebx, ebx
	mov bx, ax
	shrd eax, ebx, 16d
	jc Signed
	
	xor ebx, ebx
	shrd eax, ebx, 16d
	
	jmp Exit1
	
	Signed:
	
		mov ebx, 1111111111111111b
		shrd eax, ebx, 16d

	; or you could just do this:
	; shl eax, 16d
	; sar eax, 16d
	
	Exit1:

; ---------------------------------- 2.

	mov al, 01010101b	; test value
	shr al, 1
	jnc Exit2

	shl al, 1
	mov ah, 00000001b
	shr ax, 1

	; or you could just do this:
	; or al, 80h

	Exit2:

; ---------------------------------- 3.

	xor eax, eax
	mov eax, 3d
	shl eax, 4d

; ---------------------------------- 4.

	xor ebx, ebx
	mov ebx, 16d
	shr ebx, 2

; ---------------------------------- 5.

	mov dl, 00001111b
	rol dl, 4

; ---------------------------------- 6.

	mov ax, 1000000000000000b
	mov dx, 0000000000000001b
	shld dx, ax, 1

; ---------------------------------- 7.

	.data
	byteArray7 BYTE 81h, 20h, 33h

	.code
	mov ecx, SIZEOF byteArray7
	xor esi, esi

	LP7:
		shr byteArray7[esi], 1
		inc esi
		loop LP7

; ---------------------------------- 8.

	.data
	wordArray8 WORD 810Dh, 0C64h, 93ABh

	.code
	mov ecx, LENGTHOF wordArray8
	xor esi, esi

	LP8:
		shl wordArray8[esi], 1
		add esi, SIZEOF WORD
		loop LP8

; ---------------------------------- 9.

	.data
	val_9 WORD 0

	.code
	mov ax, -5d
	mov bx, 3
	imul bx
	mov val_9, ax

; ---------------------------------- 10.

	.data
	val_10 WORD 0

	.code
	xor dx, dx
	mov ax, -276d
	cwd
	mov bx, 10d
	idiv bx
	mov val_10, ax

; ---------------------------------- 11.

	.data
	val1_11 DWORD 0
	val2_11 DWORD 5		; test value
	val3_11 DWORD 8		; test value
	val4_11 DWORD 13d	; test value

	.code
	mov eax, val2_11
	mul val3_11
	sub val4_11, 3
	div val4_11
	mov val1_11, eax

; ---------------------------------- 12.

	.data
	val1_12 DWORD 2
	val2_12 DWORD 20d		; test value
	val3_12 DWORD 5d		; test value

	.code
	xor edx, edx
	mov eax, val2_12
	cdq
	mov ebx, val3_12
	idiv ebx
	mov ebx, val1_12
	add ebx, val2_12
	imul ebx
	mov val1_12, eax

; ---------------------------------- 13.

	mov ax, 81d
	call displayBinaryToDecimal

; ---------------------------------- 15.

	.data
	n_15 DWORD 10d
	y_15 DWORD 4d
	x_15 DWORD 0

	.code
	mov edx, y_15
	sub edx, 1
	mov eax, n_15
	and eax, edx
	mov x_15, eax

; ******** END OF QUESTIONS **********	

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

displayBinaryToDecimal PROC
;-----------------------------------------------------------------------------
; Displays a binary value in decimal format
; Receives: AL = Binary value between 0 and 99
; Returns: nothing
;-----------------------------------------------------------------------------

	shl ax, 8
	shr ax, 8
	mov bl, 10d
	div bl
	or al, 00110000b
	call WriteChar
	mov al, ah
	or al, 00110000b
	call WriteChar

	; or just do this:
	; aam
	; or ax, 3030h
	; push eax
	; mov al, ah
	; call WriteChar
	; pop eax
	; call WriteChar

	ret
displayBinaryToDecimal ENDP

END main