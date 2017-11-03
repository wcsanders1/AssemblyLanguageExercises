.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
; the colors below are defined in the Irvine library
colors DWORD red, blue, green, yellow
prob1Str BYTE "This is a string for color testing ",0
counter DWORD 0

.code
main PROC

; 1.
	mov		ecx, [LENGTHOF colors - 1]
	mov		edx, OFFSET prob1Str
	mov		ebx, colors

colorLoop:
	mov		eax, [ebx + counter]
	call	SetTextColor
	mov		edx, OFFSET prob1Str
	call	WriteString
	add		ebx, 4
	mov		counter, ebx
	loop	colorLoop

	INVOKE ExitProcess,0
main ENDP
END main