.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code

WriteColorChar PROC USES eax,
	character:byte, foregroundColor2:byte, backgroundColor2:byte
;-----------------------------------------------------------------------------
; Displays single character with color
; Receives: Character, foreground color, and background color on stack
; Returns: Nothing
;-----------------------------------------------------------------------------

	movzx eax, foregroundColor2
	shl eax, 4
	add al, backgroundColor2
	call SetTextColor
	mov al, character
	call WriteChar
	
	ret

WriteColorChar ENDP

DumpMemory PROC USES esi ecx ebx,
	arrayAddress:dword, arrayLength:dword, arrayType:dword
;-----------------------------------------------------------------------------
; Writes a range of memory to the console
; Receives: Range of memory, range length, range type
; Returns: Nothing
;-----------------------------------------------------------------------------

	mov esi, arrayAddress
	mov ecx, arrayLength
	mov ebx, arrayType
	call DumpMem

	ret

DumpMemory ENDP

MultArray PROC USES esi ebx ecx,
	arrayOne:ptr dword, arrayTwo:ptr dword, arrayCount:dword
;-----------------------------------------------------------------------------
; This procedure doesn't do anything
; Receives: Two pointers to arrays of dwords and the count of each array
; Returns: Nothing
;-----------------------------------------------------------------------------

	mov esi, arrayOne
	mov ebx, arrayTwo
	mov ecx, arrayCount

	ret

MultArray ENDP

MultArray PROTO,
	arrayOne:ptr dword,
	arrayTwo:ptr dword,
	arrayCount:dword

main PROC

; ---------------------------------- 2.
	.data
	num1_question2 DWORD 5
	num2_question2 DWORD 10
	num3_question2 DWORD 15

	.code
	push num1_question2
	push num2_question2
	push num3_question2
	call AddThree
	call WriteInt
	call Crlf

; ---------------------------------- 3-7.
	
	call LocalVarExercises

; ---------------------------------- 8.

	.data
	test_string_8 byte "This is a test.",0

	.code
	mov eax, 7
	push yellow
	push red
	call SetColor
	mov edx, offset test_string_8
	call WriteString
	call Crlf
; ---------------------------------- 9.

	.data
	test_char_9 byte "r",0
	test_foreground_color_9 byte green
	test_background_color_9 byte red

	.code
	invoke WriteColorChar, test_char_9, test_foreground_color_9, test_background_color_9

; ---------------------------------- 10.

	.data
	array9 dword 1,2,3,4,5,6,7,8,9,0Ah,0Bh

	.code
	invoke DumpMemory, offset array9, lengthof array9, type array9

; ---------------------------------- 11.

	.data
	array1_11 dword 10, 20, 30, 40
	array2_11 dword 90, 80, 70, 60

	.code
	invoke MultArray, offset array1_11, offset array2_11, lengthof array1_11

; ******** END OF QUESTIONS **********

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP


;-----------------------------------------------------------------------------
AddThree PROC
;-----------------------------------------------------------------------------
; Calculates sum of three integers
; Receives: Three integers on stack
; Returns: Sum in EAX
;-----------------------------------------------------------------------------
	
	num1_AddThree equ [ebp + 16]
	num2_AddThree equ [ebp + 12]
	num3_AddThree equ [ebp + 8]

	push ebp
	mov ebp, esp
	mov eax, num1_AddThree
	add eax, num2_AddThree
	add eax, num3_AddThree
	pop ebp
	ret

AddThree ENDP
;-----------------------------------------------------------------------------

;*****************************************************************************

;-----------------------------------------------------------------------------
LocalVarExercises PROC
;-----------------------------------------------------------------------------
; Contains local variable declarations related to questions 3 through 7
;-----------------------------------------------------------------------------

	local pArray: ptr dword,
		  buffer[20]: byte,
		  pwArray: ptr word,
		  myByte: byte,
		  myArray[20]: dword

	ret

LocalVarExercises ENDP
;-----------------------------------------------------------------------------

;*****************************************************************************

;-----------------------------------------------------------------------------
SetColor PROC
;-----------------------------------------------------------------------------
; Sets the foreground and background colors of the console
; Receives: Foreground and background colors on the stack
; Returns: Nothing
;-----------------------------------------------------------------------------
	
	backgroundColor equ [ebp+12]
	foregroundColor equ [ebp+8]

	push ebp
	mov ebp, esp
	
	mov eax, foregroundColor
	mov ebx, 16
	mul ebx
	add eax, backgroundColor
	call SetTextColor
	pop ebp
	ret

SetColor ENDP
;-----------------------------------------------------------------------------

;*****************************************************************************


END main