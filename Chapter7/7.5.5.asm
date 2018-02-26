.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data

.code
main PROC

; ---------------------------------- 1.

	or ax, 3030h

; ---------------------------------- 2.

	and ax, 0F0Fh

; ---------------------------------- 3.

	and ax, 0F0Fh
	aad

; ---------------------------------- 4.	

	aam

main ENDP
END main