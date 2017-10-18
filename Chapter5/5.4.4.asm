.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
COUNT = 4
BlueTextOnGray = blue + (lightGray * 16)
DefaultColor = lightGray + (black * 16)

arrayD SDWORD 12345678h, 1A4B2000h, 3434h, 7AB9h
prompt BYTE "Enter a 32-bit signed integer: ",0

.code
main PROC
	mov		eax, BlueTextOnGray
	call	SetTextColor
	call	Clrscr

	mov		esi, OFFSET arrayD
	mov		ebx, TYPE arrayD
	mov		ecx, LENGTHOF arrayD
	call	DumpMem

	call	Crlf
	mov		ecx, COUNT

L1:
	mov		edx, OFFSET prompt
	call	WriteString
	call	ReadInt
	call	Crlf

	call	WriteInt
	call	Crlf

	call	WriteHex
	call	Crlf
	call	WriteBin
	call	Crlf
	call	Crlf

	loop	L1

	call	WaitMsg

	mov		eax, DefaultColor
	call	SetTextColor
	call	Clrscr

	INVOKE ExitProcess,0
main ENDP
END main