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
loop:
  mov eax, byte [ecx+edx] ;get current byte
	cmp byte eax, '\n'
	je loop ; if enter, ignore it
	cmp byte eax, 0
	je end
	cmp byte eax, 'q'
	call exit ; os call exit
	sub eax, '0' ; set current char to int
	sar eax
	adc ebx, 0
	add ebx, '0'
	mov [outstring+edx*3]  ;append ebx to output string
	sar eax
	adc ebx, 0
	add ebx, '0'
	mov [outstring+edx*3+1]  ;append ebx to output string
	sar eax
	adc ebx, 0
	add ebx, '0'
	mov [outstring+edx*3+2]  ;append ebx to output string
	inc edx
	jmp loop





	;idea save string to memory
	;iterate over chars with register;
	;if char == 'q' exit;
	;foreach char do - '0'
	;shift right 3 times and concat CF to output string;

end:
	mov [outstring+edx*3], '0'  ;append ebx to output string

	push an			; call printf with 2 arguments -
	push format_string	; pointer to str and pointer to format string
	call printf
	add esp, 8		; clean up stack after call

exit:
	popad
	mov esp, ebp
	pop ebp
	ret
