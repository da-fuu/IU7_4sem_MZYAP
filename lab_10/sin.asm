format ELF64 

public main

extrn 'printf' as _printf
printf equ PLT _printf


macro store_str name,str&
{
    name db str, 10, 0
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

main:
    sub rsp, 8

    fld [PI_BAD]
    fsin
    lea rdi, [bad]   
    call print_res

    fld [PI_MID]
    fsin
    lea rdi, [mid]
    call print_res

    fldpi
    fsin
    lea rdi, [best]
    call print_res

    mov [rsp], word 2 

    fld [PI_BAD]
    fild word [rsp]
    fdivp
    fsin
    lea rdi, [bad2]
    call print_res

    fld [PI_MID]
    fild word [rsp]
    fdivp
    fsin
    lea rdi, [mid2]
    call print_res

    fldpi
    fild word [rsp]
    fdivp
    fsin
    lea rdi, [best2]
    call print_res

    add rsp, 8
    mov rax, 0
    ret

section '.rodata'
    PI_BAD dt 3.14
    PI_MID dt 3.141596
    
    store_str bad, 'Результат вычисления sin(pi) для 3.14: %.10lf'
    store_str mid, 'Результат вычисления sin(pi) для 3.141596: %.10lf'
    store_str best, 'Результат вычисления sin(pi) для встроенного значения: %.10lf'
    store_str bad2, 'Результат вычисления sin(pi/2) для 3.14: %.10lf'
    store_str mid2, 'Результат вычисления sin(pi/2) для 3.141596: %.10lf'
    store_str best2, 'Результат вычисления sin(pi/2) для встроенного значения: %.10lf'
