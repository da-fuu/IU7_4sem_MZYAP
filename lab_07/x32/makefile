OUT_DIR := out
SRCS_ASM := $(wildcard ./*.asm)
SRCS := $(wildcard ./*.c)
OBJS := $(SRCS_ASM:./%.asm=$(OUT_DIR)/%.o)
OBJS += $(SRCS:./%.c=$(OUT_DIR)/%.o)

all : app.elf

app.elf : $(OBJS)
	gcc -m32 $^ -o $@

$(OUT_DIR)/%.o : ./%.asm | $(OUT_DIR)
	fasm $< $@

$(OUT_DIR)/%.o : ./%.c | $(OUT_DIR)
	gcc --std=c99 -Wall -Wpedantic -Wextra -Wno-return-type -Wno-unused-parameter -g -O0 -masm=intel -m32 -c $< -o $@

$(OUT_DIR) :
	mkdir -p $@

clean :
	$(RM) ./*.elf $(OUT_DIR)/*

.PHONY : clean
