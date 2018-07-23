.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.code

PrintChessBoard PROTO,
	height: dword, wdth: dword, color1: byte, color2: byte

main PROC

	invoke PrintChessBoard, 8, 8, gray, white
	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

END main