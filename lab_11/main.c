#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

void change_brightness_std(unsigned char *data, int len, float brightness)
{
    for (int i = 0; i < len; i++)
    {
        if (brightness > 0.5f)
                data[i] = (unsigned char)(255.0f - (255.0f - (float)data[i]) * (2.0f - brightness * 2.0f));
        else if (brightness < 0.5f)
            data[i] = (unsigned char)((float)data[i] * brightness * 2.0f);
    }
}

extern void change_brightness_asm(unsigned char *data, int len, float brightness);

int main(int argc, char **argv)
{
    if (argc < 4)
    {
        puts("Недостаточное количество аргументов");
        return 1;
    }
    
    char *endptr;
    
    float brightness = strtof(argv[1], &endptr);
    if (*endptr != '\0' || brightness < 0.0f || brightness > 1.0f)
    {
        puts("Ошибка ввода яркости");
        return 2;
    }
    
    int width, height, channels;
    
    unsigned char *data = stbi_load(argv[2], &width, &height, &channels, 3);
    if (data == NULL)
    {
        puts("Ошибка открытия изображения");
        return 3;
    }
    
    change_brightness_asm(data, width * height * channels, brightness);
    
    if (!stbi_write_png(argv[3], width, height, channels, data, channels * width))
    {
        puts("Ошибка записи изображения");
        return 4;
    }
    
    puts("Яркость изображения успешно изменена");
    return 0;
}
