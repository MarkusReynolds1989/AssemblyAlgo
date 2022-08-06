include Irvine32.inc

.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
myList2 DWORD 3,8,3,10,110,5 ;; [i32, 6]
myList DWORD 1,2,3,4,5,6 ;; [i32; 6]
MIN DWORD -2147483647 ;; Const i32
MAX DWORD 2147483647 ;; Const i32

.code
main PROC
	mov esi, OFFSET myList ; Point to myList.
	mov ecx,LENGTHOF myList ; Counter is set to length of myList.
	call GetMax
	call WriteInt

	call Crlf
	mov esi, OFFSET myList2
	mov ecx, LENGTHOF myList2
	call GetMin
	call WriteInt

	INVOKE ExitProcess, 0
main ENDP

; Determines the max integer in an array.
GetMax Proc

	; We are doing this because both of these values will be updated in this procedure.
	push esi ; Save esi, the source index register. This is used for copying the array.
	push ecx ; Save ecx, this is the counter register. We are using this to track the length.

	mov eax, MIN ; Set eax to the minimum value.

	compare_for_max: 
		cmp eax, [esi] ; Compare eax to the current array element.
		jl set_max ;; If the current array element is greater than eax, set eax to that element.
		jmp increment;; Otherwise increment to the next number.

	set_max: 
		mov eax, [esi] ; Set eax to be the current array element.

	increment:
		add esi, TYPE DWORD ; Go to the next element of the array.
		loop compare_for_max ; When we use loop it checks if we are still under the length of the array.
		
	pop ecx ; Reload the pervious ecx back into the register.
	pop esi ; Reload the previous esi back into the register.
	ret
GetMax endp

GetMin Proc
	push esi
	push ecx

	mov eax,MAX

	compare_for_min: 
		cmp eax, [esi]
		jg set_min
		jmp increment

	set_min: 
		mov eax, [esi]

	increment: 
		add esi, TYPE DWORD
		loop compare_for_min

	pop ecx
	pop esi
	ret
GetMin endp

END main