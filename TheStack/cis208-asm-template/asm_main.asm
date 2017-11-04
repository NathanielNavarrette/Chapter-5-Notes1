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
	mov	ebx, 10
	push 	ebx
	mov	ebx, 20
	push	ebx
	call	dump_stack, 101
	pop	eax
	call	print_int

        popa
        mov     eax, 0            ; return back to C
        leave
        ret
