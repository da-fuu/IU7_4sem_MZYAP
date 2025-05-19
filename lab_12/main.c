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

double dot(const double *a, const double *b, size_t l)
{
    double out;
__asm__ volatile (
        "fmov d3, xzr\n"
        "dup v3.2d, v3.d[0]\n"
        "loop_neon:\n"
        "ld1 {v1.2d}, [%x[a]], #16\n"
        "ld1 {v2.2d}, [%x[b]], #16\n"
        "fmla v3.2d, v1.2d, v2.2d\n"
        "sub %x[l], %x[l], #2\n"
        "cmp %x[l], #1\n"
        "bgt loop_neon\n"
        "faddp %d[out], v3.2d\n"
        "cbz %x[l], end\n"
        "ld1 {v1.1d}, [%x[a]]\n"
        "ld1 {v2.1d}, [%x[b]]\n"
        "fmla %d[out], d1, v2.d[0]\n"
        "end:\n"
        : [out] "=&w" (out)
        : [a] "r" (a), [b] "r" (b), [l] "r" (l)
        : "memory", "v1", "v2", "v3"
    );
    return out;
}


int main(void) {
    const char *str = "Aboba";
    printf("Длина строки \'%s\' = %zu\n", str, len(str));

    double a[] = {0, 1, 2, 3, -4.2};
    double b[] = {0.5, 0.1, 2.4, 3.0, 0.7};

    double prod = dot(a, b, 5);

    printf("Скалярное произведение векторов a и b = %f\n", prod);
    
    return 0;
}
