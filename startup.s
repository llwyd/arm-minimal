    .text
    .syntax unified
    .cpu cortex-m4
    .thumb


.globl _reset
.thumb_func
_reset:
    /* Copy Data values from ROM -> RAM */
    ldr r0, = _etext 
    ldr r1, = _sdata
    ldr r2, = _edata
copydata:
    /* load from ROM and post increment */
    ldr r3, [r0], #4
    /* Store in RAM and post increment */
    str r3, [r1], #4

    /* Compare current data pointer to end
     * and if equal, then branch to main
     */
    cmp r1, r2
    bne copydata

    /* Clear BSS Region */
clearbss:
    ldr r1, = _sbss
    ldr r2, = _ebss
    mov r0, #0x00
    /* Store 0x0 in location held in r1 */
    str r0, [r1], #4
    cmp r1, r2
    bne clearbss

    CPSID IF
    bl main

dead:
	b dead
