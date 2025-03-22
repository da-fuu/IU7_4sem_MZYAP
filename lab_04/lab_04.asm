; r9	; 6th param
; r8	; 5th param
; r10	; 4th param
; rdx	; 3rd param
; rsi	; 2nd param
; rdi	; 1st param
; eax	; syscall_number

format ELF64 
public _start    

maxlen equ 9
maxlen_str equ '9'
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
    mov rax,a
    syscall0
    pop rax
}

macro syscall2 a,b ; макрос сискола из 2 аргументов (первый - номер функции)
{
    push rdi
    mov rdi,b
    syscall1 a
    pop rdi
}

macro syscall3 a,b,c ; макрос сискола из 3 аргументов (первый - номер функции)
{
    push rsi
    mov rsi,c
    syscall2 a,b
    pop rsi
}

macro syscall4 a,b,c,d ; макрос сискола из 4 аргументов (первый - номер функции)
{
    push rdx
    mov rdx,d
    syscall3 a,b,c
    pop rdx
}

macro print msg ; макрос печатает строку, аргумент - указатель на строку, обязана быть переменная с названием ptr_size
{
    push rbx
    mov rbx,msg
    push rcx
    mov rcx,msg#_size
    call print_str
	pop rcx
	pop rbx
}

macro exit code ; макрос осуществляет выход из программы, аргумент - код возврата
{
	syscall2 0x3C,code
}

macro getaddr row,col ; сохраняет адрес элемента в rbx
{
    imul rbx,row,maxlen
    lea rbx,[matrix+rbx+col]
}

macro getelem row,col,out ; записывает элемент по индексам из первых 2 операндов в третий операнд
{
    push rbx
    getaddr row,col
    mov out,[rbx]
    pop rbx
}

macro setelem row,col,in ; записывает в элемент по индексам из первых 2 операндов третий операнд
{
    push rbx
    getaddr row,col
    mov [rbx],in
    pop rbx
}

macro for reg,start,stop ; начало c-style цикла
{
    mov reg,start
    .#reg#_again:
    cmp reg, stop
    jge .#reg#_over
}
macro endfor reg ; конец c-style цикла
{
    inc reg
    jmp .#reg#_again
    .#reg#_over:
}


section '.text' executable

read_char: ; функция чтения символа в буфер
    syscall4 0x0,0,byte_buf,1
    ret

read_num: ; функция читает число в rdx и пропускает один символ
    call read_char
    movzx rdx,[byte_buf]
    sub rdx,'0'
    call read_char
    ret
    
write_char: ; функция печати символа из dl
    mov [byte_buf],dl
    syscall4 0x1,1,byte_buf,1
    ret
    
print_str: ; вспомогательная функция для макроса печати строки
	syscall4 0x1,1,rbx,rcx
    ret
        
read_dims: ; функция читает колчество строк и столбцов в переменные rows и cols
    print in_rows
    call read_num
    mov [rows],rdx
    
	print in_cols
    call read_num
    mov [cols],rdx
    ret

read_matr: ; функция читает матрицу в переменную matrix, размер читает из переменных rows и cols
    print in_matr
    
    for rsi,0,[rows]
        for rdi,0,[cols]
            call read_num
            setelem rsi,rdi,dl
        endfor rdi
    endfor rsi
  
    ret
    
exchange_elems: ; функция изменяет матрицу в переменной matrix по заданию
    mov rax,[cols]
    mov cl,2
    div cl
    mul cl
    movzx rcx,al
    
    for rsi,0,[rows]
        for rdi,0,rcx
            getaddr rsi,rdi
            mov dl,[rbx]
            mov rax,rbx
            inc rdi
            getaddr rsi,rdi
            xchg dl,[rbx]
            mov [rax],dl
        endfor rdi
    endfor rsi
    
    ret
    
print_matr: ; функция печатает матрицу в переменной matrix
    print out_matr
     
    for rsi,0,[rows]
        for rdi,0,[cols]
            getelem rsi,rdi,dl
            add dl,'0'
            call write_char
            mov dl,' ' 
            call write_char
            
        endfor rdi
        mov dl,newline  
        call write_char
    endfor rsi 
        
    ret

_start: ; точка входа
    call read_dims
    
    call read_matr
    
    call exchange_elems
    
    call print_matr
    
    exit 0


section '.rodata'

in_rows db 'Введите количество строк матрицы от 1 до ', maxlen_str, ':', newline
in_rows_size = $-in_rows

in_cols db 'Введите количество столбцов матрицы от 1 до ', maxlen_str, ':', newline
in_cols_size = $-in_cols

in_matr db 'Введите элементы матрицы - цифры через 1 разделитель:', newline
in_matr_size = $-in_matr

out_matr db 'Получившаяся матрица:', newline
out_matr_size = $-out_matr


section '.bss' writeable

rows dq ?
cols dq ?

matrix_size = maxlen * maxlen

matrix db matrix_size dup ?

byte_buf db ?
