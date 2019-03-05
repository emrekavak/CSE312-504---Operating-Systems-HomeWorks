	;EMRE KAVAK 151044085
        ; 8080 assembler code
        .hexfile Factorize.hex
        .binfile Factorize.com
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
begin:
	LXI SP,stack 	; always initialize the stack pointer
	MVI A, READ_B	; store the OS call code to A // burada, PRINT_B NIN OS CODUNU A REGE ATADIM, 
	call GTU_OS	; call the OS  // burada, b registera, input.txt icindeki degeri atamak ıcın os cagırdım, su anda regb nin ici dolu
	mvi e,0
	MOV d,b		; bnin contentini d ye yedekledim
	
lop :  
	MOV A,d 
	SUB e 		; A = A - e
	JZ outt
	JM outt
	MOV A,d 
	INR e 		; e = e+1	
	JNZ minus

minus :
	SUB e		;A= A-e
	JM lop		;A<0 ise bu sayı a nın böleni degıldır demektir.
	JZ print	;A=0 ise bu sayı a'nın bölenidir demektir.
	JNZ minus
print :
	MOV b, e
	MVI A, PRINT_B	
	call GTU_OS
	JNZ lop
outt :
	HLT
