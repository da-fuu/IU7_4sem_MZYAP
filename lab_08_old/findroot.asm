format ELF64 
public main
extrn printf
extrn scanf


newline equ 10

macro syscall0 ; макрос сискола без аргументов
{
    push rcx
    syscall
    pop rcx
}

macro syscall1 a ; макрос сискола из 1 аргумента (номера функции)
{
    push rax
    mov rax, a
    syscall0
    pop rax
}

macro syscall2 a,b ; макрос сискола из 2 аргументов (первый - номер функции)
{
    push rdi
    mov rdi, b
    syscall1 a
    pop rdi
}

macro syscall3 a,b,c ; макрос сискола из 3 аргументов (первый - номер функции)
{
    push rsi
    mov rsi, c
    syscall2 a,b
    pop rsi
}

macro syscall4 a,b,c,d ; макрос сискола из 4 аргументов (первый - номер функции)
{
    push rdx
    mov rdx, d
    syscall3 a,b,c
    pop rdx
}

macro store_str name,str&
{
    name db str, newline, 0
    name#_size = $-name
}

macro print_str msg ; макрос печатает строку, аргумент - указатель на строку, обязана быть переменная с названием ptr_size
{
	syscall4 0x1,1,msg,msg#_size
}

macro exit rc
{
	syscall2 0x3C,rc
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

    mov rdi, lf_format
    mov rsi, start
    call scanf
    cmp rax, 1
    jne .error

    print_str input_stop

    mov rdi, lf_format
    mov rsi, stop
    call scanf
    cmp rax, 1
    jne .error

    print_str input_iters
    
    mov rdi, d_format
    mov rsi, iters
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


    mov rdi, output_ans
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
    exit rax


section '.bss' writable
    start dq ?
    stop dq ?
    iters dd ?


section '.rodata'
    store_str func, 'Функция к поиску корня: ...'
    store_str input_start, 'Введите начало отрезка: '
    store_str input_stop, 'Введите конец отрезка: '
    store_str input_iters, 'Введите количество итераций: '
    store_str nl, ''
    store_str input_error, 'Ошибка ввода!'
    store_str output_ans, 'Найденный корень уравнения: %lf'

    lf_format db '%lf', 0
    d_format db '%d', 0

