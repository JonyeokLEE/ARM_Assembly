 AREA	ARMex, CODE, READONLY
	ENTRY

start
    LDR r0, =0x40000000 
    MOV r1, #17         
    MOV r2, #3

	MUL r3, r1, r2
	
	;MUL r4, r2, r1

FINISH
	MOV pc,lr

	END