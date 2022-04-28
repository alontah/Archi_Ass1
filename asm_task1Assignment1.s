section	.rodata			; we define (global) read-only variables in .rodata section
	format_string: db "%d", 10, 0	; format string

section .text
	global assFunc
	extern printf
  extern c_checkValidity

assFunc:
	push ebp
	mov ebp, esp
	pushad

	mov ecx, dword [ebp+8]	; get function argument

  push ecx
  call c_checkValidity ; return value in eax

  cmp eax, 0
  jz times_8

  jmp times_4


times_4:
  sal ecx, 2
  jmp after_cases

times_8:
  sal ecx, 3



	; store value in register
  ; call checkValidity
  ; if 1 print value * 4
  ; else print value * 8

after_cases:
  ; calling the prinf func


	push ecx			; call printf with 2 arguments -
	push format_string	; pointer to int and pointer to format string
	call printf

	add esp, 8		; clean up stack after call
	;TODO ask why popad causes segmentation falue
	popad
	mov esp, ebp
	pop ebp
	ret
