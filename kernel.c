volatile unsigned int *UART0_DR = (volatile unsigned int *)0x09000000; // data register
volatile unsigned int *UART0_FR = (volatile unsigned int *)0x09000018; // flag register

// Print Characters and Text on the Screen 
void uart_putc(char c){
	*UART0_DR = c;
}

void uart_puts(const char *str){
	while (*str){
		uart_putc(*str++);
	}
}

// polling..
char uart_getc(){
	while (*UART0_FR & (1 << 4)) {
		
	}
	return (char)(*UART0_DR & 0xFF);
}

// main code
void kernel_main(){
	uart_puts("Null v1.0.0\n");
	uart_puts("$ ");

	while (1){
		char c = uart_getc();

		if (c == '\r' || c == '\n') {
			uart_puts("\n$ ");
		} else {
			uart_putc(c);
		}
	}
}

