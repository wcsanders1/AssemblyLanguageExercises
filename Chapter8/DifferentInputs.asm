.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code

DifferentInputs PROC USES ebx,
	val1:dword, val2:dword, val3:dword
;-----------------------------------------------------------------------------
; Returns 1 in EAX if the values of the three inputs are different, otherwise 0
; Receives: Three integer values
;-----------------------------------------------------------------------------

	xor eax, eax
	mov ebx, val1
	cmp ebx, val2
	je exitDifferentInputs
	cmp ebx, val3
	je exitDifferentInputs
	mov eax, 1

	exitDifferentInputs:

	ret

DifferentInputs ENDP

main PROC

	invoke DifferentInputs, 4, 5, 6
	call WriteInt
	call Crlf

	invoke DifferentInputs, 7, 7, 7
	call WriteInt
	call Crlf

	invoke DifferentInputs, 7, 8, 75
	call WriteInt
	call Crlf

	invoke DifferentInputs, 7, 8, 7
	call WriteInt
	call Crlf

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

END main