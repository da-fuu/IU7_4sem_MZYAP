#include <stdio.h>
#include <string.h>
#include <stdlib.h>
// #include <x86intrin.h>
#include "raylib.h"

extern void change_brightness_asm(unsigned char *data, size_t len, float brightness);


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

    InitWindow(image.width, image.height, argv[1]);
    SetTargetFPS(60);
    // unsigned long long before, after;
    texture = LoadTextureFromImage(image);
    while (!WindowShouldClose())
    {
        if (IsFileDropped())
        {
            FilePathList files = LoadDroppedFiles();
            UnloadTexture(texture);
            UnloadImage(image);
            free(copy);
            image = LoadImage(files.paths[0]);
            if (!IsImageValid(image))
            {
                CloseWindow();
                return 2;
            }
            len = image.height * image.width * (image.format == PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 ? 4 : 3);
            copy = malloc(len);
            texture = LoadTextureFromImage(image);
            SetWindowSize(image.width, image.height);
            SetWindowTitle(files.paths[0]);
            UnloadDroppedFiles(files);
        }
        
        BeginDrawing();
        ClearBackground(BLACK);

        mouse = GetMouseWheelMove();
        if (mouse != 0.0f)
            brightness -= mouse / 75.0f;
        if (IsKeyDown(KEY_UP))
            brightness += 0.005f;
        if (IsKeyDown(KEY_DOWN))
            brightness -= 0.005f;

        if (brightness < 0.0f)
            brightness = 0.0f;
        else if (brightness > 1.0f)
            brightness = 1.0f;

        memcpy(copy, image.data, len);
        // before = __rdtsc();
        // printf("else %llu\n", before - after);
        change_brightness_asm(copy, len, brightness);
        // after = __rdtsc();
        // printf("this %llu\n", after - before);
        
        UpdateTexture(texture, copy);
        DrawTexture(texture, 0, 0, WHITE);
        
        EndDrawing();
    }
    UnloadTexture(texture);
    free(copy);
    UnloadImage(image);
    CloseWindow();
    return 0;
}
