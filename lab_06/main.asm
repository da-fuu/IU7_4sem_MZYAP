TIMEOUT = 01b shl 5
START_INTERVAL equ 1Fh
INTERVAL_MS = 500
INTERVAL_TICS = INTERVAL_MS * 18 / 1000

CSEG SEGMENT para public 'CODE'
assume CS:CSEG
	time db INTERVAL_TICS
	value db START_INTERVAL
	old_handler dd ?
handler:

	inc time
	cmp time, INTERVAL_TICS
	jle end_handler
	mov time, 0

	mov al, 0F3h
	out 60h, al

	mov al, value
	or al, TIMEOUT
	out 60h, al

	dec value
	cmp value, -1
	jge end_handler
	mov value, START_INTERVAL
end_handler:
	jmp dword ptr old_handler

main:
	mov ah, 35h
	mov al, 1Ch
	int 21h

	mov word ptr old_handler, bx
	mov word ptr old_handler+2, es

	mov ah, 25h
	mov al, 1Ch
	mov dx, CSEG
	mov ds, dx
	mov dx, handler
	int 21h

	mov ah, 31h
	mov al, 0
	mov dx, main
	.386
	shr dx, 4
	.8086
	int 21h

CSEG ENDS

END main
