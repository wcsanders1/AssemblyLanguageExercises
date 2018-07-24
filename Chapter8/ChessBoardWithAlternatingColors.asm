.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code

PrintChessBoard PROTO,
	height: dword, wdth: dword, color1: byte, color2: byte

main PROC

	mov ecx, 16d
	mov eax, 500d
	xor bl, bl
	
	renderBoard:

		invoke PrintChessBoard, 8, 8, bl, white
		call Delay
		inc bl
		loop renderBoard

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

END main