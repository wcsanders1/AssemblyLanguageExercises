.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code
main PROC

; ---------------------------------- 1.
	mov eax, 6
	
; ******** END OF QUESTIONS **********

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP


;***********************************************************************
AddThree PROC
;-----------------------------------------------------------------------------
; Outputs a decimal; ASCII number with an implied decimal point
; Receives: EBX = decimal offset
;			ECX = number length
;			EDX = number's offset
; Returns: nothing
;-----------------------------------------------------------------------------


AddThree ENDP

;***********************************************************************

END main