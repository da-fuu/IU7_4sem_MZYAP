#include <x86intrin.h>
#include "opsfp.h"

unsigned long long hard_addf(float a, float b)
{
    float c;
    
    unsigned long long start = __rdtsc();

    for (int i = 0; i < INSIDE; ++i)
    {
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
    }   

    unsigned long long stop = __rdtsc(); 

    return stop - start;
}

unsigned long long hard_addd(double a, double b)
{
    double c;
    
    unsigned long long start = __rdtsc();

    for (int i = 0; i < INSIDE; ++i)
    {
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
        c = a + b;
    }   

    unsigned long long stop = __rdtsc();

    return stop - start;
}

unsigned long long hard_mulf(float a, float b)
{
    float c;
    
    unsigned long long start = __rdtsc();

    for (int i = 0; i < INSIDE; ++i)
    {
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
    }   

    unsigned long long stop = __rdtsc();

    return stop - start;
}

unsigned long long hard_muld(double a, double b)
{
    double c;
    
    unsigned long long start = __rdtsc();

    for (int i = 0; i < INSIDE; ++i)
    {
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
        c = a * b;
    }   

    unsigned long long stop = __rdtsc();
    
    return stop - start;
}