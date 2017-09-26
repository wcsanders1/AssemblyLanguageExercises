.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
three DWORD 12345678h

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


	INVOKE ExitProcess,0
main ENDP
END main