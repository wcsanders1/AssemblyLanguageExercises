.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
prompt BYTE "Enter an integer I guess: ",0

.code
main PROC
	mov		edx, OFFSET prompt
	call	WriteString
	call	ReadInt

	INVOKE ExitProcess,0
main ENDP
END main