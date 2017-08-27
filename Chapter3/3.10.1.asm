.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.code
main PROC
	mov		eax, 1
	mov		ebx, 2
	mov		ecx, 3
	mov		edx, 4
	
	add		ecx, edx
	add		ebx, ecx
	add		eax, ebx
	
	INVOKE ExitProcess,0
main ENDP
END main