CC=gcc
ASMBIN=nasm

all : asm cc link clean
asm :
	$(ASMBIN) -o shrinkbmp24.o -f elf shrinkbmp24.asm
cc :
	$(CC) -m32 -c -g main.c -o main.o
link:
	$(CC) -m32 -o shrinkbmp24 main.o shrinkbmp24.o
clean:
	rm *.o