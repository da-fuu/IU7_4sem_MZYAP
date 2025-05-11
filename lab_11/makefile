OUT_DIR := out
CFLAGS := --std=c99 -Wall -Wpedantic -Wextra -g -O0


all : app.elf gui.elf

app.elf : $(OUT_DIR)/main.o $(OUT_DIR)/brightness.o
	gcc $^ -lm -o $@

$(OUT_DIR)/main.o : main.c 
	gcc $(CFLAGS) -c $< -o $@

$(OUT_DIR)/brightness.o : brightness.asm
	fasm $< $@

gui.elf : $(OUT_DIR)/gui.o $(OUT_DIR)/brightness.o
	gcc $^ -L. -lraylib -lm -o $@

$(OUT_DIR)/gui.o : gui.c
	gcc $(CFLAGS) -O3 -c $< -o $@

clean :
	$(RM) ./*.elf $(OUT_DIR)/*

.PHONY : clean
