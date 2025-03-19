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

macro syscall1 a ; макрос сискола из 1 аргумента (номера функции)
{
    mov rax,a
    syscall
}

macro syscall2 a,b ; макрос сискола из 2 аргументов (первый - номер функции)
{
    mov rdi,b
    syscall1 a
}

macro syscall3 a,b,c ; макрос сискола из 3 аргументов (первый - номер функции)
{
    mov rsi,c
    syscall2 a,b
}

macro syscall4 a,b,c,d ; макрос сискола из 4 аргументов (первый - номер функции)
{
    mov rdx,d
    syscall3 a,b,c
}

macro print msg ; макрос печатает строку, аргумент - указатель на строку, обязана быть переменная с названием ptr_size
{
	syscall4 0x1,1,msg,msg#_size
}

macro write chr ; макрос печатает один символ, аргумент - однобайтный регистр или константа
{
    mov [byte_buf],chr
	syscall4 0x1,1,byte_buf,1
}

macro exit code ; макрос осуществляет выход из программы, аргумент - код возврата
{
	syscall2 0x3C,code
}


section '.text' executable

read_num: ; функция читает число в r9b и пропускает один символ
    syscall4 0x0,0,byte_buf,1
    mov r9b,[byte_buf]
    sub r9b,'0'
    syscall4 0x0,0,byte_buf,1
    ret

read_dims: ; функция читает колчество строк и столбцов в переменные rows и cols
    print in_rows
    call read_num
    mov [rows],r9b
    
	print in_cols
    call read_num
    mov [cols],r9b
    ret

read_matr: ; функция читает матрицу в переменную matrix, размер читает из переменных rows и cols
    print in_matr
    
    mov al,[rows]
    mul [cols]
    mov r12b,al ; индекс элемента
    mov rbx,matrix
    .elem_loop:
        call read_num
        mov [rbx],r9b
        inc rbx
        dec r12b
        cmp r12b,0
        ja .elem_loop
    ret
    
exchange_elems: ; функция изменяет матрицу в переменной matrix по заданию
    mov rbx,matrix
    mov r12b,[rows]
    .row_loop:
        mov r13b,[cols]
        .col_loop:
            inc rbx
            cmp r13b,1
            jbe .break_loop
            
            mov dl,[rbx-1]
            xchg dl,[rbx]
            mov [rbx-1],dl
            inc rbx
            sub r13b,2
            cmp r13b,0
            ja .col_loop   
        .break_loop:  
        dec r12b
        cmp r12b,0
        ja .row_loop 
    ret
    
print_matr: ; функция печатает матрицу в переменной matrix
    print out_matr
        
    mov rbx,matrix
    mov r12b,[rows]
    .row_loop:
        mov r13b,[cols]
        .col_loop:
            mov dl,[rbx]
            add dl,'0'
            write dl
            write ' '
            
            inc rbx
            dec r13b
            cmp r13b,0
            ja .col_loop    
        
        write 10  
        dec r12b
        cmp r12b,0
        ja .row_loop
    ret

_start: ; точка входа
    call read_dims
    
    call read_matr
    
    call exchange_elems
    
    call print_matr
    
    exit 0


section '.rodata'

in_rows db 'Введите количество строк матрицы от 1 до 9:', 10
in_rows_size = $-in_rows

in_cols db 'Введите количество столбцов матрицы от 1 до 9:', 10
in_cols_size = $-in_cols

in_matr db 'Введите элементы матрицы - цифры через 1 разделитель:', 10
in_matr_size = $-in_matr

out_matr db 'Получившаяся матрица:', 10
out_matr_size = $-out_matr


section '.bss' writeable

rows db ?
cols db ?

matrix_size = maxlen * maxlen

matrix db matrix_size dup ?

byte_buf db ?
