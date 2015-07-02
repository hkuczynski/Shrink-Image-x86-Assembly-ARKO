CC=gcc
ASMBIN=nasm

all : asm cc link clean
asm :
	$(ASMBIN) -o shrinkbmp24.o -f macho shrinkbmp24.asm
cc :
	$(CC) -arch i386 -c -g main.c -o main.o
link:
	$(CC) -arch i386  -o shrinkbmp24 main.o shrinkbmp24.o
clean:
	rm *.o
