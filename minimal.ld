MEMORY {
    ROM (rx)  : ORIGIN = 0x08000000, LENGTH = 256K
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 48K
}

SECTIONS
{
    . = ORIGIN(ROM);
    .text :
    {
        KEEP(*(.isr_vectors))
        *(.text*)
        *(.rodata*)
        _etext = .;
    } > ROM
    
    . = ORIGIN(RAM);
    .data :
    {
        _sdata = .;
        *(.data*)
        _edata = .;
    } > RAM AT > ROM
    
    . = ALIGN(4);
    .bss :
    { 
        _sbss = .;
        *(.bss*)
        _ebss = .;
    } > RAM AT > ROM     
}
