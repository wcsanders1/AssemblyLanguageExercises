.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data


.code
main PROC
	mov		eax, 0
	mov		ebx, 10

L1:
	mov		eax, 3
	mov		ecx, 5

L2:
	add		eax, 5
	loop	L2
	dec		ebx
	mov		ecx, ebx
	loop	L1
	
	INVOKE ExitProcess,0
main ENDP
END main