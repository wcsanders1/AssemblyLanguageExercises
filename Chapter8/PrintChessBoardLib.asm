.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code

PrintLineAlternatingColors PROC PRIVATE USES eax ecx edx,
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

PrintChessBoard PROC USES eax ebx ecx,
	height: dword, wdth: dword, color1: byte, color2: byte

	local lineNumber: byte

	mov ecx, height
	mov al, 10d

	printBoard:

		mov lineNumber, al
		invoke PrintLineAlternatingColors, wdth, lineNumber, 50, color1, color2
		inc al
		mov bl, color1
		mov bh, color2
		mov color1, bh
		mov color2, bl
		loop printBoard

	ret

PrintChessBoard ENDP

;****************************************************************************
;****************************************************************************
;****************************************************************************

END