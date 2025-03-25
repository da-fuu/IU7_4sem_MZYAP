format ELF64 

public print_two_pow_divisor

extrn write_udec_number
extrn number word
extrn is_init byte


include 'common.inc'


section '.text' executable

print_num:
    bsf ax, [number]
    jnz .normal
    print_str zero_error_str
    ret
    .normal:
    call write_udec_number
    ret

print_two_pow_divisor:
    cmp [is_init], 1
    je .continue
    print_str no_num_error_str
    ret

    .continue:
    print_str print_divisor_str
    call print_num
    ret


section '.rodata' 
    store_str print_divisor_str, 'Максимальная степень двойки, которой кратно число:'
    store_str zero_error_str, 'Число равно 0, максимальная степень не определена!'
