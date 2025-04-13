#include <x86intrin.h>
#include "opsfp.h"

unsigned long long hard_addf(float a, float b)
{
    unsigned long long start = __rdtsc();

    float c = a + b;

    unsigned long long stop = __rdtsc(); 

    return stop - start;
}

unsigned long long hard_addd(double a, double b)
{
    unsigned long long start = __rdtsc();

    double c = a + b;

    unsigned long long stop = __rdtsc();

    return stop - start;
}

unsigned long long hard_mulf(float a, float b)
{
    unsigned long long start = __rdtsc();

    float c = a * b;

    unsigned long long stop = __rdtsc();

    return stop - start;
}

unsigned long long hard_muld(double a, double b)
{
    unsigned long long start = __rdtsc();

    double c = a * b;

    unsigned long long stop = __rdtsc();

    return stop - start;
}