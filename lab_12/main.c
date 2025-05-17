#include <stdio.h>
#include <stddef.h>

size_t len(const char *str)
{
    size_t ans;
__asm__ volatile (
        "mov %x[ans], #-1\n"
        "loop_len:\n"
        "ldrb w1, [%x[str]], #1\n"
        "add %x[ans], %x[ans], #1\n"
        "cbnz w1, loop_len\n"
        : [ans] "=&r" (ans)
        : [str] "r" (str)
        : "w1", "memory"
    );
    return ans;
}

float dot(const float *a, const float *b, size_t l)
{
    float out;
__asm__ volatile (
        "fmov s2, wzr\n"
        "dup v2.4s, v2.s[0]\n"
        "loop_neon:\n"
        "ld1 {v0.4s}, [%x[a]], #16\n"
        "ld1 {v1.4s}, [%x[b]], #16\n"
        "fmla v2.4s, v0.4s, v1.4s\n"
        "subs %x[l], %x[l], #4\n"
        "bgt loop_neon\n"
        "faddp v0.4s, v2.4s, v2.4s\n"
        "faddp s0, v0.2s\n"
        "str s0, %x[out]\n"
        : [out] "=m" (out)
        : [a] "r" (a), [b] "r" (b), [l] "r" (l)
        : "memory"
    );
}



int main(void) {
    const char *str = "Aboba";
    printf("Длина строки \'%s\' = %zu\n", str, len(str));

    float a[] = {0, 1, 2, 3};
    float b[] = {0.5, 0.1, 2.4, 3.0};

    float prod = dot(a, b, 4);

    printf("Скалярное произведение векторов a и b = %f\n", prod);
    
    return 0;
}
