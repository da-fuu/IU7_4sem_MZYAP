#include <stdio.h>
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
    Image copy;
    Texture2D texture;
    
    Vector2 mouse;
    float brightness = 0.5f;

    InitWindow(image.width, image.height, "GUI");
    int len = image.height * image.width * (image.format == PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 ? 4 : 3);
    SetTargetFPS(60);
    texture = LoadTextureFromImage(image);
    while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(BLACK);

        mouse = GetMouseWheelMoveV();
        brightness -= mouse.y / 100.0f;
        if (IsKeyDown(KEY_UP))
            brightness += 0.003f;
        if (IsKeyDown(KEY_DOWN))
            brightness -= 0.003f;

        if (brightness < 0.0f)
            brightness = 0.0f;
        else if (brightness > 1.0f)
            brightness = 1.0f;
        
        copy = ImageCopy(image);
        change_brightness_asm(copy.data, len, brightness);
        
        UpdateTexture(texture, copy.data);
        DrawTexture(texture, 0, 0, WHITE);

        UnloadImage(copy);
        
        EndDrawing();
    }
    
    
    
        
    return 0;
}
