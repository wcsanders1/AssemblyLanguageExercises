.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
prompt BYTE "Enter an integer I guess: ",0
buffer BYTE 15 DUP (?)
count DWORD ?

.code
main PROC
	mov		edx, OFFSET prompt
	call	WriteString
	
	mov		edx, OFFSET buffer
	mov		ecx, SIZEOF buffer
	
	call	ReadString
	
	mov		count, eax
main ENDP
END main