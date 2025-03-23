TARGET := app.elf
OUT_DIR := out
SRCS := $(wildcard ./*.asm)
OBJS := $(SRCS:./%.asm=$(OUT_DIR)/%.o)

all : $(TARGET)

%.elf : $(OBJS)
	ld $^ -o $@

$(OUT_DIR)/%.o : ./%.asm ./common.inc | $(OUT_DIR)
	fasm $< $@

$(OUT_DIR) :
	mkdir -p $@

clean :
	$(RM) ./*.elf $(OUT_DIR)/*

.PHONY : clean
