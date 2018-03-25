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

; ---------------------------------- 2.

	.data
	testArray1A_2 BYTE 99h, 88h, 77h, 66h, 55h, 44h, 33h, 22h, 99h, 88h, 77h, 66h, 55h, 44h, 33h, 22h
	testArray1B_2 BYTE 22h, 33h, 44h, 55h, 66h, 77h, 88h, 99h, 22h, 33h, 44h, 55h, 66h, 77h, 88h, 99h
	result_2 BYTE LENGTHOF testArray1A_2 DUP(0)

	.code
	mov esi, OFFSET testArray1A_2
	mov edi, OFFSET testArray1B_2
	mov ecx, LENGTHOF testArray1A_2
	mov ebx, OFFSET result_2
	call ExtendedSub
	call Crlf

	mov esi, OFFSET result_2
	mov ecx, LENGTHOF testArray1A_2
	call DisplaySubResult
	call Crlf

; ---------------------------------- 3.

	.data
	result_3 byte sizeof dword dup(0)

	.code
	mov eax, 2890873615d
	mov esi, offset result_3
	call PackedToAsc
	mov edx, offset result_3
	call WriteString
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

;***********************************************************************

ExtendedSub PROC
;-----------------------------------------------------------------------------
; Calculates the result of subtracting two extended integers stored as
; arrays of bytes.
; Receives: ESI and EDI point to the two integers
;			EBX points to a variable that will hold the result
;			ECX holds the length of the arrays (the length of both arrays
;				must be the same)
; Returns: nothing
;-----------------------------------------------------------------------------

	pushad
	clc

	extendedSub_Loop:

		mov al, [esi]
		sbb al, [edi]
		pushfd
		mov [ebx], al
		inc esi
		inc edi
		inc ebx
		popfd
		loop extendedSub_Loop

	popad
	ret

ExtendedSub ENDP

DisplaySubResult PROC
;-----------------------------------------------------------------------------
; Displays sum of extended add/sub in correct order
; Receives: ESI points to the var that holds the value to display
;			ECX holds the length of the value to display
; Returns: nothing
;-----------------------------------------------------------------------------

	pushad
	xor eax, eax

	displaySum_Loop:
		
		mov al, [esi]
		mov ebx, TYPE BYTE
		call WriteHexB
		add esi, TYPE BYTE
		loop displaySum_Loop

	popad
	ret

DisplaySubResult ENDP

PackedToAsc PROC
;-----------------------------------------------------------------------------
; Converts 4-byte packed decimal int to string of ASCII decimal digits
; Receives: ESI points to the var that holds the ASCII string
;			EAX contains the packed integer			
; Returns: nothing
;-----------------------------------------------------------------------------

	.data
	num_3 dword ?
	
	.code
	pushad
	mov num_3, eax
	mov ecx, lengthof num_3
	xor edi, edi
	
	packedToAsc_Loop:
		mov al,17d
		aam
		or ax, 3030h
		loop packedToAsc_Loop
	
	popad
	ret

PackedToAsc ENDP

END main