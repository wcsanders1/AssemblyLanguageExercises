.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code

main PROC

	
	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

END main