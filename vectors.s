    .equ STACK_TOP, 0x20001000
    .syntax unified
    .cpu cortex-m4
    .thumb

 

.section .isr_vectors
    .word STACK_TOP
    .word _reset
    .word _test


.text
.weak _reset
.thumb_set _reset, dead

.weak _test
.thumb_set _test, dead

.thumb_func
dead:
    b dead
