OUT_DIR := out


all : 1 2 3


1 : hardfp.c softfp.c asmfp.c libsoft-fp.a mainfp.c
	gcc --std=c99 -Wall -Wpedantic -Wextra -Wno-return-type -Wno-unused-parameter -g -O0 -masm=intel -mfpmath=387 -m80387 -c hardfp.c -o $(OUT_DIR)/hardfp.o
	gcc --std=c99 -Wall -Wpedantic -Wextra -Wno-return-type -Wno-unused-parameter -g -O0 -masm=intel -mfpmath=387 -mno-80387 -c softfp.c -o $(OUT_DIR)/softfp.o
	gcc --std=c99 -Wall -Wpedantic -Wextra -Wno-return-type -Wno-unused-parameter -g -O0 -masm=intel -c asmfp.c -o $(OUT_DIR)/asmfp.o
	gcc --std=c99 -Wall -Wpedantic -Wextra -Wno-return-type -Wno-unused-parameter -g -O0 -masm=intel -c mainfp.c -o $(OUT_DIR)/mainfp.o
	gcc $(OUT_DIR)/hardfp.o $(OUT_DIR)/softfp.o $(OUT_DIR)/asmfp.o $(OUT_DIR)/mainfp.o -L. -lsoft-fp -o 1.elf

2 : sin.asm
	fasm sin.asm $(OUT_DIR)/sin.o
	gcc $(OUT_DIR)/sin.o -no-pie -o 2.elf

3 : findroot.asm
	fasm findroot.asm $(OUT_DIR)/findroot.o
	gcc $(OUT_DIR)/findroot.o -o 3.elf

clean :
	$(RM) ./*.elf $(OUT_DIR)/*

.PHONY : clean
