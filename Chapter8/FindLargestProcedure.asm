.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code

FindLargest PROC USES ebx ecx,
	array:ptr dword, arrayCount:dword
;-----------------------------------------------------------------------------
; Returns the largest value in a dword array
; Receives: Pointer to signed dword array and count of array length
; Returns: Largest value of array in EAX
;-----------------------------------------------------------------------------

	mov ecx, arrayCount
	xor eax, eax
	xor ebx, ebx

	findLargestLoop:

		cmp eax, array[ebx]
		jl notLarger
		mov eax, array[ebx]

		notLarger:
			add ebx, 4
			loop findLargestLoop

	ret

FindLargest ENDP


main PROC
; ---------------------------------- 1.


; ******** END OF QUESTIONS **********

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

END main