#ifndef IO_H
#define IO_H

// 声明一个函数，接收一个无符号短整型端口号作为参数，返回一个无符号字符。
unsigned char inb(unsigned short 端口);

// 声明一个函数，接收一个无符号短整型端口号和一个无符号字符数据作为参数，没有返回值。
void outb(unsigned short 端口, unsigned char 数据);

#endif
