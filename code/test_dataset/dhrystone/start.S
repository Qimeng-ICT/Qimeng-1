
    .section .init;
    .globl _start;
    .type _start,@function


_start:
.option push
.option norelax
	la gp, __global_pointer$
.option pop
	la sp, _sp
#ifdef SIMULATION
    li x26, 0x00
    li x27, 0x00
#endif

	/* Load data section */
	la a0, _data_lma
	la a1, _data
	la a2, _edata
	bgeu a1, a2, 2f
1:
	lw t0, (a0)
	sw t0, (a1)
	addi a0, a0, 4
	addi a1, a1, 4
	bltu a1, a2, 1b
2:

	/* Clear bss section */
	la a0, __bss_start
	la a1, _end
	bgeu a0, a1, 2f
1:
	sw zero, (a0)
	addi a0, a0, 4
	bltu a0, a1, 1b
2:
    call _init
    call main


#ifdef SIMULATION
    li x26, 0x01
#endif

loop:
    j loop
