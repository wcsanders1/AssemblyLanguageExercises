.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
exVal SWORD -60

.code
main PROC

; ---------------------------------- 7.

	mov ax, exVal
	cwd
	mov bx, 30
	idiv bx

	INVOKE ExitProcess,0
main ENDP
END main