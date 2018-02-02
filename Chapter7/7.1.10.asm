.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code
main PROC

; ---------------------------------- 5.

	mov eax, 1
	mov ebx, 0

	rcr ax, 1
	rcr bx, 1

	mov eax, 1
	mov ebx, 0

	shrd bx, ax, 1
	INVOKE ExitProcess,0
main ENDP
END main