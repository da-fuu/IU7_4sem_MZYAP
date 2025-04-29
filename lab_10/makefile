OUT_DIR := out
CFLAGS := --std=c99 -Wall -Wpedantic -Wextra -Wno-unused-variable -Wno-unused-but-set-variable -g -O0 -masm=intel

SRCS := $(wildcard *fp.c)

OBJS := $(SRCS:%.c=$(OUT_DIR)/%.o)

all : 1 2 3


1 : 1.elf

1.elf : $(OBJS)
	gcc $^ -L. -lsoft-fp -o 1.elf

$(OUT_DIR)/hardfp.o : hardfp.c opsfp.h
	gcc $(CFLAGS) -mfpmath=387 -m80387 -c $< -o $@

$(OUT_DIR)/softfp.o : softfp.c opsfp.h
	gcc $(CFLAGS) -mfpmath=387 -mno-80387 -c $< -o $@

$(OUT_DIR)/%fp.o : %fp.c opsfp.h
	gcc $(CFLAGS) -c $< -o $@


2 : 2.elf

2.elf : $(OUT_DIR)/sin.o
	gcc $< -o $@


3 : 3.elf

3.elf : $(OUT_DIR)/findroot.o
	gcc $< -o $@


$(OUT_DIR)/%.o : %.asm
	fasm $< $@

clean :
	$(RM) ./*.elf $(OUT_DIR)/*

.PHONY : clean
