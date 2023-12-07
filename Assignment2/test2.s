 AREA	ARMex, CODE, READONLY
	ENTRY

main
	MOV r0, #0
	BL branch_1
	MOV r1, #1
	BL branch_2
	B Exit
	
branch_1
	ADD r0,r0,#1
	BX LR
	
branch_2
	ADD r1, r1, #1
	BX LR
	
Exit
	
	END