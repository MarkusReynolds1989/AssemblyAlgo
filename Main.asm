.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
myList2 DWORD 3,8,3,10,110,5
myList DWORD 1,2,3,4,5,6

.code
main PROC
	mov ebp, -4; Array counter.
	mov edx, -2147483647 ; Move min into edx, use this as the max value.
	mov ebx, 2147483647 ; Move max into ebx, use this as the min value.
	mov ecx, 0 ; Set ecx as 0 for counting.
	jmp compare

	range: 
		mov eax, [myList + ebp] ; Move contents of myList into eax, element pointed at by ebp.

		cmp ebx, eax ; See if the min value is more than the eax value (current element of list)
		jg set_min ; Set the min to be eax if it is more.

		cmp edx, eax ; See if the max value is less than the eax value.
		jl set_max
	
	set_min: 
		mov ebx, eax ;; Set ebx to be the value in eax.

		cmp edx, eax
		jl set_max

		jmp compare

	set_max: 
		mov edx, eax ;; Set edx to be the value in eax.
		
		cmp ebx, eax
		jg set_min

		jmp compare
	
	compare:
		add ecx, 1
		add ebp, 4
		cmp ecx, 7
		jl range
		je end_items
	
	end_items: 
		mov eax, edx ; move the min value into eax
		sub eax, ebx ; subtract the max from the min

	INVOKE ExitProcess, eax
main ENDP

END main