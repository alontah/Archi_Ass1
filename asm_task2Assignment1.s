section	.rodata			; we define (global) read-only variables in .rodata section
	format_string: db "%s", 10, 0	; format string

section .bss			; we define (global) uninitialized variables in .bss section
	an: resb 12		; enough to store integer in [-2,147,483,648 (-2^31) : 2,147,483,647 (2^31-1)]
	outstring: resb 33 ; reserve 33 chars long output string

section .text
	global convertor
	extern printf

convertor:
	push ebp
	mov ebp, esp
	pushad

	mov ecx, dword [ebp+8]	; get function argument (pointer to string)

	; your code comes here...
	mov edx, 0 ;counter for distance from beginning of string
	mov ebx, 0 ;accumulator
loop:
  mov al, byte [ecx+edx] ;get current byte
	cmp  eax, '\n'
	je loop ; if enter, ignore it
	cmp  eax, 0
	je end
	cmp  eax, 'q'
	call exit ; os call exit
	sub al, '0' ; set current char to int
	shl eax, 3*edx
	add ebx, eax
	; blablalblalblabla
	inc edx
	jmp loop


end:

	push an			; call printf with 2 arguments -
	push format_string	; pointer to str and pointer to format string
	call printf
	add esp, 8		; clean up stack after call

exit:
	popad
	mov esp, ebp
	pop ebp
	ret
