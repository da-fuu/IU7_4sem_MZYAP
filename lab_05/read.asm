format ELF64 

public read_num

extrn print_str_func
extrn read_char
extrn number word
extrn is_init byte

include 'common.inc'


section '.text' executable

read_num:
    print_str input_num_str
    mov [number], 0
    mov [is_init], 0

    .again:
	call read_char
    cmp dl, newline
    je .end
    sub dl, '0'
    cmp dl, 0
    jl .error
    cmp dl, 1
    jg .error
    shl [number], 1
    jc .error
    movzx dx, dl
    add [number], dx
    jmp .again

    .error:
    print_str input_error_str
    mov [is_init], 0
    ret

    .end:
    mov [is_init], 1
    ret


section '.rodata' 
    store_str input_num_str, 'Введите беззнаковое число в двоичной СС, максимум 16 цифр:'
    store_str input_error_str, 'Ошибка ввода числа!'
