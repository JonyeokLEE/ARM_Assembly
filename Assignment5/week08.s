CR EQU 0x0D
SPACE EQU 0x20 	
	
	AREA dataArray,DATA
K
	DCB 0
Arr1
	DCB "Hello, World", CR
	ALIGN
Arr2
	DCB 0
	
	
	AREA pseudo, CODE, READONLY
ENTRY
	
mainfunction
	LDR sp, =0x00050000
	LDR r10, =K
	MOV r9, #1 ;to store value to K
	STRB r9, [r10]
	LDR r11, =Arr1
	LDR r12, =Arr2
	BL copy_arr_wo_space
	STRB r9, [r10]
	B finish
	
copy_arr_wo_space
	STMFD sp!,{r0-r5, lr} ;STORE Block Data
	MOV r5, #0 ;length of Arr2
for_Loop_begin ;for_Loop Start
	LDRB r0, [r11], #1
	CMP r0, #CR ;if r0 == CR
	BEQ for_Loop_end ;break
	
	CMP r0, #SPACE ;Is r0 is Space?
	STRBNE r0, [r12], #1 ;if r0 is not space, Store to R12
	ADDNE r5, r5, #1
	
	B for_Loop_begin
for_Loop_end
	
	PUSH {r5} ;push in to stack the value of size of arr2
	POP {r9} ;pop
	LDMFD sp!,{r0-r5, pc} ;LOAD Stack
	BX LR	

finish
	MOV pc, #0
	END