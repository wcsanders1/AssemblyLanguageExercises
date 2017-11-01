.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
ptr1 DWORD ?

.code
main PROC

; 1.
	mov		eax, 5
	mov		ebx, 6
	push	eax
	push	ebx
	pop		eax
	pop		ebx

; 2.
	mov		eax, 1
	mov		eax, 2
	mov		eax, 3
	mov		eax, 4
	
	;call returnThreeBytesHigher

; 3.
	call reserveSpace

	INVOKE ExitProcess,0
main ENDP

returnThreeBytesHigher PROC
	pop		ebx
	add		ebx, 3
	push	ebx
	
	ret
returnThreeBytesHigher ENDP

reserveSpace PROC
	pop		ebx
	sub		esp, 8
	mov		eax, [esp]
	mov		ptr1, eax
	mov		[ptr1], 1000h
	mov		[ptr1 + 4], 2000h
	push	ebx
	ret

reserveSpace ENDP

END main