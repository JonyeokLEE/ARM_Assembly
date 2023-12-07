 AREA	ARMex, CODE, READONLY
	ENTRY

start
    LDR r0, =0x40000000 
    MOV r1, #1       
    MOV r2, #1          
    MOV r3, #1 ;count

multi
    CMP r3, #11   ;if count == 11 -> end
    BEQ FINISH        
    MUL r1, r2, r3    
    MOV r2, r1        ; save result 
    STR r2, [r0], #4     ;store result 
	ADD r3, r3, #1 ;count++
    B multi             

FINISH
	MOV pc,lr

	END