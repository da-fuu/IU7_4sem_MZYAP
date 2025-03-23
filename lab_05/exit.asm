format ELF64

public exit

include 'common.inc'


section '.text' executable
exit:
	syscall2 0x3C,rax
