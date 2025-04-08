#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern void copy(char *out, const char *in, int length);

int len(const char *str)
{
__asm__(
        "mov al, 0\n"
        "mov rcx, -1\n"
        "mov rsi, rdi\n"
        "cld\n"
        "repne scasb\n"
        "sub rdi, rsi\n"
        "mov rax, rdi\n"
        "dec rax\n"
        "pop rbp\n"
        "ret\n"
        );
}

int main(void)
{
    const char *str = "rvjvj";
    int my_len = len(str);
    printf("Библиотека: %d\nМоё: %d\n", (int)strlen(str), my_len);

    char *new_str = malloc(my_len * sizeof(char));
    copy(new_str, str, my_len);
    printf("Начальная строка: %s\nКопия: %s\n", str, new_str);
    
    return 0;
}
