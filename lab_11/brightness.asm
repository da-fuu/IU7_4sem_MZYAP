format ELF64 

public change_brightness_asm

; rdi data   rsi len   xmm0 bright
section '.text' executable
   
macro unpack ; загружает в ymm1 8 байт по адресу rdi в виде float
{
    vpmovzxbd ymm0, qword [rdi]
    vcvtdq2ps ymm1, ymm0
}

macro pack ; выгружает из ymm1 8 float в 8 байт по адресу rdi
{
    vcvtps2dq ymm0, ymm1
        
    vextracti128 xmm1, ymm0, 1
    vpackusdw xmm0, xmm0, xmm1
    vpackuswb xmm0, xmm0, xmm0 
    
    vmovq qword [rdi], xmm0
}

macro move_to_stack ; копирует rdx байт из [rdi] в [rsp], сохраняет rdi в rax, rsp в rdi, измененные регистры - rcx, rsi
{
    mov dword [rsp], 0

    cld
    mov rcx, rdx
    mov rax, rdi
    mov rsi, rdi
    mov rdi, rsp
    rep movsb      
    mov rdi, rsp
}

macro move_from_stack ; копирует rdx байт из [rsp] в [rax], измененные регистры - rcx, rsi, rdi
{
    cld
    mov rcx, rdx
    mov rsi, rsp
    mov rdi, rax 
    rep movsb
}


macro apply_linear_to_8 ; применяет функцию ymm2 * x + ymm3, вход и выход - 8 байт в [rdi], измененные регистры - ymm0-1
{
    unpack
    vfmadd213ps ymm1, ymm2, ymm3
    pack
}

macro apply_linear ; применяет функцию ymm2 * x + ymm3, вход и выход - rsi*8 + rdx байт в [rdi], измененные регистры - много
{
    .loop_#mode:
        apply_linear_to_8
    add rdi, 8
    dec rsi
    jnz .loop_#mode
    
    cmp rdx, 0
    je .end_#mode     
        move_to_stack
        apply_linear_to_8
        move_from_stack
            
    .end_#mode:
}

macro decrease_brightness ; уменьшает яркость до xmm0 в массиве, вход и выход - rsi*8 + rdx байт в [rdi], измененные регистры - много
{
    vaddss xmm0, xmm0, xmm0
    vbroadcastss ymm2, xmm0
    vpxor ymm3, ymm3, ymm3
}

macro increase_brightness ; увеличивает яркость до xmm0 в массиве, вход и выход - rsi*8 + rdx байт в [rdi], измененные регистры - много
{
    mov dword [rsp], 2.0
    vmovss xmm1, dword [rsp]
    
    vmulss xmm0, xmm0, xmm1
    vsubss xmm0, xmm1, xmm0

    vbroadcastss ymm2, xmm0
    
    mov dword [rsp], 255.0
    vbroadcastss ymm3, dword [rsp]
    vmulps ymm0, ymm3, ymm2
    vsubps ymm3, ymm3, ymm0
}

change_brightness_asm: ; SysV abi функция (uint8_t *data, size_t len, float brightness)
    push rbp
    mov rbp, rsp
    
    sub rsp, 8
    and rsp, -32
    
    mov rdx, rsi
    shr rsi, 3
    and rdx, 111b
    
    mov dword [rsp], 0.5

    vucomiss xmm0, dword [rsp]
    ja .increase
    
        decrease_brightness
        jmp .end
    
    .increase:
        increase_brightness
    
    .end:
    apply_linear
    
    mov rsp, rbp
    pop rbp
    ret
