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


macro syscall0 ; макрос сискола без аргументов
{
    push rcx
    syscall
    pop rcx
}

macro syscall1 a ; макрос сискола из 1 аргумента (номера функции)
{
    push rax
    mov rax, a
    syscall0
    pop rax
}

macro syscall2 a,b ; макрос сискола из 2 аргументов (первый - номер функции)
{
    push rdi
    mov rdi, b
    syscall1 a
    pop rdi
}

macro syscall3 a,b,c ; макрос сискола из 3 аргументов (первый - номер функции)
{
    push rsi
    mov rsi, c
    syscall2 a,b
    pop rsi
}

macro syscall4 a,b,c,d ; макрос сискола из 4 аргументов (первый - номер функции)
{
    push rdx
    mov rdx, d
    syscall3 a,b,c
    pop rdx
}


struc rect x,y,w,h
{
    .x dd x
    .y dd y
    .w dd w
    .h dd h
}

section '.text' executable

main:
    sub rsp, 8
    mov rdi, 800
    mov rsi, 600
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
	syscall2 0x3C,0

mainloop:
    mov rdi, 0
    mov rsi, 16
    mov rdx, 200
    call GuiSetStyle


    mov rdi, label_text

    movq xmm0, [label_rect]     
    movq xmm1, [label_rect + 8] 

    call GuiLabel
    ret

section '.rodata'
    name db 'Гоол', 0
    label_text db 'GOIDA', 0
    label_rect rect 24.0, 48.0, 800.0, 60.0

