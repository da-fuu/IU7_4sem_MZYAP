format ELF64 
public main
extrn printf


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
print_res:
    sub rsp, 8
    fstp  qword  [rsp]
    movsd   xmm0, qword [rsp]  
    call printf
    add rsp, 8
    ret

main:
    sub rsp, 8

    fld [PI_BAD]
    fsin
    mov rdi, bad
    call print_res

    fld [PI_MID]
    fsin
    mov rdi, mid
    call print_res

    fldpi
    fsin
    mov rdi, best
    call print_res


    fld [PI_BAD]
    fdiv [TWO]
    fsin
    mov rdi, bad2
    call print_res

    fld [PI_MID]
    fdiv [TWO]
    fsin
    mov rdi, mid2
    call print_res

    fldpi
    fdiv [TWO]
    fsin
    mov rdi, best2
    call print_res

    add rsp, 8
    exit 0

section '.rodata'
    PI_BAD dt 3.14
    PI_MID dt 3.141596

    TWO dq 2.0

    store_str bad, 'Результат вычисления sin(pi) для 3.14: %.10lf'
    store_str mid, 'Результат вычисления sin(pi) для 3.141596: %.10lf'
    store_str best, 'Результат вычисления sin(pi) для встроенного значения: %.10lf'
    store_str bad2, 'Результат вычисления sin(pi/2) для 3.14: %.10lf'
    store_str mid2, 'Результат вычисления sin(pi/2) для 3.141596: %.10lf'
    store_str best2, 'Результат вычисления sin(pi/2) для встроенного значения: %.10lf'
