.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
parityVar DWORD 1235d
setX DWORD 00001111010110100000111100111100b
setY DWORD 10100011010110100000111100011000b
val1 DWORD 10d
X DWORD ?

.code
main PROC

; ---------------------------------- 1.
	and al, 0Fh

; ---------------------------------- 2.
	mov al, BYTE PTR parityVar
	xor al, BYTE PTR parityVar + 1
	xor al, BYTE PTR parityVar + 2
	xor al, BYTE PTR parityVar + 3

; ---------------------------------- 3.
	mov eax, setX
	xor eax, setY

; ---------------------------------- 4.
	cmp dx, cx
	jbe L1

L1:

; ---------------------------------- 5.
	cmp ax, cx
	jg L2

L2:

; ---------------------------------- 6.
	and al, 11111100b
	jz L3
	jmp L4 

L3:
L4:

; ---------------------------------- 7.
	cmp	val1, ecx
	jbe L5
	cmp ecx, edx
	jbe L5
	mov X, 1
	jmp L6

L5:
	mov X, 2

L6:

; ---------------------------------- 8.
	cmp ebx, ecx
	ja L7
	cmp ebx, val1
	ja L7
	mov X, 2
	jmp L8

L7:
	mov X, 1

L8:

	INVOKE ExitProcess,0
main ENDP
END main