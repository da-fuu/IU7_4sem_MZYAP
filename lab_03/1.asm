EXTRN print_sum: near

STK SEGMENT PARA STACK 'STACK'
	db 100 dup(0)
STK ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
	X db 0
	Y db 0
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, DS:DSEG, SS:STK
new_line:
	mov ah, 02h
	mov dl, 13
	int 21h
	mov dl, 10
	int 21h
	ret
main:
	mov ax, DSEG
	mov ds, ax

	mov ah, 01h
	int 21h
	mov X, al
	
	call new_line
	
	mov ah, 01h
	int 21h
	mov Y, al

	call new_line

	call print_sum	

	mov ah, 4Ch
	int 21h
CSEG ENDS

PUBLIC X
PUBLIC Y

END main
