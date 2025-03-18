TARGET := lab_04.elf


all: $(TARGET)

	
%.elf: %.asm
	fasm $< $@
	chmod +x $@

clean:
	rm $(TARGET)
