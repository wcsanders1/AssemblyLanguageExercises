.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code
main PROC

; ---------------------------------- 5.

	mov eax, 1
	mov ebx, 0

	rcr ax, 1
	rcr bx, 1

	mov eax, 1
	mov ebx, 0

	shrd bx, ax, 1

; ---------------------------------- 6.

	mov ecx, 32d
	mov eax, 01010101010101010101010101010101b
	mov ebx, 0

	FindParity:
		ror eax, 1
		jnc NotOne
		inc ebx

		NotOne:
			loop FindParity

	ror ebx, 1
	jc ClearParityFlag

	SetParityFlag:
		cmp bl, bl
		jmp End6

	ClearParityFlag:
		and bl, 0
		or bl, 1

	End6:

	INVOKE ExitProcess,0
main ENDP
END main