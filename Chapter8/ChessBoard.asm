.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code

;*****************************************************************************
;*****************************************************************************
;*****************************************************************************

SetColorXY PROC USES eax edx,
	color: byte, xPos: byte, yPos: byte
;-----------------------------------------------------------------------------
; Colors a space on the console
; Receives: X and Y coordinates and color
; Returns: Nothing
;-----------------------------------------------------------------------------

	local originalColor: byte

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

;*****************************************************************************
;*****************************************************************************
;*****************************************************************************

PrintLineAlternatingColors PROC USES eax ecx edx,
	lineLength: dword, yPos: byte, xPos: byte, color1: byte, color2: byte
;-----------------------------------------------------------------------------
; Makes a line on the console with alternating colors
; Receives: line length, y position, two colors
; Returns: Nothing
;-----------------------------------------------------------------------------
	
	local currentColor: byte,
		  originalColor: byte

	call GetTextColor
	mov originalColor, al

	mov dh, yPos
	mov dl, xPos
	mov ecx, lineLength
	xor eax, eax
	movzx eax, color1
	mov currentColor, al

	colorSpace:
		
		call Gotoxy
		shl eax, 4
		call SetTextColor
		mov al, ' '
		call WriteChar
		inc dl

		mov al, currentColor
		cmp al, color1
		je changeToColor2
		
		movzx eax, color1
		mov currentColor, al
		cmp ecx, 0
		jle exitPrintLineAlternatingColors
		loop colorSpace

		changeToColor2:

			movzx eax, color2
			mov currentColor, al
			cmp ecx, 0
			jle exitPrintLineAlternatingColors
			loop colorSpace
	
	exitPrintLineAlternatingColors:

	movzx eax, originalColor
	call SetTextColor

	ret

PrintLineAlternatingColors ENDP

;****************************************************************************
;****************************************************************************
;****************************************************************************

PrintChessBoard PROC USES eax,
	height: dword, wdth: dword, color1: byte, color2: byte

	ret

PrintChessBoard ENDP

;****************************************************************************
;****************************************************************************
;****************************************************************************

main PROC

	invoke PrintLineAlternatingColors, 10, 10, 0, red, green

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

END main