 AREA ARMex, CODE, READONLY
ENTRY

start
    LDR r0, =0x40000000
    LDR r9, =0x80000000 ; for sign
    LDR r10, =0x7f800000 ; for exponent
    LDR r11, =0x007fffff ; for fraction

    LDR r1, POS1
    LDR r2, POS2
    BL set
    CMP r3, r6
	BLEQ same_sign
    BLNE unsame_sign
after_add
    BL normalize
	BL construct_result
    B FINISH

set
    AND r3, r1, r9 ; get sign
	MOV r3, r3, LSR #31
    AND r4, r1, r10 ; get exponent
    MOV r4, r4, LSR #23
    AND r5, r1, r11 ; get fraction
    AND r6, r2, r9 ; get sign
	MOV r6, r6, LSR #31
    AND r7, r2, r10 ; get exponent
    MOV r7, r7, LSR #23
    AND r8, r2, r11 ; get fraction
    ADD r5, r5, #0x800000
    ADD r8, r8, #0x800000
    BX LR

same_sign
    CMP r4, r7 ; compare exponent
    BLLT shiftexponent
    BLGT shiftexponent2
    ADD r5, r5, r8
	B after_add

unsame_sign
	CMP r4, r7 ; compare exponent
    BLLT shiftexponent
    BLGT shiftexponent2
    CMP r5, r8
	SUBGE r5, r5, r8
	SUBLT r5, r8, r5
	MOVLE r3, r6
    B after_add

shiftexponent
	SUB r12, r7, r4
    MOV r5, r5, LSR r12
    MOV r4, r7
    BX LR

shiftexponent2
    SUB r12, r4, r7
    MOV r8, r8, LSR r12
    BX LR

normalize 
	CMP r5, #0x01000000
    BGE shift_right ;if greater and equal than 01000000
    CMP r5, #0x00800000
    BLT shift_left ; if less than 00800000
    BX LR 

shift_right 
    MOV r5, r5, LSR #1 
    ADD r4, r4, #1 
    B normalize

shift_left 
    MOV r5, r5, LSL #1 
    SUB r4, r4, #1 
    B normalize
	
construct_result
	MOV r3, r3, LSL #31
    MOV r4, r4, LSL #23 ; shift exponent to its position
    BIC r5, r5, #0x00800000 ; remove the leading 1 of fraction
    ORR r1, r3, r4 ; combine sign and exponent
    ORR r1, r1, r5 ; add fraction to form the final result
	STR r1, [r0], #4 ; store the result
    BX LR


POS1 DCI 0x41DA0000; 27.25
NEG2 DCI 0xC1DA0000; -27.25
NEG1 DCI 0xC1860000; -16.75
POS2 DCI 0x4291E000; 72.9375
POS3 DCI 0x41860000; 16.75
TEST1 DCI 0x3FC00000
TEST2 DCI 0x40500000
ZERO DCI 0x00000000; 0

FINISH
	MOV pc, lr

	END
