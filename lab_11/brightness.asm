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
    
    vpshufd xmm1, xmm0, 01001110b
    vpackuswb xmm0, xmm0, xmm1 
    
    vmovq qword [rdi], xmm0
}

macro move_to_stack
{
    cld
    mov rcx, rdx
    mov rax, rdi
    mov rsi, rdi
    mov rdi, rsp
    rep movsb      
    mov rdi, rsp
}

macro move_from_stack
{
    mov rcx, rdx
    mov rsi, rsp
    mov rdi, rax 
    rep movsb
}


macro decrease_brightness
{
    vaddss xmm0, xmm0, xmm0
    vbroadcastss ymm2, xmm0
    
    mov rcx, rsi
    .loop_dec:
 
        unpack
        vmulps ymm1, ymm1, ymm2
        pack
        
        add rdi, 8
    loop .loop_dec
    
    cmp rdx, 0
    je .end_dec     
        move_to_stack
        
        unpack
        vmulps ymm1, ymm1, ymm2
        pack
           
        move_from_stack
            
    .end_dec:
}

macro increase_brightness
{
    mov dword [rsp], 2.0
    vmovss xmm1, dword [rsp]
    
    vmulss xmm0, xmm0, xmm1
    vsubss xmm0, xmm1, xmm0

    vbroadcastss ymm2, xmm0
    
    mov dword [rsp], 255.0
    vbroadcastss ymm3, dword [rsp]
        
    mov rcx, rsi
    .loop_inc:
    
        unpack
        vsubps ymm1, ymm3, ymm1
        vmulps ymm1, ymm1, ymm2
        vsubps ymm1, ymm3, ymm1
        pack
        
        add rdi, 8
    loop .loop_inc
    
    cmp rdx, 0
    je .end_inc     
        move_to_stack
        
        unpack
        vsubps ymm1, ymm3, ymm1
        vmulps ymm1, ymm1, ymm2
        vsubps ymm1, ymm3, ymm1
        pack
           
        move_from_stack
            
    .end_inc:
}

change_brightness_asm:
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
    mov rsp, rbp
    pop rbp
    ret
