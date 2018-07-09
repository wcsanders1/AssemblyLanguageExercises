.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code

SetColorXY PROC USES eax edx,
	color: byte, xPos:byte, yPos:byte
;-----------------------------------------------------------------------------
; Colors a space on the console
; Receives: X and Y coordinates and color
; Returns: Nothing
;-----------------------------------------------------------------------------

	local originalColor:byte

	call GetTextColor
	mov originalColor, al

	mov dh, yPos
	mov dl, xPos
	call Gotoxy

	movzx eax, color
	shl eax, 4
	call SetTextColor

	mov al, ' '
	call WriteChar

	movzx eax, originalColor
	call SetTextColor

	ret

SetColorXY ENDP

main PROC

	invoke SetColorXY, red, 20, 10

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

END main