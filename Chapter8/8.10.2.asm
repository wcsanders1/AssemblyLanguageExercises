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

END main