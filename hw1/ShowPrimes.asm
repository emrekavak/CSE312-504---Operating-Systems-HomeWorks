	; EMRE KAVAK 151044085
	; 8080 assembler code
        .hexfile ShowPrimes.hex
        .binfile ShowPrimes.com
        ; try "hex" for downloading in hex format
        .download bin  
        .objcopy gobjcopy
        .postbuild echo "OK!"
        ;.nodump

	; OS call list
PRINT_B		equ 4
PRINT_MEM	equ 3
READ_B		equ 7
READ_MEM	equ 2
PRINT_STR	equ 1
READ_STR	equ 8

	; Position for stack pointer
stack   equ 0F000h

	org 000H
	jmp begin

	; Start of our Operating System
GTU_OS:	PUSH D
	push D
	push H
	push psw
	nop	; This is where we run our OS in C++, see the CPU8080::isSystemCall()
		; function for the detail.
	pop psw
	pop h
	pop d
	pop D
	ret
	; ---------------------------------------------------------------
	; YOU SHOULD NOT CHANGE ANYTHING ABOVE THIS LINE  
string: dw 'prime',00H
backup: db 0
begin:
	LXI SP,stack 	; always initialize the stack pointer
	mvi e,1
	mvi c,0
	mvi h,1000
	MOV b, 0 			; firs value for print
	MVI A, PRINT_B	
	call GTU_OS
	mvi b,'0' 			; signal for print space on the screen
	MVI A, PRINT_STR	
	call GTU_OS
lop2: 
	INR c
	MOV A,c
	SUB h
	JZ outt
	;JM outt
	MOV A,c
	JNZ minus
minus:
	SUB e		;A= A-e
	JZ incrAandE; A=0 ise bu sayı a'nın bölenidir demektir.
	JM lop		; A<0 ise bu sayı a nın böleni degıldır demektir.
	JMP minus
lop:  
	MOV A,c
	INR e 		; e = e+1
	SUB e 		; A = A - e
	JZ putout 	; for print value and 'prime' 
	JM lop2
	MOV A,c 	
	JNZ minus
incrAandE:		; print integers
	MOV b, c
	MVI A, PRINT_B	
	call GTU_OS
	mvi b,'0'	; for print newline
	MVI A, PRINT_STR
	call GTU_OS
	INR c
	MOV A,c
	SUB h
	JZ outt
	MOV A,c
	MVI e,2
	JMP minus
putout :		; prime number printing
	MOV b, c
	MVI A, PRINT_B	
	call GTU_OS
	JNZ print2
print2:
	MOV A, c	
	STA backup	;c register counter for limit value, so it will be save into memory
	lxi b, string
	MVI A, PRINT_STR	
	call GTU_OS
	LDA backup	;c loading again
	MOV c,A
	MVI e,2		; e register is divider
	JMP lop2
outt :
	HLT
