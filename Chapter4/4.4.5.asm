; Practice with memory

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
myBytes		BYTE 10h, 20h, 30h, 40h
myWords		WORD 8Ah, 3Bh, 72h, 44h, 66h
myDoubles	DWORD 1, 2, 3, 4, 5
myPointer	DWORD myDoubles

.code
main PROC

	mov esi, OFFSET myBytes
	mov al, [esi]				; AL = 10h
	mov al, [esi + 3]			; AL = 40h
	mov esi, OFFSET myWords + 2
	mov ax, [esi]				; AX = 3Bh
	mov edi, 8
	mov edx, [myDoubles + edi]	; EDX = 3
	mov edx, myDoubles[edi]		; EDX = 3
	mov ebx, myPointer
	mov eax, [ebx + 4]			; EAX = 2

	mov esi, OFFSET myBytes
	mov ax, [esi]				; AX = 10h
	mov eax, DWORD PTR myWords	; EAX = 8Ah
	mov esi, myPointer
	mov ax, [esi + 2]			; AX = 0
	mov ax, [esi + 6]			; AX = 0
	mov ax, [esi - 4]			; AX = 44h
	
	INVOKE ExitProcess,0
main ENDP
END main