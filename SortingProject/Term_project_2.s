	AREA code_area, CODE, READONLY
		ENTRY

float_number_series EQU 0x0450
sorted_number_series EQU 0x00018AEC
final_result_series EQU 0x00031190

;========== Do not change this area ===========

initialization
	LDR r0, =0xDEADBEEF				; seed for random number
	LDR r1, =float_number_series	
	LDR r2, =10000  				; The number of element in stored sereis
	LDR r3, =0x0EACBA90				; constant for random number

save_float_series
	CMP r2, #0
	BEQ is_init
	BL random_float_number
	STR r0, [r1], #4
	SUB r2, r2, #1
	MOV r5, #0
	B save_float_series

random_float_number
	MOV r5, LR
	EOR r0, r0, r3
	EOR r3, r0, r3, ROR #2
	CMP r0, r1
	BLGE shift_left
	BLLT shift_right
	BX r5

shift_left
	LSL r0, r0, #1
	BX LR

shift_right
	LSR r0, r0, #1
	BX LR
	
;============================================


;========== Start your code here ===========
is_init
	LDR r0, =final_result_series
	LDR r1, =float_number_series
	LDR r2, [r1]
	STR r2, [r0] ;Store the first value to final
	MOV r2, #4 ; j = 1
	LDR r10, =40000
	MOV r7, pc
	B for_Loop
	MOV pc, #0
for_Loop
	CMP r2, r10
	BXEQ r7; j<n
	SUB r3, r2, #4; i = j - 1
	MOV r8, pc
	B while_Loop
	ADD r3, r3, #4
	STR r4, [r0, r3]
	ADD r2, r2, #4; j++
	B for_Loop
while_Loop
	MOV r12, #0
	MOV r11, #0
	LDR r4, [r1, r2] ; A[j] = key
	LDR r5, [r0, r3] ; A[i]
	CMP r3, #0
	BXLT r8 ; if i<0 -> go back to forLoop
	CMP r4, #0
	ADDLT r11, r11, #1
	CMP r5, #0
	ADDLT r11, r11, #1
	CMP r11, #2
	BLEQ compareNEG; both negative
	CMP r5, r4
	MOVLE r12, #1
	CMP r12, #1
	BXEQ r8
	ADDNE r6, r3, #4 ; r6 = r3 + 1 -> r6 = i + 1
	STRNE r5, [r0, r6] ; A[i+1] = A[i]
	SUB r3, r3, #4; i--
	B while_Loop
compareNEG
	CMP r4, r5
	MOVLE r12, #1
	ADD pc, lr, #8
	
exit
	END
;========== End your code here ===========