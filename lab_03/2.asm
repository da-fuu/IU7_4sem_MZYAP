PUBLIC print_sum
EXTRN X: byte
EXTRN Y: byte

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG
print_sum proc near
	mov dl, X
	mov dh, Y
	sub dl, '0'
	sub dh, '0'
	add dl, dh
	add dl, '0'
	mov ah, 02h
	int 21h
	ret
print_sum endp
CSEG ENDS
END
