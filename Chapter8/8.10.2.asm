.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code
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

; ---------------------------------- 9.

	.data
	test_char_9 dword "r"
	test_background_color_9 dword green
	test_foreground_color_9 dword blue

	.code
	push test_char_9
	push test_background_color_9
	push test_foreground_color_9
	call WriteColorChar

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

;-----------------------------------------------------------------------------
WriteColorChar PROC
;-----------------------------------------------------------------------------
; Displays single character with color
; Receives: Character, foreground color, and background color on stack
; Returns: Nothing
;-----------------------------------------------------------------------------

	local character: byte,
		  foregroundColor2: byte,
		  backgroundColor2: byte
	
	ret

WriteColorChar ENDP
END main