.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
; for question 1:
three DWORD 12345678h

; for question 7:
val1 DWORD 10h
val2 DWORD 08h
val3 DWORD 0Fh

; for question 8:
dwordArray DWORD 1h, 2h, 3h, 4h

; for question 9:
val22 WORD 08h
val44 WORD 04h

; for questions 12-18:
ALIGN 2
myBytes16 LABEL WORD
myBytes BYTE 10h, 20h, 30h, 40h
myWords32 LABEL DWORD
myWords WORD 3 DUP(?), 2000h
myString BYTE "ABCDE"

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
	neg		val2
	mov		eax, val2
	add		eax, 7
	sub		eax, val3
	add		eax, val1	; eax = 0

; 8.
	mov		edi, OFFSET dwordArray
	mov		ecx, LENGTHOF dwordArray
	mov		eax, 0
L1:
	add		eax, [edi]
	add		edi, TYPE dwordArray
	loop	L1

; 9.
	mov		bx, 0
	add		bx, val22
	sub		bx, val44
	mov		ax, bx

; 10.
	mov		al, -128	; answer same as for question 4 above
	add		al, -1

; 11.
	mov		al, 255
	inc		al			; zero flag set, also indicating overflow
	mov		al, 1
	dec		al

; 12. See above data section

; 13.
	mov		eax, TYPE myBytes		; eax = 1
	mov		eax, LENGTHOF myBytes	; eax = 4
	mov		eax, SIZEOF myBytes		; eax = 4
	mov		eax, TYPE myWords		; eax = 2
	mov		eax, LENGTHOF myWords	; eax = 4
	mov		eax, SIZEOF myWords		; eax = 8
	mov		eax, SIZEOF myString	; eax = 5

; 14.
	mov		dx, WORD PTR myBytes

; 15.
	mov		al, BYTE PTR myWords

; 16.
	mov		eax, DWORD PTR myBytes

; 17.
	mov		eax, myWords32

; 18.
	mov		ax, myBytes16

	INVOKE ExitProcess,0
main ENDP

setCarryFlagToZero PROC
	mov		al, 1
	add		al, 1

	ret
setCarryFlagToZero ENDP

END main