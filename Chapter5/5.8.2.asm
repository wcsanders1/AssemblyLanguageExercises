.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.code
main PROC
	mov		eax, 5
	mov		ebx, 6
	push	eax
	push	ebx
	pop		eax
	pop		ebx

	INVOKE ExitProcess,0
main ENDP
END main