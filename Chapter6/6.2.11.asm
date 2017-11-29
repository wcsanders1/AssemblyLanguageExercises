.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data


.code
main PROC

; ---------------------------------- 1.
	xor		ah, ah

; ---------------------------------- 2.
	or		ah, 0FFh

; ---------------------------------- 3.
	xor		eax, 0FFFFFFFFh

; ---------------------------------- 4.
	mov		eax, 4d		; move even number into eax to test
	and		eax, 1b
	mov		eax, 3d		; move odd number into eax to test
	and		eax, 1b

; ---------------------------------- 5.
	mov		al, 01000001b	; uppercase 'a'
	or		al, 00100000b

	INVOKE ExitProcess,0
main ENDP
END main