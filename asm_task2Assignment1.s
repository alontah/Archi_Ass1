section	.rodata			; we define (global) read-only variables in .rodata section
	format_string: db "%s", 10, 0	; format string

section .bss			; we define (global) uninitialized variables in .bss section
	outstring: resb 33 ; reserve 33 chars long output string

section .text
	global convertor
	extern printf

convertor:
	push ebp
	mov ebp, esp
	pushad

	mov ecx, dword [ebp+8]	; get function argument (pointer to string)


	mov edx, -1 ;counter for distance from beginning of string
	mov ebx, 0 ;make sure ebx doesn't contain junk

;each loop iteration 'translates' 1 octa digit to 3 binary digits and appends them to the output string
loop:
    inc edx
    movzx eax, byte [ecx+edx] ;get current byte
	cmp byte eax, 0xa; \n is 10 in ascii, wrote 10 to remove assembler warning
	je end ; if '\n', ignore it
	cmp al, 0
	je end
	cmp al, 'q'
	je end_process
	sub eax, '0' ; set current char to int
	shr eax, 1
	adc ebx, 0 ;extract carry bit
	add ebx, '0'
	mov [outstring+edx*3+2], bl  ;append ebx to output string
	mov bl, 0
	shr eax, 1
	adc ebx, 0
	add ebx, '0'
	mov [outstring+edx*3+1], bl  ;append ebx to output string
	mov bl, 0
	shr eax, 1
	adc ebx, 0
	add ebx, '0'
	mov [outstring+edx*3], bl  ;append ebx to output string
	mov bl, 0
	jmp loop


end:
	mov byte [outstring+edx*3], 0  ;append ebx to output string

	push outstring			; call printf with 2 arguments -
	push format_string	; pointer to str and pointer to format string
	call printf
	add esp, 8		; clean up stack after call



exit:
	popad
	mov eax, 0
    mov esp, ebp
    pop ebp
    ret

end_process:
	popad
    mov eax, 1
    mov esp, ebp
    pop ebp
    ret
