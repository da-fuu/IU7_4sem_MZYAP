format ELF64 

public print_full_uhex

extrn print_str_func
extrn write_char
extrn number word
extrn is_init byte


include 'common.inc'


diff_between_a_9 = 'A' - '9' - 1

section '.text' executable

print_num:
    mov al, '0'
    call write_char
    mov al, 'x'
    call write_char

    mov cl, 16
    .loop_quartets:
        sub cl, 4
        mov dx, [number]
        shr dx, cl

        mov ax, 0
        shrd ax, dx, 4
        shr ax, 12

        cmp al, 10
        jl .skip_inc
        add al, diff_between_a_9
        .skip_inc:
        add al, '0'
        call write_char
        cmp cl, 0
        ja .loop_quartets

    mov al, newline
    call write_char

    ret

print_full_uhex:
    cmp [is_init], 1
    je .continue
    print_str no_num_error_str
    ret

    .continue:
    print_str print_full_uhex_str
    call print_num
    ret


section '.rodata' 
    store_str print_full_uhex_str, 'Полное беззнаковое число в шестнадцатеричной СС:'
