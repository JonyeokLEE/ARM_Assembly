 AREA	ARMex, CODE, READONLY
	ENTRY

start
	LDR r0, =&00040000 ; to store the result to memory
	MOV r1, #1
	MOV r2, #0
	
	ADD r2, r1
	ADD r1, r1, #1
	ADD r2, r1
	ADD r1, r1, #1
	ADD r2, r1
	ADD r1, r1, #1
	ADD r2, r1
	ADD r1, r1, #1
	ADD r2, r1
	ADD r1, r1, #1
	ADD r2, r1
	ADD r1, r1, #1
	ADD r2, r1
	ADD r1, r1, #1
	ADD r2, r1
	ADD r1, r1, #1
	ADD r2, r1
	ADD r1, r1, #1
	ADD r2, r1
	ADD r1, r1, #1
	
	
	STR r2, [r0]
	
	MOV pc,lr

	END