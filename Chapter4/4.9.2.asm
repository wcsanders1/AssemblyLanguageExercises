.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
; for question 1:
three DWORD 12345678h

; for question 7:
val1 DWORD 00000005h
val2 DWORD 00000008h
val3 DWORD 0000000Fh

.code
main PROC

; 1.
	mov		ax, WORD PTR three	
	mov		bx, WORD PTR three + 2
	mov		WORD PTR three, bx
	mov		WORD PTR three + 2, ax

; 2.
	mov		ah,	1	; A
	mov		al, 2	; B
	mov		bh, 3	; C
	mov		bl, 4	; D

	xchg	ah, al	; BACD
	xchg	al, bl	; BDCA
	xchg	al, bh	; BCDA

; 3.
	mov		al, 01110101b
	dec     al
	inc		al
	lahf			; moves values of sign, zero, aux carry, parity, and carry flags in ah

; 4.
	mov		al, -128
	add		al, -1

; 5.
	call	setCarryFlagToZero

	mov		al, 1
	add		al,	255

; 6.
	call	setCarryFlagToZero

	mov		al, 0
	sub		al, 255

; 7.
	

	INVOKE ExitProcess,0
main ENDP

setCarryFlagToZero PROC
	mov		al, 1
	add		al, 1

	ret
setCarryFlagToZero ENDP

END main