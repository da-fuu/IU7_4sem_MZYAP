#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "raylib.h"

extern void change_brightness_asm(unsigned char *data, int len, float brightness);


int main(int argc, char **argv)
{
    if (argc < 2)
    {
        puts("Недостаточное количество аргументов");
        return 1;
    }
    
    Image image = LoadImage(argv[1]);
    if (!IsImageValid(image))
    {
        puts("Ошибка открытия изображения");
        return 2;
    }
    int len = image.height * image.width * (image.format == PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 ? 4 : 3);
    void *copy = malloc(len);
    Texture2D texture;

    float mouse;
    float brightness = 0.5f;

    InitWindow(image.width, image.height, "GUI");
    SetTargetFPS(60);
    texture = LoadTextureFromImage(image);
    while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(BLACK);

        mouse = GetMouseWheelMove();
        if (mouse != 0.0f)
            brightness -= mouse / 100.0f;
        if (IsKeyDown(KEY_UP))
            brightness += 0.003f;
        if (IsKeyDown(KEY_DOWN))
            brightness -= 0.003f;

        if (brightness < 0.0f)
            brightness = 0.0f;
        else if (brightness > 1.0f)
            brightness = 1.0f;
        
        memcpy(copy, image.data, len);
        change_brightness_asm(copy, len, brightness);
        
        UpdateTexture(texture, copy);
        DrawTexture(texture, 0, 0, WHITE);
        
        EndDrawing();
    }
    
    return 0;
}
