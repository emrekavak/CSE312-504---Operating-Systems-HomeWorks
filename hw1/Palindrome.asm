	; EMRE KAVAK 151044085
        ; 8080 assembler code
        .hexfile Palindrome.hex
        .binfile Palindrome.com
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
yesPalin: dw ': Palindrome' ,00AH,00H 		;for print the output
notPalin: dw ': Not Palindrome',00AH,00H 	

string: dw '\n'				;for check end of string
begin:
	LXI SP,stack 			;always initialize the stack pointer
	mvi b,1				;you should initialize b with 1 or grader than 1
	MVI A, READ_STR			;reading str
	call GTU_OS			;call GTU_OS
	MVI A, PRINT_STR		;Print string to output file or screen
	call GTU_OS
	MOV h,b				;backup to string
	MOV l,c
	mvi d,0				;size counter
	lxi e, string			;for end of file check
ssize:					;for found string  size
	ldax b				;assign A to next string element
	SUB e				;check end of file
	JZ backup_size							
	INX b
	INR d	; size			
	JNZ ssize
	
backup_size:				;back up string size, it will be necessary soon.
	DCX b ; 			;dcrease the adress of b register because of assign the last element 
	MOV e,d
	DCR d
	MOV A,d
	JZ print2
	INR d
	JMP getIntoH
	
backup_size2:				;after decrease or increase we should hold size
	MOV d,e
	JMP incrmentB1	
incrmentB1:				;for b adress to lastElement - N
	INX b
	DCR d
	MOV A,d
	JZ getIntoH
	JNZ incrmentB1
getIntoH: 									
	LDAX b				;A = adress of b element
	MOV h,A				;The last element in the string assing to h register
	MOV d,e
	DCR d
	JMP dicrmentB1					
getIntoA:				;A = FirstElement + N
	LDAX b
	MOV A,A
	JMP compare								
compare: 				;check two element same or not, it not it will be print not polindrome
	SUB h
	JZ minusSize
	JNZ print1
minusSize:				;size dcrease because of iterate between element
	DCR e 
	DCR e
	MOV A,e 
	MOV d,e
	DCR d
	MOV A,d
	JZ print2
	JM print2
	JMP backup_size2	
dicrmentB1: 				;adres of b --
	DCR d 
	DCX b
	MOV A,d
	JZ getIntoA			;first element adress going to be A register
	JNZ dicrmentB1	
print1:	
	lxi b,notPalin			;Print Not Palindrome
	MVI A, PRINT_STR
	call GTU_OS
	JMP outt
print2:					;Print Palindrome
	lxi b,yesPalin
	MVI A, PRINT_STR
	call GTU_OS
	JMP outt
outt:
	HLT
