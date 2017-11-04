;
; file: sub3.asm
; Subprogram example program
;

%include "asm_io.inc"

segment .data
format db "Hello world %d,%d",10,0

segment .bss
input   resd 1

 

segment .text
        global  asm_main
        extern  printf

asm_main:
        enter   0,0               ; setup routine
        pusha
	    pushf

	    push	dword 1
	    push	dword 2
	    push	dword format
	    call	printf
	    pop	ecx
	    pop	ecx
	    pop	ecx


	    popf
        popa
        leave                     
        ret

segment .data
prompt1 db "Enter first number",10,0
prompt2 db "Enter second number",10,0
segment .bss
input1  resd 1
input2  resd 1
segment .text
add:
        push    ebp
        mov     ebp, esp
        mov     eax,prompt1
        call    print_string
        call    read_int
        push    eax
        mov     eax,prompt2
        call    print_string
        mov     eax,input2
        call    read_int
        add     eax,[esp]
        mov     eax,0xFFFFFFFF
        call    print_uint
        call    print_nl
        pop     eax
        pop     ebp
        ret






