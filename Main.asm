include Irvine32.inc

.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
myList2 DWORD 3,8,3,10,110,5
myList DWORD 1,2,3,4,5,6
max DWORD -2147483647
min DWORD 2147483647
max_string BYTE "Max: ",0
min_string BYTE "Min: ",0

.code
main PROC
	mov ebp, 0; Array pointer.
	mov ecx, 0 ; Set ecx as 0 for counting.

	compare_min_max: 

		compare_for_max: 
			mov eax, max
			cmp eax, [myList + ebp] ; See if the max value is less than the current ebp.
			jl set_max ; Set the max to be eax if it is more.

		compare_for_min:
			mov eax, min
			cmp eax, [myList + ebp] 			
			jg set_min

			jmp increment
	
	set_max: 
		mov eax, [myList + ebp]
		mov max, eax	
		
		;; Go and see if this value is also less than the min.
		jmp compare_for_min

	set_min: 
		mov eax, [myList + ebp]
		mov min, eax  

		jmp increment

	;; Increment all the values.		
	increment:
		add ecx, 1
		add ebp, 4
		cmp ecx, 6
		jl compare_min_max
		je end_items
	
	end_items: 
		call Crlf
		mov edx,OFFSET max_string
		call WriteString
		mov eax, max
		call WriteInt
		call Crlf
		mov eax, min
		mov edx,OFFSET min_string
		call WriteString
		call WriteInt

	INVOKE ExitProcess, 0
main ENDP

END main