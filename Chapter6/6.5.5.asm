.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
x DWORD 0

.code
main PROC

; ---------------------------------- 1.
	mov		ebx, 5
	mov		ecx, 4
	cmp		ebx, ecx
	jng		quit
	mov		x, 1

quit:

	INVOKE ExitProcess,0
main ENDP
END main