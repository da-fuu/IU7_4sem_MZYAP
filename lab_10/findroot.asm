format ELF64 

public main

extrn 'printf' as _printf
printf equ PLT _printf
extrn 'scanf' as _scanf
scanf equ PLT _scanf


macro store_str name,str&
{
    name db str, 10, 0
}

macro print_str msg ; макрос печатает строку, аргумент - указатель на строку, обязана быть переменная с названием ptr_size
{
    lea rdi, [msg]
    call printf
}


section '.text' executable

print_res: ; вызывает принтф, передает один double из st0, в rdi - указатель на строку форматирования
    sub rsp, 8
    fstp qword [rsp]
    movsd xmm0, qword [rsp]  
    mov rax, 1
    call printf
    add rsp, 8
    ret

read_params:
    sub rsp, 8

    print_str func
    print_str input_start

    lea rdi, [lf_format]
    lea rsi, [start]
    call scanf
    cmp rax, 1
    jne .error

    print_str input_stop

    lea rdi, [lf_format]
    lea rsi, [stop]
    call scanf
    cmp rax, 1
    jne .error

    print_str input_iters
    
    lea rdi, [d_format]
    lea rsi, [iters]
    call scanf
    cmp rax, 1
    jne .error

    mov rax, 0
    jmp .end
    .error:
    mov rax, 1
    .end:
    add rsp, 8
    ret

find_root:
    sub rsp, 8
    fld qword [start]
    fld qword [stop]
    faddp


    lea rdi, [output_ans]
    call print_res

    mov rax, 0
    add rsp, 8
    ret

main:
    sub rsp, 8

    call read_params
    cmp rax, 0
    je .ok_read
    print_str input_error
    jmp .end
    .ok_read:

    call find_root

    .end:
    add rsp, 8
    mov rax, 0
    ret


section '.bss' writable
    start dq ?
    stop dq ?
    iters dd ?


section '.rodata'
    store_str func, 'Функция к поиску корня: ...'
    store_str input_start, 'Введите начало отрезка: '
    store_str input_stop, 'Введите конец отрезка: '
    store_str input_iters, 'Введите количество итераций: '
    store_str input_error, 'Ошибка ввода!'
    store_str output_ans, 'Найденный корень уравнения: %lf'

    lf_format db '%lf', 0
    d_format db '%d', 0

