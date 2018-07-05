.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code

FindLargest PROC USES ebx ecx edx,
	array: ptr dword, arrayCount:dword
;-----------------------------------------------------------------------------
; Returns the largest value in a dword array
; Receives: Pointer to signed dword array and count of array length
; Returns: Largest value of array in EAX
;-----------------------------------------------------------------------------

	mov ecx, arrayCount
	mov edx, array
	xor eax, eax
	xor ebx, ebx

	findLargestLoop:

		cmp eax, [edx + ebx]
		jg notLarger
		mov eax, [edx + ebx]

		notLarger:
			add ebx, 4
			loop findLargestLoop

	ret

FindLargest ENDP


main PROC
; ---------------------------------- 1.

	.data
	array1 dword 30, 50, 1909, 12, 89, 40

	.code
	invoke FindLargest, offset array1, lengthof array1
	call WriteInt

; ******** END OF QUESTIONS **********

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

END main