.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code

FindThrees PROC USES ebx ecx edx esi,
	arrayAddress:dword, arrayLength:dword
;-----------------------------------------------------------------------------
; Returns 1 in EAX if array has three consecutive values of 3, otherwise 0
; Receives: Address and size of array
;-----------------------------------------------------------------------------

	xor eax, eax
	mov ebx, arrayAddress
	mov ecx, arrayLength
	xor edx, edx
	xor esi, esi
	mov dl, 3

	examineArray:

		cmp [ebx + esi], dl
		je incrementThrees
		xor dh, dh
		add esi, 4
		loop examineArray
		jmp notFoundThree

		incrementThrees:
			
			inc dh
			cmp dh, dl
			jge foundThree

		add esi, 4
		loop examineArray

	jmp notFoundThree

	foundThree:
	mov eax, 1

	notFoundThree:
	ret

FindThrees ENDP

main PROC

	.data
	array1 dword 3, 4, 7, 3, 3, 3, 76, 900
	array2 dword 3, 4, 7, 3, 4, 3, 76, 900
	array3 dword 3, 3, 4, 7121, 3, 3, 3, 4, 3, 1176, 0, 5435, 2, 2, 3
	array4 dword 3, 4, 7, 3, 4, 3, 76, 900

	.code
	invoke FindThrees, offset array1, lengthof array1
	call WriteInt
	call	Crlf
	
	invoke FindThrees, offset array2, lengthof array2
	call WriteInt
	call	Crlf

	invoke FindThrees, offset array3, lengthof array3
	call WriteInt
	call	Crlf

	invoke FindThrees, offset array4, lengthof array4
	call WriteInt
	call	Crlf

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

END main