.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code

FindThrees PROC USES ebx ecx edx esi,
	arrayAddress:dword, arrayLength:dword
;-----------------------------------------------------------------------------
; Returns 1 if array has three consecutive values of 3, otherwise 0
; Receives: Address and size of array
;-----------------------------------------------------------------------------

	mov ebx, arrayAddress
	mov ecx, arrayLength
	xor edx, edx
	xor esi, esi
	mov dl, 3

	examineArray:

		cmp [ebx + esi], dl
		je incrementThrees

		incrementThrees:
			
			inc dh
			

FindThrees ENDP

main PROC


	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

END main