OUT_DIR := out
CFLAGS := --std=c99 -Wall -Wpedantic -Wextra -g -O0


all : app.elf

app.elf : $(OUT_DIR)/main.o $(OUT_DIR)/asm.o
	gcc $^ -lm -o $@

$(OUT_DIR)/main.o : main.c 
	gcc $(CFLAGS) -c $< -o $@


$(OUT_DIR)/asm.o : asm.asm
	fasm $< $@


clean :
	$(RM) ./*.elf $(OUT_DIR)/*

.PHONY : clean
