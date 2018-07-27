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

SwapInts PROC PRIVATE USES eax ebx ecx,
	val1:dword, val2:dword
;-----------------------------------------------------------------------------
; Exchanges the values of two ints
; Receives: The values of two ints
; Returns: Nothing
;-----------------------------------------------------------------------------

SwapInts ENDP

END main