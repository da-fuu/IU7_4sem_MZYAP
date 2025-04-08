; rdi out   rsi in   rdx len

format ELF64 
public copy

section '.text' executable
copy:
    mov rcx, rdx
    inc rcx
    cld
    rep movsb
    ret 



