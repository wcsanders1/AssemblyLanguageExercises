.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
myBytes		BYTE 10h, 20h, 30h, 40h
myWords		WORD 8Ah, 3Bh, 72h, 44h, 66h
myDoubles	DWORD 1, 2, 3, 4, 5
myPointers	DWORD myDoubles

.code
main PROC

	mov esi, OFFSET myBytes
	mov al, [esi]				; AL = 10h
	mov al, [esi + 3]			; AL = 40h
	
	INVOKE ExitProcess,0
main ENDP
END main