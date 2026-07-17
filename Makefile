CC = clang
LD = ld.lld
OBJCOPY = llvm-objcopy

CFLAGS = -target aarch64-none-elf -Wall -O2 -ffreestanding -nostdlib

OBJS = boot.o kernel.o

all: kernel.bin

boot.o: boot.s
	$(CC) $(CFLAGS) -c boot.s -o boot.o
kernel.o: kernel.c
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o
kernel.elf: $(OBJS) linker.ld
	$(LD) -T linker.ld $(OBJS) -o kernel.elf
kernel.bin: kernel.elf
	$(OBJCOPY) -O binary kernel.elf kernel.bin

run: kernel.bin
	qemu-system-aarch64 -M virt -cpu cortex-a53 -m 128M -nographic -kernel kernel.bin

clean:
	rm -f *.o *.elf *.bin
