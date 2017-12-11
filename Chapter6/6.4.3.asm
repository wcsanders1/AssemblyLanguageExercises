.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
array SWORD 3, 6, 1, 10, -10, -30, -40, -4
sentinel SWORD 0

.code
main PROC

	mov		esi, OFFSET array
	mov		ecx, LENGTHOF array

L1:
	test	WORD PTR [esi], 8000h
	pushfd
	add		esi, TYPE Array
	popfd
	loopz	L1

	jnz		quit
	sub		esi, TYPE array

quit:

	INVOKE ExitProcess,0
main ENDP
END main