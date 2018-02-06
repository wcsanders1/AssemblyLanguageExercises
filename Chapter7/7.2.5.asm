.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code
main PROC

; ---------------------------------- 1.

	call ReadDec
	mov ebx, eax
	shl eax, 4
	shl ebx, 3
	add eax, ebx
	call WriteDec

	call Crlf
	call WaitMsg

	INVOKE ExitProcess,0
main ENDP
END main