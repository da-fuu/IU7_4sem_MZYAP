#include <stdio.h>
#include <stdlib.h>
#include "opsfp.h"

#define TESTS 3000000

double randd(void)
{
    return ((double)rand() / ((double)RAND_MAX + 1) * 1000.0) - 500.0;
}


unsigned long long runf(unsigned long long (*func)(float, float))
{
    unsigned long long temp = 0;

    for (int i = 0; i < TESTS; i++)
    {
        temp += func(randd(), randd());
    }
    
    return temp / TESTS;
}

unsigned long long rund(unsigned long long (*func)(double, double))
{
    unsigned long long temp = 0;

    for (int i = 0; i < TESTS; i++)
    {
        temp += func(randd(), randd());
    }
    
    return temp / TESTS;
}


int main()
{
    double a = 1.4, b = 3.3;

    unsigned long long ans[12] = { 0 };

    ans[0] = runf(hard_addf);
    ans[1] = rund(hard_addd);
    
    ans[2] = runf(hard_mulf);
    ans[3] = rund(hard_muld);
    
    
    ans[4] = runf(soft_addf);
    ans[5] = rund(soft_addd);
    
    ans[6] = runf(soft_mulf);
    ans[7] = rund(soft_muld);
    
    
    ans[8] = runf(asm_addf);
    ans[9] = rund(asm_addd);
    
    ans[10] = runf(asm_mulf);
    ans[11] = rund(asm_muld);

    printf("Результаты замеров (в тиках):\n");
    printf("| Способ |    Сложение     |    Умножение    |\n");
    printf("|        | float  | double | float  | double |\n");
    printf("|  FPU   | %6llu | %6llu | %6llu | %6llu |\n", ans[0], ans[1], ans[2], ans[3]);
    printf("| SoftFP | %6llu | %6llu | %6llu | %6llu |\n", ans[4], ans[5], ans[6], ans[7]);
    printf("|  ASM   | %6llu | %6llu | %6llu | %6llu |\n", ans[8], ans[8], ans[10], ans[11]);
    

    return 0;    
}