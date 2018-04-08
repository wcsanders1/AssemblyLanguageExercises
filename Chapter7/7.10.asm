.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
arraySize_sieve equ 20d

.code
main PROC

; ---------------------------------- 1.
	
	.data
	testNum1_1 BYTE '87654321'

	.code
	mov ebx, 5
	mov ecx, LENGTHOF testNum1_1
	mov edx, OFFSET testNum1_1
	call WriteScaled
	call Crlf

; ---------------------------------- 2.

	.data
	testArray1A_2 BYTE 99h, 88h, 77h, 66h, 55h, 44h, 33h, 22h, 99h, 88h, 77h, 66h, 55h, 44h, 33h, 22h
	testArray1B_2 BYTE 22h, 33h, 44h, 55h, 66h, 77h, 88h, 99h, 22h, 33h, 44h, 55h, 66h, 77h, 88h, 99h
	result_2 BYTE LENGTHOF testArray1A_2 DUP(0)

	.code
	mov esi, OFFSET testArray1A_2
	mov edi, OFFSET testArray1B_2
	mov ecx, LENGTHOF testArray1A_2
	mov ebx, OFFSET result_2
	call ExtendedSub
	call Crlf

	mov esi, OFFSET result_2
	mov ecx, LENGTHOF testArray1A_2
	call DisplaySubResult
	call Crlf

; ---------------------------------- 3.

	.data
	result_3 byte sizeof dword * 2 + 1 dup(0)

	.code
	mov eax, 12345678h
	mov esi, offset result_3
	call PackedToAsc
	mov edx, offset result_3
	call WriteString
	call Crlf

; ---------------------------------- 4.

	.data
	key_4 byte 2d, -4d, -1d, 0, 3d, -5d, -2d, 4d, 4d, -6d
	test_string_4 byte "This is a test.",0
	encrypted_string_4 byte lengthof test_string_4 dup(?)

	.code
	mov ebx, lengthof key_4
	mov esi, offset key_4
	mov ecx, lengthof test_string_4
	mov edx, offset test_string_4
	mov eax, offset encrypted_string_4
	call EncryptString

; ---------------------------------- 5.

	.data
	primes_5 byte arraySize_sieve dup(?)

	.code
	mov eax, offset primes_5
	call SieveOfEratosthenes

; ******** END OF QUESTIONS **********	

	call	Crlf
	call	WaitMsg

	INVOKE ExitProcess,0

main ENDP

WriteScaled PROC
;-----------------------------------------------------------------------------
; Outputs a decimal; ASCII number with an implied decimal point
; Receives: EBX = decimal offset
;			ECX = number length
;			EDX = number's offset
; Returns: nothing
;-----------------------------------------------------------------------------

	pushad
	
	mov eax, ecx
	sub eax, ebx
	mov ebx, eax
	inc ebx

	inc ecx		; increase num length by one to account for decimal

	printNum:

		dec ebx
		jz printDec

		mov al, BYTE PTR [edx]
		call WriteChar
		inc edx
		loop printNum

		jmp exitWriteScaled

		printDec:

			mov al, '.'
			call WriteChar
			loop printNum

	exitWriteScaled:

	popad
	ret

WriteScaled ENDP

;***********************************************************************

ExtendedSub PROC
;-----------------------------------------------------------------------------
; Calculates the result of subtracting two extended integers stored as
; arrays of bytes.
; Receives: ESI and EDI point to the two integers
;			EBX points to a variable that will hold the result
;			ECX holds the length of the arrays (the length of both arrays
;				must be the same)
; Returns: nothing
;-----------------------------------------------------------------------------

	pushad
	clc

	extendedSub_Loop:

		mov al, [esi]
		sbb al, [edi]
		pushfd
		mov [ebx], al
		inc esi
		inc edi
		inc ebx
		popfd
		loop extendedSub_Loop

	popad
	ret

ExtendedSub ENDP

DisplaySubResult PROC
;-----------------------------------------------------------------------------
; Displays sum of extended add/sub in correct order
; Receives: ESI points to the var that holds the value to display
;			ECX holds the length of the value to display
; Returns: nothing
;-----------------------------------------------------------------------------

	pushad
	xor eax, eax

	displaySum_Loop:
		
		mov al, [esi]
		mov ebx, TYPE BYTE
		call WriteHexB
		add esi, TYPE BYTE
		loop displaySum_Loop

	popad
	ret

DisplaySubResult ENDP

PackedToAsc PROC
;-----------------------------------------------------------------------------
; Converts 4-byte packed decimal int to string of ASCII decimal digits
; Receives: ESI points to the var that holds the ASCII string
;			EAX contains the packed integer			
; Returns: nothing
;-----------------------------------------------------------------------------

	pushad
	mov ecx, 8
	mov edi, 7
	mov edx, eax

	packedToAsc_Loop:
		aaa
		or al, 30h
		mov [esi + edi], al
		dec edi
		shr edx, 4
		mov eax, edx
		loop packedToAsc_Loop
	
	popad
	ret

PackedToAsc ENDP

EncryptString PROC
;-----------------------------------------------------------------------------
; Converts Encrypts a string using a provided key
; Receives: ESI points to the key
;			EBX holds the length of the key
;			ECX holds the length of the string to encrypt
;			EDX points to the string to encrypt			
;			EAX points to the encrypted string			
; Returns: nothing
;-----------------------------------------------------------------------------

	.data
	encryptString_keyLength dword 0
	encryptString_keyIndex dword 0
	encryptString_stringLength dword 0
	encryptString_tempLoopCntr dword 0

	.code
	pushad
	mov encryptString_keyLength, ebx
	mov encryptString_stringLength, ecx

	encryptString_Loop:
		mov ebx, encryptString_keyLength
		cmp encryptString_keyIndex, ebx
		jl keyWithinBounds
		mov encryptString_keyIndex, 0

		keyWithinBounds:
			mov bl, byte ptr [edx + ecx - 2]
			mov encryptString_tempLoopCntr, ecx
			push eax
			mov eax, encryptString_keyIndex
			mov cl, byte ptr [esi + eax]
			pop eax
			ror bl, cl
			mov ecx, encryptString_tempLoopCntr
			mov [eax + ecx - 1], bl
			inc encryptString_keyIndex
		
		loop encryptString_Loop

	popad
	ret

EncryptString ENDP

SieveOfEratosthenes PROC
;-----------------------------------------------------------------------------
; Makes a list of all primes within a range of integers from 2 to 10000
; Receives: EAX points to the array of primes			
; Returns: nothing
;-----------------------------------------------------------------------------

	.data
	array_sieve byte arraySize_sieve dup (0)
	
	.code
	pushad
	mov ecx, arraySize_sieve
	mov bl, 2
	mov edx, offset array_sieve
	xor esi, esi

	makeArraySieve_Loop:

		mov [edx + esi], bl
		inc bl
		inc esi
		loop makeArraySieve_Loop

	xor ecx, ecx
	xor esi, esi
	add edx, esi

	sieve_Loop:

		mov al, [edx]
		cmp al, 0
		jg crossOut
		inc edx
		cmp ecx, arraySize_sieve
		jl sieve_Loop
		jmp endSieve

		crossOut:
				
			movzx ecx, al
			mov eax, arraySize_sieve
			sub eax, ecx
			cmp eax, ecx
			jl endSieve
			mov esi, ecx
			xor bl, bl

			crossOut_Loop:

				mov [edx + esi], bl
				add esi, ecx
				cmp esi, eax
				jle crossOut_Loop
				inc edx
				jmp sieve_Loop

	endSieve:

	popad
	ret
	
SieveOfEratosthenes ENDP

END main