.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
three DWORD 12345678h

.code
main PROC

; 1.
	
	
	INVOKE ExitProcess,0
main ENDP
END main