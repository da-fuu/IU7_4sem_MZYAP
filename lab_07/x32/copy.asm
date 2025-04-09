format ELF
public copy

section '.text' executable
copy:
    push ebp
    mov ebp, esp
    push edi
    push esi

    mov edi, dword [ebp+8]
    mov esi, dword [ebp+12]
    mov ecx, dword [ebp+16]
    
    cmp esi, edi
    jb .backwards
    inc ecx
    cld
    rep movsb
    jmp .end
    .backwards:
    add esi, ecx
    add edi, ecx
    inc ecx
    std
    rep movsb
    
    .end:
    pop esi
    pop edi
    pop ebp
    ret 

