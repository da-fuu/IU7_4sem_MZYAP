format ELF64 

public print_byte_idec
public write_udec_number


extrn write_char
extrn print_str_func
extrn number word
extrn is_init byte


include 'common.inc'


section '.text' executable

write_udec_number: ; печатет число из al    
    cmp al, 10
    jl .one_digit
    
    mov cl, 10
    cbw
    idiv cl
    add al, '0'
    call write_char
    mov al, ah
    
    .one_digit:
    add al, '0'
    call write_char
    mov al, newline
    call write_char
    
    ret

write_idec_number: ; печатет число в допкоде из al
    mov dl, al
    
    mov cl, 10
    cbw
    idiv cl
    mov [answer+3], ah
    cbw
    idiv cl
    mov [answer+2], ah
    mov [answer+1], al

    mov [answer], '+'
    cmp dl, 0
    jge .positive
    mov [answer], '-'
    neg [answer+1]
    neg [answer+2]
    neg [answer+3]

    .positive:
    add [answer+1], '0'
    add [answer+2], '0'
    add [answer+3], '0'
    mov [answer+4], newline
    print_str answer

    ret

print_byte_idec:
    cmp [is_init], 1
    je .continue
    print_str no_num_error_str
    ret

    .continue:
    print_str print_idec_str
    mov ax, [number]    
    call write_idec_number
    ret


section '.rodata' 
    store_str print_idec_str, 'Младший байт числа как знаковое число в десятиричной СС:'

section '.data'
    answer db 5 dup ?
    answer_size = $-answer

