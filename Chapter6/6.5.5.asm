.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
x DWORD 0
sum DWORD 0
sample DWORD 50
array DWORD 10, 60, 20, 33, 72, 89, 45, 65, 72, 18
arraySize = ($ - array) / TYPE array

.code
main PROC

; ---------------------------------- 1.
	mov		ebx, 5
	mov		ecx, 4
	cmp		ebx, ecx
	jng		q2
	mov		x, 1

; ---------------------------------- 2.
q2:

	mov		ecx, 5
	mov		edx, 6
	cmp		edx, ecx
	jng		make1
	mov		x, 2
	jmp		q4

make1:
	mov		x, 1

; ---------------------------------- 4.
q4:
	
	mov		eax, 0
	mov		edx, sample
	mov		esi, 0
	mov		ecx, arraySize

	L1:
		cmp		array[esi * 4], edx
		jng		L2
		add		eax, array[esi * 4]
	
	L2:
		inc		esi
		loop	L1
	
		mov		sum, eax

quit:

	INVOKE ExitProcess,0
main ENDP
END main