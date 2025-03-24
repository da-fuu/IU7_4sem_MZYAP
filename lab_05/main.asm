; r9	; 6th param
; r8	; 5th param
; r10	; 4th param
; rdx	; 3rd param
; rsi	; 2nd param
; rdi	; 1st param
; eax	; syscall_number

format ELF64 

public _start  
public number
public is_init

extrn print_str_func
extrn read_char
extrn exit
extrn read_num
extrn print_full_uhex
extrn print_byte_idec
extrn print_two_pow_divisor


include 'common.inc'


section '.text' executable
    
print_menu:
    print_str header
    print_str exit_str
    print_str read_num_str
    print_str print_full_uhex_str
    print_str print_byte_idec_str
    print_str print_two_pow_divisor_str
    ret

read_digit_num: ; функция читает число в rdx и пропускает один символ
    call read_char
    sub dl, '0'
    mov dh, dl
    call read_char
    mov dl, dh
    ret

get_menu_ans:
    call print_menu
    
    call read_digit_num
    cmp dl, 0
    jl .neg_val
    cmp dl, funcs_n
    jge .big_val
    jmp .exit
    
    .neg_val:
    print_str neg_menu_str
    mov dl, 0
    mov rax, 18
    jmp .exit

    .big_val:
    print_str big_menu_str
    mov dl, 0
    mov rax, 48
    jmp .exit

    .exit:
    movzx rdx, dl
    ret

    
_start: ; точка входа
    call get_menu_ans
    
    call [funcs+rdx*8]
    
    jmp _start


section '.rodata'

funcs dq exit, read_num, print_full_uhex, print_byte_idec, print_two_pow_divisor
funcs_n = ($-funcs) / 8
funcs_max_str equ '4'


store_str header, 'Для выбора соответствующего пункта меню введите целое число от 0 до ', funcs_max_str
store_str exit_str, '0. Выйти из программы'
store_str read_num_str, '1. Ввести беззнаковое число в двоичной СС'
store_str print_full_uhex_str, '2. Вывести полное беззнаковое число в шестнадцатеричной СС'
store_str print_byte_idec_str, '3. Вывести младший байт числа как знаковое число в десятичной СС'
store_str print_two_pow_divisor_str, '4. Вывести максимальную степень двойки, которой кратно число'
store_str neg_menu_str, 'Пункт меню должен быть цифрой!'
store_str big_menu_str, 'Пункт меню не может быть больше ', funcs_max_str, '!'


section '.bss' writeable

number dw ?


section '.data' writeable

is_init db 0

