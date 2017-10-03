.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
; for question 1:
bigEndian BYTE 12h, 34h, 56h, 78h
littleEndian DWORD ?

; for question 2:
trading BYTE 1h, 2h, 3h, 4h, 5h, 6h

.code
main PROC
; 1.
	mov al, bigEndian
	mov ah, bigEndian + 1
	mov bl, bigEndian + 2
	mov bh, bigEndian + 3

	mov BYTE PTR littleEndian, bh
	mov BYTE PTR littleEndian + 1, bl
	mov BYTE PTR littleEndian + 2, ah
	mov BYTE PTR littleEndian + 3, al

; 2.
	mov	esi, 0
	mov ecx, [LENGTHOF trading / 2]

trade:
	mov al, [trading + esi]
	inc esi
	xchg al, [trading + esi]
	dec esi
	mov [trading + esi], al
	add esi, 2
loop trade

	INVOKE ExitProcess,0
main ENDP
END main