; Increment val2; subtract val3 from eax; subtract val4 from val2

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
val1	BYTE	10h
val2	WORD	8000h
val3	DWORD	0FFFFh
val4	WORD	7FFFh

.code
main PROC

	inc		val2
	sub		eax, val3
	movzx	ebx, val2
	sub		bx, val4

	add		val2, 1
	add		val4, 1
	
	INVOKE ExitProcess,0
main ENDP
END main