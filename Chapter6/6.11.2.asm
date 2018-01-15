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
sumMessage BYTE "Here is the sum of that array: ",0

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
	inc k

	mov eax, OFFSET fillArray
	mov ebx, j
	mov ecx, k
	mov edx, LENGTHOF fillArray
	call createRandomArray

	mov ecx, LENGTHOF fillArray
	mov eax, OFFSET fillArray
	call writeArray

; ---------------------------------- 2.
	
	mov edx, OFFSET sumMessage
	call Crlf
	call WriteString
	call sumArray
	call WriteDec
	call Crlf

; ---------------------------------- 3.



; ---------------------------------- END
	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0
main ENDP

;*****************************************************************************
;*****************************************************************************

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

;*****************************************************************************
;*****************************************************************************

writeArray PROC
;-----------------------------------------------------------------------------
; Writes the elements of a DWORD array to the console
; Receives: EAX = pointer to array to write
;			ECX = length of array to write
; Returns: nothing
;-----------------------------------------------------------------------------

	.data
	arrayToWriteAddress DWORD ?

	.code
	mov arrayToWriteAddress, eax
	pushad

	mov ebx, 0
	mov edx, arrayToWriteAddress

	WriteArrayLoop:

		mov eax, [edx + ebx]
		call WriteDec
		call Crlf
		add ebx, SIZEOF DWORD
		loop WriteArrayLoop

	popad
	ret
writeArray ENDP

;*****************************************************************************
;*****************************************************************************

sumArray PROC
;-----------------------------------------------------------------------------
; Sums the elements of a DWORD array of integers
; Receives: EAX = pointer to array to sum
;			ECX = length of array to sum
; Returns: EAX = sum of the elements of the array
;-----------------------------------------------------------------------------

	.data
	arrayToSumAddress DWORD ?
	arraySum DWORD 0h

	.code
	mov arrayToSumAddress, eax
	pushad

	xor eax, eax
	xor ebx, ebx
	mov edx, arrayToSumAddress

	SumArrayLoop:

		add eax, [edx + ebx]
		add ebx, SIZEOF DWORD
		loop SumArrayLoop

	mov arraySum, eax
	popad
	mov eax, arraySum
	ret
sumArray ENDP

;*****************************************************************************
;*****************************************************************************

calcGrade PROC
;-----------------------------------------------------------------------------
; Returns a letter grade based on a number
; Receives: EAX = number to convert to grade
; Returns: AL = letter grade corresponding to the number passed in
;-----------------------------------------------------------------------------

	.data
	numberGrade DWORD ?
	letterGrade BYTE ?

	.code
	mov numberGrade, eax
	pushad

	popad
	mov al, letterGrade
	ret
calcGrade ENDP

END main