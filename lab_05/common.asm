format ELF64 

public read_char
public write_char

label is_def
include 'common.inc'


section '.text' executable

print_str_func: ; вспомогательная функция для макроса печати строки
	syscall4 0x1,1,rbx,rcx
    ret

read_char: ; функция чтения символа в dl
    syscall4 0x0, 0, byte_buf, 1
    mov dl, [byte_buf]
    ret

write_char: ; функция печати символа из al
    mov [byte_buf], al
    syscall4 0x1, 1, byte_buf, 1
    ret

section '.bss' writeable
    byte_buf db ?

section '.rodata' 
    store_str no_num_error_str, 'Число еще не введено!'
