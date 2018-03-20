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
	testNum1_1 BYTE '87654321'

	.code
	mov ebx, 5
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

	pushad
	
	mov eax, ecx
	sub eax, ebx
	mov ebx, eax
	inc ebx

	inc ecx		; increase num length by one to account for decimal

	printNum:

		dec ebx
		jz printDec

		mov al, BYTE PTR [edx]
		call WriteChar
		inc edx
		loop printNum

		jmp exitWriteScaled

		printDec:

			mov al, '.'
			call WriteChar
			loop printNum

	exitWriteScaled:

	popad
	ret

WriteScaled ENDP

END main