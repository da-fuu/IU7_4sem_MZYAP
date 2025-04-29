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

f:
    fld st0
    fmulp
    mov [buf], 5.0
    fsub [buf]
    fsin 
    mov [buf], 2.0
    fmul [buf]
    ret

load_center:
    fld [start]
    fld [stop]
    faddp
    mov [buf], 2.0
    fdiv [buf]
    ret

f_center:
    call load_center
    call f
    ret

f_start:
    fld [start]
    call f
    ret

f_stop:
    fld [stop]
    call f
    ret

cmp_sign:
    fmulp
    mov [buf], 0.0
    fld [buf]
    fcomip st1
    jb .no_root
    mov rax, 1
    jmp .end
    .no_root:
    mov rax, 0
    .end:
    fstp [buf]
    ret

check_eps:
    fabs
    fld [EPS]
    fcomip st1
    jb .greater
    mov rax, 1
    jmp .end
    .greater:
    mov rax, 0
    .end:
    fstp [buf]
    ret

find_root:
    sub rsp, 8

    finit
    call f_start
    call f_stop
    call cmp_sign

    cmp rax, 0
    jne .root_exist

    print_str no_root

    .root_exist:

    movsxd rcx, [iters]
    .loop:
        call f_center
        call check_eps
        cmp rax, 1
        je .root_finded

        ffree st0


        call f_center
        call f_stop
        call cmp_sign
        cmp rax, 1
        je .root_right
        call load_center
        fstp [stop]
        jmp .end_loop
        .root_right:
        call load_center
        fstp [start]
        .end_loop:



    dec rcx
    cmp rcx, 0
    jg .loop

    print_str no_luck
    jmp .end

    .root_finded:

    call load_center

    lea rdi, [output_ans]
    movsxd rsi, [iters]
    sub rsi, rcx
    inc rsi
    call print_res

    .end:
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
    buf dd ?


section '.rodata'
    EPS dq 0.00001
    store_str func, 'Функция к поиску корня: ...'
    store_str input_start, 'Введите начало отрезка: '
    store_str input_stop, 'Введите конец отрезка: '
    store_str input_iters, 'Введите количество итераций: '
    store_str input_error, 'Ошибка ввода!'
    store_str output_ans, 'Найденный корень уравнения: %lf за %d итераций'


    store_str t1, 'а: %lf'
    store_str t2, 'б: %lf'
    store_str t3, 'Произведение: %lf на %d итерации'

    store_str no_root, 'Нет корней на заданном отрезке!'
    store_str no_luck, 'Не удалось найти корень за данное количество итераций!'

    lf_format db '%lf', 0
    d_format db '%d', 0

