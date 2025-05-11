format ELF64 

public change_brightness_asm

; rdi data   rsi len   xmm0 bright
section '.text' executable
change_brightness_asm:
    sub rsp, 4
    
    mov rdx, rsi
    shr rsi, 3
    and rdx, 111b
    
    mov dword [rsp], 0.5

    comiss xmm0, dword [rsp]
    ja .increase
    
    call decrease
    jmp .end
    
    .increase:
    call increase
    
    .end:
    add rsp, 4
    ret
  
decrease:
    vaddss xmm0, xmm0, xmm0
    vbroadcastss ymm2, xmm0
    
    mov rcx, rsi
    .loop:
    
    call unpack
    
    vmulps ymm1, ymm1, ymm2
    
    call pack
    
    add rdi, 8
    
    loop .loop
    
    cmp rdx, 0
    je .end
        sub rsp, 8
        
        mov rcx, rdx
        
        mov rax, rdi
        mov rsi, rdi
        mov rdi, rsp
        cld
        rep movsb      
        
        mov rdi, rsp
        
        call unpack
        vmulps ymm1, ymm1, ymm2
        call pack
           
        mov rcx, rdx
        mov rdi, rax 
        mov rsi, rsp
        rep movsb
        
        add rsp, 8
    
    .end:
    ret

increase:
    sub rsp, 4
    mov dword [rsp], 2.0
    movss xmm1, dword [rsp]
    
    vmulss xmm0, xmm0, xmm1
    vsubss xmm0, xmm1, xmm0

    vbroadcastss ymm2, xmm0
    
    mov dword [rsp], 255.0
    vbroadcastss ymm3, dword [rsp]
    
    add rsp, 4
    
    mov rcx, rsi
    .loop:
    
    call unpack
    
    vsubps ymm1, ymm3, ymm1
    vmulps ymm1, ymm1, ymm2
    vsubps ymm1, ymm3, ymm1
    
    call pack
    
    add rdi, 8
    
    loop .loop
    
    cmp rdx, 0
    je .end
        sub rsp, 8
        
        mov rcx, rdx
        
        mov rax, rdi
        mov rsi, rdi
        mov rdi, rsp
        cld
        rep movsb      
        
        mov rdi, rsp
        
        call unpack
        vsubps ymm1, ymm3, ymm1
        vmulps ymm1, ymm1, ymm2
        vsubps ymm1, ymm3, ymm1
        call pack
           
        mov rcx, rdx
        mov rdi, rax 
        mov rsi, rsp
        rep movsb
        
        add rsp, 8
    
    .end:
    ret
    
    
unpack: ; загружает в ymm1 8 байт по адресу rdi в виде float
    vpmovzxbd ymm0, qword [rdi]
    vcvtdq2ps ymm1, ymm0
    ret
    
pack: ; выгружает из ymm1 8 float в 8 байт по адресу rdi
    vcvtps2dq ymm0, ymm1
        
    vextracti128 xmm1, ymm0, 1
    vpackusdw xmm0, xmm0, xmm1
    
    vpshufd xmm1, xmm0, 0x4E
    vpackuswb xmm0, xmm0, xmm1 
    
    vmovq qword [rdi], xmm0
    ret

