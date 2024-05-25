build:
	- gcc -ffreestanding -c kernel.c -o kernel.o && ld -o kernel.bin -Ttext 0x1000 --oformat binary kernel.o && dd if=/dev/zero of=floppy.img bs=512 count=2880 && dd if=helloworld.bin of=floppy.img conv=notrunc

run:
	- qemu-system-x86_64 -drive format=raw,file=floppy.img
