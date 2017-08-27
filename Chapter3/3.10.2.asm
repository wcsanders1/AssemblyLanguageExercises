; Define a symbolic constant for each day of the week.
; Make an array variable using the symbols as initializers.

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
sunday		EQU <"Sunday",0>
monday		EQU <"Monday",0>
tuesday		EQU <"Tuesday",0>
wednesday	EQU <"Wednesday",0>
thursday	EQU <"Thursday",0>
friday		EQU <"Friday",0>
saturday	EQU <"Saturday",0>

days BYTE sunday, monday, tuesday, wednesday, thursday, friday, saturday

.code
main PROC
	
	INVOKE ExitProcess,0
main ENDP
END main