	AREA	ARMex, CODE, READONLY
		ENTRY
Start
		MOV	r0,#10 ;store integer 10 to register 0
		MOV r1,#3 ;store integer 3 to register 1
		ADD r0,r0,r1 ;add r1&r0 and store result to r0
		
		MOV pc,lr ;go to first instruction
		
		END ;End of File