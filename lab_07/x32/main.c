#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern void copy(char *out, const char *in, size_t length);

size_t len(const char *str)
{
__asm__(
        "mov al, 0\n"
        "mov ecx, -1\n"
        "push edi\n"
        "mov edi, dword ptr [ebp+8]\n"
        "cld\n"
        "repne scasb\n"
        "sub edi, dword ptr [ebp+8]\n"
        "mov eax, edi\n"
        "dec eax\n"
        "pop edi\n"
        "pop ebp\n"
        "ret\n"
        );
}

int main(void)
{
    const char *str = "Test string";
    size_t my_len = len(str);
    printf("Длина: %zu\nМоей функцией: %zu\n", strlen(str), my_len);

    char *new_str = malloc(my_len * sizeof(char));
    copy(new_str, str, my_len);
    printf("Начальная строка: %s\nКопия: %s\n", str, new_str);
    free(new_str);
    return 0;
}
