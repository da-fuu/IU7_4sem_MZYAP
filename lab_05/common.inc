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
    name db str, newline
    name#_size = $-name
}

macro print_str msg ; макрос печатает строку, аргумент - указатель на строку, обязана быть переменная с названием ptr_size
{
    push rbx
    mov rbx, msg
    push rcx
    mov rcx, msg#_size
    call print_str_func
	pop rcx
	pop rbx
}

if ~ defined is_def
    extrn no_num_error_str
    extrn no_num_error_str_size
    extrn print_str_func
else 
    public no_num_error_str
    public no_num_error_str_size
    public print_str_func
end if
