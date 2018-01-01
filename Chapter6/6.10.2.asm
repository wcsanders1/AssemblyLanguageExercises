.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
parityVar DWORD 1235d

.code
main PROC

; ---------------------------------- 1.
	and al, 0Fh

; ---------------------------------- 2.
	mov al, BYTE PTR parityVar
	xor al, BYTE PTR parityVar + 1
	xor al, BYTE PTR parityVar + 2
	xor al, BYTE PTR parityVar + 3

	INVOKE ExitProcess,0
main ENDP
END main