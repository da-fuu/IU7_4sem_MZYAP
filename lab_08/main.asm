format ELF64

public main

extrn InitWindow
extrn WindowShouldClose
extrn BeginDrawing
extrn EndDrawing
extrn CloseWindow
extrn SetTargetFPS
extrn GuiLabel
extrn GuiSetStyle
extrn GuiValueBox
extrn ClearBackground
extrn sprintf

struc rect x,y,w,h
{
    .x dd x
    .y dd y
    .w dd w
    .h dd h
}

macro pass_rect r
{
    movq xmm0, [r]     
    movq xmm1, [r + 8] 
    mov rax, 2
}

section '.text' executable

main:
    sub rsp, 8
    mov rdi, 700
    mov rsi, 200
    mov rdx, name
    call InitWindow

    mov rdi, 60
    call SetTargetFPS

    .loop:

    call WindowShouldClose
    cmp rax, 0
    jne .exit

    call BeginDrawing

    call mainloop

    call EndDrawing

    jmp .loop

    .exit:
    call CloseWindow
    add rsp, 8
    mov rdi, 0
    mov rax, 0x3C
	syscall

mainloop:
    sub rsp, 8

    mov rdi, 0
    mov rsi, 16
    mov rdx, 30
    call GuiSetStyle

    mov rdi, 0
    call ClearBackground

    mov rdi, input_text
    mov rsi, val
    mov rdx, 0
    mov rcx, 0
    mov r8, 1
    pass_rect input_rect
    call GuiValueBox

    cmp [val], 0
    jge .ok
    neg [val]
    .ok:

    mov edi, [val]
    cmp edi, 0
    je .zero
    dec edi
    bsr eax, edi
    jz .zero
    inc eax
    mov [ans], eax
    jmp .skip
    .zero:
    mov [ans], 0
    .skip:

    mov rdi, buf
    mov rsi, output_text_fmt
    mov rdx, 0
    mov eax, [ans]
    bts edx, eax
    call sprintf

    mov rdi, buf
    pass_rect output_rect
    call GuiLabel

    add rsp, 8
    ret


section '.data' writable
    val dd 0
    ans dd 1

section '.bss' writable
    buf db 30 dup ?

section '.rodata'
    name db 'Лабораторная работа №8 Жаринов МА', 0
    input_text db 'Input num: ', 0
    input_rect rect 200.0, 50.0, 400.0, 60.0

    output_text_fmt db 'Answer: %10u', 0
    output_rect rect 200.0, 115.0, 400.0, 60.0


