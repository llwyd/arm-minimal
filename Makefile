minimal.bin: minimal.elf
	arm-none-eabi-objcopy -Obinary minimal.elf minimal.bin
minimal.elf: minimal.o startup.o minimal.ld
	arm-none-eabi-ld -Map minimal.map -Tminimal.ld -o minimal.elf startup.o minimal.o -print-memory-usage -nostdlib
	arm-none-eabi-objdump -t minimal.elf
startup.o: startup.s
	arm-none-eabi-as -g -mcpu=cortex-m4 -mthumb  startup.s -o startup.o
minimal.o: minimal.c
	arm-none-eabi-gcc -Werror -Wall  -g -nostdlib -nostartfiles -mcpu=cortex-m4 -mthumb -c minimal.c -o minimal.o
clean:
	rm startup.o minimal.elf minimal.bin minimal.o minimal.map
debug:
	openocd -f /usr/share/openocd/scripts/interface/stlink-v2-1.cfg -f /usr/share/openocd/scripts/target/stm32l4x.cfg
gdb:
	arm-none-eabi-gdb -ex "target remote localhost:3333" minimal.elf
ezflash:
	st-flash write minimal.bin 0x08000000
