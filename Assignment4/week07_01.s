 AREA	ARMex, CODE, READONLY
	ENTRY

start
    LDR r0, =0x40000000 ;r0 = 0x40000000
    MOV r1, #1 ;result
	
one	
	STR r1, [r0], #4 ;store the result
two
	MOV r1, r1, LSL #1 ;r1 = r1 * 2
	STR r1, [r0], #4 ;store the result
three
	ADD r1, r1, r1, LSL #1 ;r1 = r1 * 2 + r1
	STR r1, [r0], #4 ;store the result
four
	MOV r1, r1, LSL #2 ;r1 = r1 * 4
	STR r1, [r0], #4 ;store the result
five
	ADD r1, r1, r1, LSL #2 ;r1 = r1 * 4 + r1
	STR r1, [r0], #4 ;store the result
six
	MOV r2, r1, LSL #2 ;r2 = r1 * 4
	ADD r1, r2, r1, LSL #1 ;r1 = r1 * 2 + r2
	STR r1, [r0], #4 ;store the result
seven
	MOV r2, r1, LSL #2 ;r2 = r1 * 4
	MOV r3, r1, LSL #1 ;r3 = r1 * 2
	ADD r2, r2, r3 ;r2 = r2 + r3
	ADD r1, r2, r1 ;r1 = r2 + r1
	STR r1, [r0], #4 ;store the result
eight
	MOV r1, r1, LSL #3 ;r1 = r1 * 8
	STR r1, [r0], #4 ;store the result
nine
	MOV r2, r1, LSL #3 ;r2 = r1 * 8
	ADD r1, r2, r1 ;r1 = r2 + r1
	STR r1, [r0], #4 ;store the result
ten
	MOV r2, r1, LSL #3 ;r2 = r1 * 8
	ADD r1, r2, r1, LSL #1 ;r1 = r2 + r1 * 2
	STR r1, [r0], #4 ;store the result

FINISH
	MOV pc,lr

	END