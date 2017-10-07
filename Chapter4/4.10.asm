.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
; for question 1:
bigEndian BYTE 12h, 34h, 56h, 78h
littleEndian DWORD ?

; for question 2:
trading BYTE 01h, 02h, 03h, 04h, 05h, 06h

; for question 3:
gaps DWORD 00h, 02h, 05h, 09h, 0Ah

; for question 4:
copyFrom WORD 05h, 0Ah, 010h, 0AFh, 060h
copyTo DWORD 5 DUP (?)

; for question 6:
reverseArray DWORD 01h, 02h, 03h, 04h, 05h, 06h, 07h, 08h

; for question 7:
source BYTE "This is the source string",0
target BYTE SIZEOF source DUP("#")

; for question 8:
wrapArray DWORD 10h, 20h, 30h, 40h, 50h, 60h

.code
main PROC
; 1.
	mov		al, bigEndian
	mov		ah, bigEndian + 1
	mov		bl, bigEndian + 2
	mov		bh, bigEndian + 3

	mov		BYTE PTR littleEndian, bh
	mov		BYTE PTR littleEndian + 1, bl
	mov		BYTE PTR littleEndian + 2, ah
	mov		BYTE PTR littleEndian + 3, al

; 2.
	mov		esi, 0
	mov		ecx, [LENGTHOF trading / 2]

trade:
	mov		al, [trading + esi]
	inc		esi
	xchg	al, [trading + esi]
	dec		esi
	mov		[trading + esi], al
	add		esi, 2
	loop	trade

; 3.
	mov		esi, 0
	mov		edx, 0
	mov		ecx, [LENGTHOF gaps - 1]

gap:
	mov		eax, [gaps + esi]
	add		esi, [TYPE gaps]
	mov		ebx, [gaps + esi]
	sub		ebx, eax
	add		edx, ebx
	loop	gap

; 4.
	mov		edx, 0
	mov		esi, 0
	mov		ecx, [LENGTHOF copyFrom]

copy:
	movzx	ebx, [copyFrom + edx]
	mov		[copyTo + esi], ebx
	add		edx, [TYPE copyFrom]
	add		esi, [TYPE copyTo]
	loop	copy

; 5.
	mov		ecx, 7
	mov		eax, 0
	mov		ebx, 1
	mov		edx, 0
	mov		esi, 0

fibonacci:
	mov		esi, ebx
	add		esi, edx
	mov		eax, esi
	mov		edx, ebx
	mov		ebx, eax
	loop	fibonacci

; 6.
	mov		eax, 0	; front pointer
	mov		ebx, [LENGTHOF reverseArray * TYPE reverseArray - TYPE reverseArray]	; back pointer
	mov		ecx, [LENGTHOF reverseArray / 2]
	mov		edx, 0	; holds front value
	mov		esi, 0	; holds back value

reverse:
	mov		edx, [reverseArray + eax]
	mov		esi, [reverseArray + ebx]
	mov		[reverseArray + eax], esi
	mov		[reverseArray + ebx], edx

	add		eax, TYPE reverseArray
	sub		ebx, TYPE reverseArray
	loop	reverse

; 7.
	mov		esi, 0
	mov		ecx, SIZEOF source - 1

reverseString:
	mov		al, source[esi]
	mov		target[ecx], al
	inc		esi
	loop	reverseString

; 8.
	mov		esi, LENGTHOF wrapArray * TYPE wrapArray
	mov		eax, wrapArray[esi - TYPE wrapArray]
	mov		ecx, LENGTHOF wrapArray - 1
	mov		esi, 0
	mov		ebx, wrapArray
	mov		edx, wrapArray + TYPE wrapArray

wrap:
	add		esi, TYPE wrapArray
	mov		wrapArray[esi], ebx
	mov		ebx, edx
	mov		edx, wrapArray[esi + TYPE wrapArray]
	loop	wrap
	
	mov		wrapArray, eax

	INVOKE ExitProcess,0
main ENDP
END main