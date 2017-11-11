.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data

; for problem 1:
; the colors below are defined in the Irvine library
colors DWORD red, blue, green, yellow
prob1Str BYTE "This is a string for color testing ",0
counter DWORD 0

; for problem 2:
start DWORD 1h
chars BYTE "H", "A", "C", "E", "B", "D", "F", "G"
links DWORD 0h, 4h, 5h, 6h, 2h, 3h, 7h, 0h
sorted DWORD LENGTHOF links DUP (?)

; for problem 3:
askForInt1 BYTE "Enter the first integer to add: ",0
askForInt2 BYTE "Enter the second integer to add: ",0
answerStr BYTE "The sum of those two numbers is: ",0

; for problem 5:
askForRnd1 BYTE "Enter the lower bound for a random integer: ",0
askForRnd2 BYTE "Enter the upper bound for a random integer: ",0
lowerBound DWORD ?
upperBound DWORD ?
difference DWORD ?

; for problem 6:
askForRndStrLngth BYTE "Enter the length for a random string (enter no more than ten): ",0
rndChar DWORD ?
rndStrArray BYTE 10 DUP (?)
wrdLength DWORD ?

; for problem 7:
bufferColumns DWORD ?
bufferRows DWORD ?
rndXPos DWORD ?
rndYPos DWORD ?

.code
main PROC

; ---------------------------------- 1.
	mov		ecx, [LENGTHOF colors]
	mov		edx, OFFSET prob1Str
	mov		ebx, 0

colorLoop:
	mov		eax, [colors + ebx]
	call	SetTextColor
	mov		edx, OFFSET prob1Str
	call	WriteString
	call	Crlf
	add		ebx, 4
	mov		counter, ebx
	loop	colorLoop

	mov		eax, white
	call	SetTextColor

	call	Crlf

; ---------------------------------- 2.
	mov		eax, start
	mov		ebx, 0	
	mov		ecx, LENGTHOF links
	mov		edx, 0

sortLoop:
	movzx	edx, [chars + eax]
	mov		[sorted + ebx], edx
	inc		ebx
	mov		edx, [links + eax * 4]
	mov		eax, edx
	loop	sortLoop

	mov		edx, OFFSET sorted
	call	WriteString

	call	Crlf
	call	Crlf

; ---------------------------------- 3.
	call	addTwoInts

; ---------------------------------- 4.
	mov		ecx, 2

addTwoNums:
	call	addTwoInts
	loop	addTwoNums
	
; ---------------------------------- 5.
	mov		edx, OFFSET askForRnd1
	call	WriteString
	call	ReadDec
	mov		lowerBound, eax
	mov		edx, OFFSET askForRnd2
	call	WriteString
	call	ReadDec
	mov		upperBound, eax
	mov		edx, upperBound
	sub		edx, lowerBound
	mov		difference, edx
	mov		ecx, 49

getRnd:
	call	betterRandomRange
	loop	getRnd
	call	Crlf

; ---------------------------------- 6.
	mov		ecx, 20
	mov		edx, OFFSET askForRndStrLngth
	call	WriteString
	call	ReadDec
	mov		wrdLength, eax
rndString:
	push	ecx
	call	generateRandomString
	pop		ecx
	loop	rndString

; ---------------------------------- 7.
	mov		eax, 0
	call	GetMaxXY
	mov		ebx, 0
	movzx	ebx, dl
	mov		bufferColumns, ebx
	mov		ebx, 0
	movzx	ebx, al
	mov		bufferRows, ebx
	mov		ecx, 100

rndCharLoop:
	call	putRndXYPos
	mov		eax, 100
	call	Delay
	loop	rndCharLoop

; ---------------------------------- END
	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0
main ENDP

;*****************************************************************************
;		PROCEDURES
;*****************************************************************************

addTwoInts PROC
	mov		edx, OFFSET askForInt1
	call	WriteString
	call	ReadDec
	mov		ebx, eax
	mov		edx, OFFSET askForInt2
	call	WriteString
	call	ReadDec
	mov		edx, OFFSET answerStr
	call	WriteString
	add		eax, ebx
	call	WriteDec
	call	Crlf
	call	Crlf

	ret
addTwoInts ENDP

betterRandomRange PROC
	mov		eax, difference
	call	RandomRange
	add		eax, lowerBound
	call	WriteDec
	call	Crlf

	ret
betterRandomRange ENDP

betterRandomRangeNoPrint PROC
	mov		eax, difference
	call	RandomRange
	add		eax, lowerBound

	ret
betterRandomRangeNoPrint ENDP

generateRandomString PROC
	mov		ecx, wrdLength
	mov		ebx, 0

generateLoop:
	mov		lowerBound, 41h
	mov		upperBound, 5Ah
	mov		edx, upperBound
	sub		edx, lowerBound
	mov		difference, edx
	call	betterRandomRangeNoPrint
	mov		rndChar, eax
	mov		al, BYTE PTR rndChar
	mov		[rndStrArray + ebx], al
	inc		ebx
	loop	generateLoop
	mov		edx, OFFSET rndStrArray
	call	WriteString
	call	Crlf

	ret
generateRandomString ENDP

putRndXYPos PROC
	mov		eax, 0
	mov		eax, bufferRows
	call	RandomRange
	mov		rndXPos, eax
	mov		dh, BYTE PTR rndXPos
	mov		eax, 0
	mov		eax, bufferColumns
	call	RandomRange
	mov		rndYPos, eax
	mov		dl, BYTE PTR rndYPos
	call	Gotoxy
	mov		al, 'A'
	call	WriteChar

	ret
putRndXYPos ENDP

END main