; Determine what the values of registers and flags will be after
; certain operations.

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
one WORD 8002h
two WORD 4321h
dVal DWORD 12345678h
dVal2 DWORD ?

var1 SWORD -4,-2,3,1
var2 WORD 1000h,2000h,3000h,4000h
var3 SWORD -16,-42
var4 DWORD 1,2,3,4,5

.code
main PROC
	mov		edx, 21348041h
	movsx	edx, one
	movsx	edx, two

	mov		eax, 1002FFFFh
	inc		ax

	mov		eax, 30020000h
	dec		ax

	mov		eax, 1002FFFFh
	neg		ax

	mov		al, 0
	add		al, 3

	mov		eax, 5
	sub		eax, 6

	mov		al, -1
	add		al, 130

	mov		ax, 3
	mov		WORD PTR dVal+2, ax
	mov		eax, dVal

	mov		dVal2, 12345678h
	mov		ax, WORD PTR dVal2+2
	add		ax, 3
	mov		WORD PTR dVal2, ax
	mov		eax, dVal2

	mov		ax, var2
	mov		ax, [var2+4]
	mov		ax, var3
	mov		ax, [var3-2]

	mov		edx, var4
	movzx	edx, var2
	mov		edx, [var4+4]
	movsx	edx, var1
	
	INVOKE ExitProcess,0
main ENDP
END main