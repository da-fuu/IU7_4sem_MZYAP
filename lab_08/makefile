OUT_DIR := out
SRCS := $(wildcard ./*.asm)
OBJS := $(SRCS:./%.asm=$(OUT_DIR)/%.o)

all : app.elf

app.elf : $(OBJS)
	gcc $^ -L. -lraylib -lraygui -lm -no-pie -o $@

$(OUT_DIR)/%.o : ./%.asm | $(OUT_DIR)
	fasm $< $@

$(OUT_DIR) :
	mkdir -p $@

clean :
	$(RM) ./*.elf $(OUT_DIR)/*

.PHONY : clean
