#include <x86intrin.h>
#include "opsfp.h"

unsigned long long asm_addf(float a, float b)
{
    float c;
    
    unsigned long long start = __rdtsc();

    for (int i = 0; i < INSIDE; ++i)
    {
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
    }

    unsigned long long stop = __rdtsc();

    return stop - start;
}

unsigned long long asm_addd(double a, double b)
{
    double c;
    
    unsigned long long start = __rdtsc();
    
    for (int i = 0; i < INSIDE; ++i)
    {
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
    }

    unsigned long long stop = __rdtsc();

    return stop - start;
}

unsigned long long asm_mulf(float a, float b)
{
    float c;
    
    unsigned long long start = __rdtsc();

    for (int i = 0; i < INSIDE; ++i)
    {
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
    }

    unsigned long long stop = __rdtsc();

    return stop - start;
}

unsigned long long asm_muld(double a, double b)
{
    double c;
    
    unsigned long long start = __rdtsc();
    
    for (int i = 0; i < INSIDE; ++i)
    {
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
        __asm__ volatile (
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp  %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
                : "st", "st(1)"
                );
    }

    unsigned long long stop = __rdtsc();

    return stop - start;
}