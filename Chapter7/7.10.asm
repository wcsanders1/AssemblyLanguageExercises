.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data

.code
main PROC

; ---------------------------------- 1.
	
	.data
	testNum1_1 BYTE '4321'

	.code
	mov ecx, LENGTHOF testNum1_1
	mov edx, OFFSET testNum1_1
	call WriteScaled
	call Crlf

; ******** END OF QUESTIONS **********	

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

WriteScaled PROC
;-----------------------------------------------------------------------------
; Outputs a decimal; ASCII number with an implied decimal point
; Receives: EBX = decimal offset
;			ECX = number length
;			EDX = number's offset
; Returns: nothing
;-----------------------------------------------------------------------------

	.data
	num_offset DWORD 0
	num_length DWORD 0
	decimal_offset DWORD 0
	cur_pos DWORD 0

	.code
	mov decimal_offset, ebx
	mov num_length, ecx
	mov num_offset, edx
	pushad

	mov edx, num_offset
	add edx, num_length
	mov cur_pos, edx
	mov ebx, 0
	mov ecx, num_length

	printNum:

		mov al, BYTE PTR [cur_pos + ebx]
		call WriteChar
		inc ebx
		loop printNum

	popad
	ret

WriteScaled ENDP

END main