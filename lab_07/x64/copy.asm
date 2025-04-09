; rdi out   rsi in   rdx len

format ELF64 
public copy

section '.text' executable
copy:
    mov rcx, rdx
    
    cmp rsi, rdi
    jb .backwards
    inc rcx
    cld
    rep movsb
    jmp .end
    .backwards:
    add rsi, rcx
    add rdi, rcx
    inc rcx
    std
    rep movsb
    .end:
    ret 



