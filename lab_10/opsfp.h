#pragma once

#define TESTS 3000
#define INSIDE 1000


unsigned long long hard_addf(float a, float b);
unsigned long long hard_addd(double a, double b);

unsigned long long hard_mulf(float a, float b);
unsigned long long hard_muld(double a, double b);


unsigned long long soft_addf(float a, float b);
unsigned long long soft_addd(double a, double b);
 
unsigned long long soft_mulf(float a, float b);
unsigned long long soft_muld(double a, double b);


unsigned long long asm_addf(float a, float b);
unsigned long long asm_addd(double a, double b);

unsigned long long asm_mulf(float a, float b);
unsigned long long asm_muld(double a, double b);
