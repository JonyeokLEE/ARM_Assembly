 AREA	ARMex, CODE, READONLY
	ENTRY

start
	LDR r0, =&00040000 ; to store the result to memory
	MOV r1, #10
	MOV r2, #11
	
	MUL r3, r1, r2
	MOV r3, r3, LSR #1
	
	STR r3, [r0]
	
	MOV pc,lr

	END