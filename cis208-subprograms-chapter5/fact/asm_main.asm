;
; file: sub1.asm
; Subprogram example program

%include "asm_io.inc"

segment .data
prompt1 db    "Enter a number: ", 0       ; don't forget nul terminator
prompt2 db    "Enter another number: ", 0
outmsg1 db    "You entered ", 0
outmsg2 db    " and ", 0
outmsg3 db    ", the sum of these is ", 0

segment .bss
;
; These labels refer to double words used to store the inputs
;
input1  resd 1
input2  resd 1

 

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov     eax, prompt1      ; print out prompt
        call    print_string

        mov     ebx, input1       ; store address of input1 into ebx
	call	get_int
	push    dword [input1]
	call    _fact
        call    print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret
;
; subprogram get_int
; Parameters:
;   ebx - address of dword to store integer into
;   ecx - address of instruction to return to
; Notes:
;   value of eax is destroyed
get_int:
          call    read_int
          mov     [ebx], eax         ; store input into memory
          ret                        ; jump back to caller
; finds n!

_fact:
	enter 0,0
b1:
 	mov eax, [ebp+8] ; eax = n
	cmp eax, 1
	jbe term_cond ; if n <= 1, terminate
	dec eax
	push eax
	call _fact ; eax = fact(n-1)
	pop ecx ; answer in eax
	mul dword [ebp+8] ; edx:eax = eax * [ebp+8]
	jmp short end_fact
term_cond:
	mov eax, 1
end_fact:
	leave
	ret
