.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code

ColorXY PROC USES eax ebx edx,
	backgroundColor: byte, xPos:byte, yPos:byte

	mov dh, yPos
	mov dl, xPos
	call Gotoxy

	mov eax, white
	shl eax, 4
	add al, backgroundColor
	call SetTextColor

	mov al, ' '
	call WriteChar

	ret

ColorXY ENDP

main PROC

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

END main