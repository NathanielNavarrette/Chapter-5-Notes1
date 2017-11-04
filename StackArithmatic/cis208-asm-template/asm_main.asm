;
; file: asm_main.asm

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data


; uninitialized data is put in the .bss segment
;
segment .bss

;
; code is put in the .text segment
;
segment .text
        global  asm_main

asm_main:
        enter   0,0               ; setup routine
        pusha
; next print out result message as series of steps

	;push 	dword 10
	;push 	dword 20
	call 	add

        popa
        mov     eax, 0            ; return back to C
        leave
        ret


segment .data
	prompt1	db	"Enter first number: ", 10, 0
	prompt2	db	"Enter second number: ", 10, 0
	outmsg1	db	"The sum of the two numbers is:",10,0
segment .bss
	input1 resd 1
	input2 resd 1
segment .text
add:	
	;push	ebp

	;mov	ebp, esp
	;mov	eax, [ebp+8]
	;add	eax, [ebp+12]
	;call	print_int
	;call	print_nl
	;pop	ebp

	push ebp
	mov	ebp, esp

	mov	eax, prompt1
	call	print_string
	mov	eax, input1
	call	read_int
	push	eax
b1:
	mov	eax, prompt2
	call	print_string
	mov	eax, input2
	call	read_int
	push 	eax
b2:
	mov	eax,outmsg1
	call	print_string
	pop	eax
	add	eax, [esp]
	call	print_int
	call	print_nl

	pop 	eax
	pop	ebp

	ret
