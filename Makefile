all: asm
	gcc -m32 shrinkbmp24.o main.cc -o shrink
asm:
	nasm -f elf shrinkbmp24.asm -o shrinkbmp24.o
