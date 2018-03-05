.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data

.code
main PROC

; ---------------------------------- 1.

	mov ax, 0000000010000000b	; test value
	xor ebx, ebx
	mov bx, ax
	shrd eax, ebx, 16d
	jc Signed

	xor ebx, ebx
	shrd eax, ebx, 16d

	jmp ExitApp

	Signed:

		mov ebx, 1111111111111111b
		shrd eax, ebx, 16d

	ExitApp:

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP
END main