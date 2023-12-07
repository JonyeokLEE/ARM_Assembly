 AREA	ARMex, CODE, READONLY
	ENTRY

start
	MOV	r0,#10
	MOV	r1,#3
	CMP r0,r1 ;Compare(r0-r1)
	
	MOVLT r2,r0	; r2 = r0 (r0 < r1)
	MOVGT r2,r1 ; r2 = r0 (r0 > r1)
	ADDEQ r0,r0,r1 ;  r0 = r0 + r1 (r0 = r1)
	MOVEQ r2,r0 ; r2 = r0 (r0 = r1)
	
	END