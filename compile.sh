# 使用 NASM 汇编引导加载程序，并将其输出为二进制文件。
nasm -f bin bootloader.asm -o bootloader.bin

# 将内核源文件编译为目标文件。
# -ffreestanding 告诉 GCC 这是为独立环境（即非操作系统）编写的代码。
# -m32 生成 32 位代码。
# -c 表示我们只进行编译，不进行链接。
gcc -ffreestanding -m32 -c kernel.c -o kernel.o

# 将 I/O 操作源文件编译为目标文件。
# 与上面的内核编译使用相同的标志。
gcc -ffreestanding -m32 -c io.c -o io.o

# 将内核入口汇编文件编译为目标文件。
# -f elf32 指定输出格式为 32 位 ELF。
nasm -f elf32 kernel_entry.asm -o kernel_entry.o

# 将内核入口和内核目标文件链接在一起，生成单个二进制文件。
# -m elf_i386 指定输出格式为 i386 的 32 位 ELF。
# -Ttext 0x1000 设置文本段从内存地址 0x1000 开始。
# --oformat binary 指定输出格式为原始二进制文件。
# 输出文件为内核二进制文件（kernel.bin）。
ld -m elf_i386 -Ttext 0x1000 --oformat binary -o kernel.bin kernel_entry.o kernel.o io.o

# 创建一个大小为 1.44MB（2880 个 512 字节扇区）的空白软盘镜像。
dd if=/dev/zero of=floppy.img bs=512 count=2880

# 将引导加载程序二进制文件写入软盘镜像的开头。
# conv=notrunc 表示不要截断输出文件。
dd if=bootloader.bin of=floppy.img conv=notrunc

# 将内核二进制文件写入软盘镜像，从第二个扇区（512 字节）开始。
# bs=512 指定块大小为 512 字节。
# seek=1 表示跳过第一个块（即引导加载程序）。
dd if=kernel.bin of=floppy.img bs=512 seek=1 conv=notrunc

# 在 QEMU 模拟器中启动软盘镜像。
# qemu-system-x86_64 是用于模拟 64 位 x86 系统的 QEMU 命令。
# -drive format=raw,file=floppy.img 指定软盘镜像为原始格式文件并从中启动。
qemu-system-x86_64 -drive format=raw,file=floppy.img
