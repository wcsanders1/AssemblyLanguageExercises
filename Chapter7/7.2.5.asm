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

; ---------------------------------- 2.
	
	call ReadDec
	mov ecx, eax
	mov ebx, eax
	shl eax, 4
	shl ebx, 2
	add eax, ebx
	add eax, ecx
	call WriteDec
	call Crlf

	call Crlf
	call WaitMsg

	INVOKE ExitProcess,0
main ENDP
END main