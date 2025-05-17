CFLAGS := --std=c99 -Wall -Wpedantic -Wextra -g -O0

all : app.elf

app.elf : main.c
	gcc $(CFLAGS) $^ -o $@

clean :
	$(RM) ./app

.PHONY : clean all
