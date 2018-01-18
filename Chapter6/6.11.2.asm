.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
TRUE = 1
FALSE = 0

; for problem 1:
N equ 10d
fillArray DWORD N DUP (?)
j DWORD ?
k DWORD ?
askForJ BYTE "Enter the lower bound for the range of random numbers: ",0
askForK BYTE "Enter the upper bound for the range of random numbers: ",0

; for problem 2:
sumMessage BYTE "Here is the sum of that array: ",0

; for problem 3:
colon BYTE ": ",0
grade BYTE ?

; for problem 4:
gradeAverage WORD ?
credits WORD ?
okToRegister BYTE ?
askForGradeAverage BYTE "What is your grade average? ",0
askForCredits BYTE "How many credits do you have? ",0
invalidCreditsMsg BYTE "You must have between 1 and 30 credits.",0
canRegisterMsg BYTE "You can register.",0
cannotRegisterMsg BYTE "You cannot register.",0

; for problem 5:
firstChoice BYTE "1. x AND y",0
secondChoice BYTE "2. x OR y",0
thirdChoice BYTE "3. NOT x",0
fourthChoice BYTE "4. x XOR y",0
fifthChoice BYTE "5. EXITM program",0

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

	mov ecx, 10d
	call Crlf

	GetGrades:
		mov eax, 50d
		call RandomRange
		add eax, 50
		call WriteDec
		mov edx, OFFSET colon
		call WriteString
		call calcGrade
		mov grade, al
		mov edx, OFFSET grade
		call WriteString
		call Crlf		
		loop GetGrades

; ---------------------------------- 4.

	mov edx, OFFSET askForGradeAverage
	call WriteString
	call Crlf
	call ReadDec
	mov gradeAverage, ax
	
	mov edx, OFFSET askForCredits
	call WriteString
	call Crlf
	call ReadDec
	cmp eax, 1
	jb CreditsInvalid
	cmp eax, 30
	ja CreditsInvalid
	jmp CreditsValid

	CreditsInvalid:
		mov edx, OFFSET invalidCreditsMsg
		call WriteString
		jmp Exit4

	CreditsValid:
		mov credits, ax

		mov okToRegister, FALSE
		mov ax, gradeAverage
		mov bx, credits

		cmp ax, 350d
		jg CanRegister

		cmp bx, 12d
		jle CanRegister

		cmp ax, 250d
		jle Finish4

		cmp bx, 16d
		jg Finish4

		CanRegister:
			mov okToRegister, TRUE

		Finish4:
			mov edx, OFFSET cannotRegisterMsg
			mov al, okToRegister
			cmp al, 0
			jg MakeCanRegisterMsg
			jmp ReallyFinish4

		MakeCanRegisterMsg:
			mov edx, OFFSET canRegisterMsg

		ReallyFinish4:
			call Crlf
			call WriteString

	Exit4:

; ---------------------------------- 5.



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
	mov eax, numberGrade

	mov letterGrade, "A"
	cmp eax, 90d
	jge ExitProc

	mov letterGrade, "B"
	cmp eax, 80d
	jge ExitProc

	mov letterGrade, "C"
	cmp eax, 70d
	jge ExitProc

	mov letterGrade, "D"
	cmp eax, 60d
	jge ExitProc

	mov letterGrade, "F"

	ExitProc:
		popad
		mov al, letterGrade
		ret
calcGrade ENDP

END main