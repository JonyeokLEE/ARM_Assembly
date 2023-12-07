 AREA	ARMex, CODE, READONLY
	ENTRY

start
	LDR r0, =test
	MOV r1, #0
	LDR r5, =&00040000
test DCB "Hello_World",0
	
LOOP
	LDRB r2, [r0], #1
	CMP r2,#0
	ADDNE r1, #1
	BNE LOOP
	STREQ r1, [r5]

	MOV pc,lr
	END