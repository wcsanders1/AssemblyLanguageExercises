.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data

; for problem 1:
; the colors below are defined in the Irvine library
colors DWORD red, blue, green, yellow
prob1Str BYTE "This is a string for color testing ",0
counter DWORD 0

; for problem 2:
start DWORD 1h
chars BYTE "H", "A", "C", "E", "B", "D", "F", "G"
links DWORD 0h, 4h, 5h, 6h, 2h, 3h, 7h, 0h
sorted DWORD LENGTHOF links DUP (?)

.code
main PROC

; 1.
	mov		ecx, [LENGTHOF colors]
	mov		edx, OFFSET prob1Str
	mov		ebx, 0

colorLoop:
	mov		eax, [colors + ebx]
	call	SetTextColor
	mov		edx, OFFSET prob1Str
	call	WriteString
	call	Crlf
	add		ebx, 4
	mov		counter, ebx
	loop	colorLoop

	mov		eax, white
	call	SetTextColor

	call	Crlf

; 2.
	mov		eax, start
	mov		ebx, 0	
	mov		ecx, LENGTHOF links
	mov		edx, 0

sortLoop:
	movzx	edx, [chars + eax]
	mov		[sorted + ebx], edx
	inc		ebx
	mov		edx, [links + eax * 4]
	mov		eax, edx
	loop	sortLoop

	mov		edx, OFFSET sorted
	call	WriteString

	call	Crlf
	call	Crlf

	call	WaitMsg

	INVOKE ExitProcess,0
main ENDP
END main