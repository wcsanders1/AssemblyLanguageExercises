.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
three DWORD 12345678h
byteVal BYTE 10001111b

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

;4.
	mov		al, -128
	add		al, -1

	INVOKE ExitProcess,0
main ENDP
END main