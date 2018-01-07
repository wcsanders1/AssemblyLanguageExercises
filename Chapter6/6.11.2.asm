.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data

; for problem 1:
N equ 10d
fillArray DWORD N DUP (?)
j DWORD ?
k DWORD ?
askForJ BYTE "Enter the lower bound for the range of random numbers: ",0
askForK BYTE "Enter the upper bound for the range of random numbers: ",0

.code
main PROC
	
; ---------------------------------- 1.

	mov edx, OFFSET askForJ
	call WriteString
	call ReadDec
	mov j, eax

	mov edx, OFFSET askForK
	call WriteString
	call ReadDec
	mov k, eax

	mov eax, OFFSET fillArray
	mov ebx, j
	mov ecx, k
	mov edx, LENGTHOF fillArray
	call createRandomArray

	mov ecx, LENGTHOF fillArray
	mov ebx, 0

	WriteArray:

		mov eax, [fillArray + ebx]
		call WriteDec
		call Crlf
		add ebx, SIZEOF DWORD
		loop WriteArray

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0
main ENDP

createRandomArray PROC
;-----------------------------------------------------------------------------
; Fills an array with random numbers within a specified range
; Receives: EAX = pointer to array to fill
;			EBX = lower bound of random number range
;			ECX = upper bound of random number range
;			EDX = length of array
; Returns: nothing
;-----------------------------------------------------------------------------

	.data
	arrayAddress DWORD ?
	lowerBound DWORD ?
	upperBound DWORD ?
	arrayLength DWORD ?
	difference DWORD ?

	.code
	mov arrayAddress, eax
	mov lowerBound, ebx
	mov upperBound, ecx
	mov arrayLength, edx
	pushad

	mov eax, upperBound
	sub eax, lowerBound
	mov difference, eax
	mov ecx, arrayLength
	mov ebx, 0
	mov edx, arrayAddress

	CreateArray:

		mov eax, difference
		call RandomRange
		add eax, lowerBound
		mov [edx + ebx], eax
		add ebx, SIZEOF DWORD
		loop CreateArray

	popad
	ret
createRandomArray ENDP

END main