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
firstChoiceMsg BYTE "1. x AND y",0
secondChoiceMsg BYTE "2. x OR y",0
thirdChoiceMsg BYTE "3. NOT x",0
fourthChoiceMsg BYTE "4. x XOR y",0
fifthChoiceMsg BYTE "5. EXITM program",0

; for problems 5, 6:
CaseTable BYTE "1"
		  DWORD xANDy
EntrySize = ($ - CaseTable)
		  BYTE "2"
		  DWORD xORy
		  BYTE "3"
		  DWORD NOTx
		  BYTE "4"
		  DWORD xXORy
		  BYTE "5"
		  DWORD exitProgram
NumberOfEntries = ($ - CaseTable) / EntrySize
chooseProcMsg BYTE "Choose from one of the following choices: ",0
oneHexMsg BYTE "Enter one hexadecimal integer: ",0
twoHexMsg BYTE "Enter two hexadecimal integers: ",0
firstHex DWORD ?
secondHex DWORD ?

; for problem 7:
textColor DWORD ?
colorMsg BYTE "This is a message about text color.",0

; for problem 8:
key BYTE "ABXmv#7",0
BUFMAX = 128
stringPrompt BYTE "Enter some text to encrypt: ",0
encryptMsg BYTE "Cipher text: ",0
decryptMsg BYTE "Decrpyted text: ",0
buffer BYTE BUFMAX + 1 DUP(0)
bufSize DWORD ?

; for problem 9:
testPINOne BYTE 5, 4, 7, 3, 4
testPINTwo BYTE 3, 2, 8, 3, 5
testPINThree BYTE 7, 1, 9, 4, 5
testPINFour BYTE 9, 2, 10d, 2, 6
testPINFive BYTE 9, 5, 8, 5, 5, 1
testPINSix BYTE 5, 2, 4, 1, 9

; for problem 10:
testParityOne BYTE 00001111b, 11110000b, 10101010b, 00000000b,	; this array has an even nuber of bits
				   11111111b, 11111000b, 00011111b, 01010101b,
				   11001100b, 00110011b, 11100010b, 11011101b

testParityTwo BYTE 10001111b, 11110000b, 10101010b, 00000000b,   ; this array has an odd nuber of bits
				   11111111b, 11111000b, 00011111b, 01010101b,
				   11001100b, 00110011b, 11100010b, 00011101b

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
		call Crlf

; ---------------------------------- 5, 6.

	mov edx, OFFSET chooseProcMsg
	call WriteString
	call Crlf
	
	mov edx, OFFSET firstChoiceMsg
	call WriteString
	call Crlf
	
	mov edx, OFFSET secondChoiceMsg
	call WriteString
	call Crlf

	mov edx, OFFSET thirdChoiceMsg
	call WriteString
	call Crlf

	mov edx, OFFSET fourthChoiceMsg
	call WriteString
	call Crlf

	mov edx, OFFSET fifthChoiceMsg
	call WriteString
	call Crlf

	call ReadChar
	mov ebx, OFFSET CaseTable
	mov ecx, NumberOfEntries

	IterateCaseTable:
		cmp al, [ebx]
		jne NotEqual
		call NEAR PTR [ebx + 1]
		call Crlf
		jmp Exit5and6
		
		NotEqual:
			add ebx, EntrySize
			loop IterateCaseTable

	Exit5and6:

; ---------------------------------- 7.

	mov ecx, 10

	PrintColorMsg:
		mov eax, 10d
		call RandomRange
	
		cmp eax, 2d
		jbe SetTextColorWhite
	
		cmp eax, 3
		je SetTextColorBlue
	
		mov eax, green
		call SetTextColor
		jmp PrintMsg

		SetTextColorWhite:
			mov eax, white    ; white is defined in the Irvine library
			call SetTextColor
			jmp PrintMsg

		SetTextColorBlue:
			mov eax, blue
			call SetTextColor
			jmp PrintMsg

		PrintMsg:
			mov edx, OFFSET colorMsg
			call WriteString
			call Crlf

		loop PrintColorMsg

; ---------------------------------- 8.

	call Crlf
	call inputTheString
	call translateBuffer
	mov edx, OFFSET encryptMsg
	call displayMessage
	call translateBuffer
	mov edx, OFFSET decryptMsg
	call displayMessage
	call Crlf

; ---------------------------------- 9.

	mov edx, OFFSET testPINOne
	call validatePIN
	call WriteDec
	call Crlf

	mov edx, OFFSET testPINTwo
	call validatePIN
	call WriteDec
	call Crlf

	mov edx, OFFSET testPINThree
	call validatePIN
	call WriteDec
	call Crlf

	mov edx, OFFSET testPINFour
	call validatePIN
	call WriteDec
	call Crlf

	mov edx, OFFSET testPINFive
	call validatePIN
	call WriteDec
	call Crlf

	mov edx, OFFSET testPINSix
	call validatePIN
	call WriteDec
	call Crlf
	call Crlf

; ---------------------------------- 10.

	mov edx, OFFSET testParityOne
	mov ecx, LENGTHOF testParityOne
	call determineParity
	call WriteDec
	call Crlf

	mov edx, OFFSET testParityTwo
	mov ecx, LENGTHOF testParityTwo
	call determineParity
	call WriteDec
	call Crlf

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

;*****************************************************************************
;*****************************************************************************

xANDy PROC

	mov edx, OFFSET twoHexMsg
	call WriteString
	call Crlf
	call ReadInt
	mov firstHex, eax
	call ReadInt
	call Crlf
	and eax, firstHex
	call WriteHex
	call Crlf
	ret

xANDy ENDP

xORy PROC
	
	mov edx, OFFSET twoHexMsg
	call WriteString
	call Crlf
	call ReadInt
	mov firstHex, eax
	call ReadInt
	call Crlf
	or eax, firstHex
	call WriteHex
	call Crlf
	ret

xORy ENDP

NOTx PROC

	mov edx, OFFSET oneHexMsg
	call WriteString
	call Crlf
	call ReadInt	
	not eax
	call WriteHex
	call Crlf
	ret

NOTx ENDP

xXORy PROC

	mov edx, OFFSET twoHexMsg
	call WriteString
	call Crlf
	call ReadInt
	mov firstHex, eax
	call ReadInt
	call Crlf
	xor eax, firstHex
	call WriteHex
	call Crlf
	ret

xXORy ENDP

exitProgram PROC

	mov edx, OFFSET fifthChoiceMsg
	ret

exitProgram ENDP

;*****************************************************************************
;*****************************************************************************

inputTheString PROC
;-----------------------------------------------------------------------------
; Prompts the user for text, and saves the string and its length
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------------------------------

	pushad
	mov edx, OFFSET stringPrompt
	call WriteString
	mov ecx, BUFMAX
	mov edx, OFFSET buffer
	call ReadString
	mov bufSize, eax
	call Crlf
	popad
	ret

inputTheString ENDP

displayMessage PROC
;-----------------------------------------------------------------------------
; Displays an encrypted or decrypted message
; Receives: EDX = the message to display
; Returns: nothing
;-----------------------------------------------------------------------------

	pushad
	call WriteString
	mov edx, OFFSET buffer
	call WriteString
	call Crlf
	call Crlf
	popad
	ret

displayMessage ENDP

;*****************************************************************************
;*****************************************************************************


translateBuffer PROC
;-----------------------------------------------------------------------------
; Translates a string by XORing each byte with the the key
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------------------------------

	.data
	keySize DWORD SIZEOF key - 1

	.code
	pushad
	mov ecx, bufSize
	mov esi, 0
	mov ebx, -1

	Translate:
		cmp ebx, keySize
		jl IncrementKeyIndex
		mov ebx, -1

		IncrementKeyIndex:
			inc ebx

		mov al, [key + ebx]
		xor buffer[esi], al
		inc	esi
		loop Translate

	popad
	ret

translateBuffer ENDP

;*****************************************************************************
;*****************************************************************************

validatePIN PROC
;-----------------------------------------------------------------------------
; Validates whether a 5-digit PIN is valid
; Receives: EDX = pointer to byte array containing the 5-digit PIN
; Returns: EAX = 0 if PIN is valid, or the position of the first invalid
;				 digit
;-----------------------------------------------------------------------------

	.data
	minValidDigits BYTE 5, 2, 4, 1, 3
	maxValidDigits BYTE 9, 5, 8, 4, 6
	validNum DWORD 0
	pinLength = LENGTHOF minValidDigits

	.code
	pushad
	mov ecx, pinLength
	mov ebx, 0

	CheckValidity:
		mov al, [edx + ebx]
		cmp al, [minValidDigits + ebx]
		jl Invalid
		
		cmp al, [maxValidDigits + ebx]
		jg Invalid
		
		inc ebx
		loop CheckValidity
		jmp EndValidation

	Invalid:
		inc ebx
		mov validNum, ebx

	EndValidation:
	popad
	mov eax, validNum
	ret

validatePIN ENDP

;*****************************************************************************
;*****************************************************************************

determineParity PROC
;-----------------------------------------------------------------------------
; Determines whether the total number of bits in a byte array is even or odd
; Receives: EDX = pointer to byte array
;			ECX = length of the array			
; Returns: EAX = 0 if the array is odd, or 1 if even
;-----------------------------------------------------------------------------

	.data
	hasParity DWORD 0
	
	.code
	pushad
	mov hasParity, 0
	dec ecx
	mov eax, 0
	mov bl, [edx]

	GetParity:
		pushf
		inc eax
		popf
		xor bl, [edx + eax]
		loop GetParity
	
	jpo FinishParity
	mov hasParity, 1

	FinishParity:
	popad
	mov eax, hasParity
	ret

determineParity ENDP

END main