;
; file: asm_main.asm

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data

prompt1	db	"Enter a number: ", 0
prompt2	db	"Enter another number: ", 0

outmsg1	db	"You entered ", 0
outmsg2	db	" and ", 0
outmsg3	db	", the sum of these is: ", 0

; uninitialized data is put in the .bss segment
;
segment .bss

input1 resd 1
input2 resd 1
;
; code is put in the .text segment
;
segment .text
        global  asm_main

asm_main:
        enter   0,0               ; setup routine
        pusha
; next print out result message as series of steps
	mov 	eax, prompt1
	call	print_string

	mov	ebx, input1
	mov	ecx, ret1

	jmp	short get_int

ret1:
	mov 	eax, prompt2 ; print out prompt
	call 	print_string

	mov 	ebx, input2
	mov 	ecx, $ + 7 ; ecx = this address + 7

 	jmp 	short get_int

 	mov 	eax, [input1] ; eax = dword at input1
 	add 	eax, [input2] ; eax += dword at input2
 	mov 	ebx, eax ; ebx = eax

	mov 	eax, outmsg1
	call 	print_string ; print out first message

	mov 	eax, [input1]
 	call 	print_int ; print out input1

 	mov 	eax, outmsg2
 	call 	print_string ; print out second message

 	mov 	eax, [input2]
 	call 	print_int ; print out input2

 	mov 	eax, outmsg3
 	call 	print_string ; print out third message

 	mov 	eax, ebx
	call 	print_int ; print out sum (ebx)
 	call 	print_nl ; print new-line

	popa
	mov 	eax, 0 ; return back to C
	leave
	ret

;subprogram get_int
;parameters:
;	bex - address of dword to store integer into
;	ecx - address of instruction to return to
; Notes:
;	Value of eax is destroyed
get_int:
	call	read_int
	mov	[ebx], eax
	jmp	ecx
