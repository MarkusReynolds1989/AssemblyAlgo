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

; Add a local variable to a procedure.
;sub esp, 8
;number_local equ DWORD PTR [ebp-4] ; test local variable
;mov number_local, 10
;mov eax, number_local
;call WriteInt
;mov esp, ebp ; remove local variable

.code
main PROC
	; Args for GetMax.
	push LENGTHOF myList ; ebp + 12
	push OFFSET myList ; ebp + 8
	call GetMax
	; End GetMax.
	call WriteInt

	call Crlf

	; Args for GetMin.
	push LENGTHOF myList2
	push OFFSET myList2
	call GetMin
	; End GetMin.
	call WriteInt

	INVOKE ExitProcess, 0
main ENDP

; Determines the max integer in an array.
; *i32 -> i32 -> i32.
GetMax Proc
	push ebp ; Save return address
	mov ebp, esp ; Set base of stack frame.

	; Local args.
	array equ [ebp + 8]
	length_array equ [ebp + 12]

	mov esi, array
	mov ecx, length_array

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

	pop ebp
	ret 8; Clean up stack.
GetMax endp

; Determines the min integer in an array.
; *i32 -> i32 -> i32.
GetMin Proc
	push ebp
	mov ebp, esp

	;local args.
	array equ [ebp + 8]
	length_array equ [ebp + 12]

	mov esi, array
	mov ecx, length_array

	mov eax, MAX

	compare_for_min: 
		cmp eax, [esi]
		jg set_min
		jmp increment

	set_min: 
		mov eax, [esi]

	increment: 
		add esi, TYPE DWORD
		loop compare_for_min

	pop ebp
	ret 8 
GetMin endp

; Write a function to reverse a string.
ReverseString Proc
ReverseString endp

END main