 AREA	ARMex, CODE, READONLY
	ENTRY

start
	LDR r0, =&00040000 ; to store the result to memory
	MOV r1, #2 ; a = 2
	MOV r2, #1 ; b = 1
	MOV r3, #3 ; c = 3
	MOV r4, #4 ; d = 4
	
	SUB r5, r1, r2 ; R5 = a - b
	ADD r6, r3, r4, LSL #1 ; R6 = c + (d * 2)
	ADD r7, r5, r6 ; R7 = e = R5 + R6 = (a - b) + (c + (d * 2))
	
	STR r7, [r0] ; store e(result) to memory

	MOV pc,lr

	END