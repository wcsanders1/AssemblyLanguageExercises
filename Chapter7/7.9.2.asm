.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data

.code
main PROC

; ---------------------------------- 1.

	mov ax, 1000000010000000b	; test value
	xor ebx, ebx
	mov bx, ax
	shrd eax, ebx, 16d
	jc Signed
	
	xor ebx, ebx
	shrd eax, ebx, 16d
	
	jmp Exit1
	
	Signed:
	
		mov ebx, 1111111111111111b
		shrd eax, ebx, 16d

	; or you could just do this:
	; shl eax, 16d
	; sar eax, 16d
	
	Exit1:

; ---------------------------------- 2.

	mov al, 01010101b	; test value
	shr al, 1
	jnc Exit2

	shl al, 1
	mov ah, 00000001b
	shr ax, 1

	; or you could just do this:
	; or al, 80h

	Exit2:

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP
END main