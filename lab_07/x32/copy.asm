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
    inc ecx
    cld
    rep movsb
    
    pop esi
    pop edi
    pop ebp
    ret 

