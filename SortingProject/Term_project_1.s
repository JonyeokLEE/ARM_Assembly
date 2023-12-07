	AREA code_area, CODE, READONLY
		ENTRY

float_number_series EQU 0x0450
sorted_number_series EQU 0x00018AEC
sorted_number_series2 EQU 0x00050000
final_result_series EQU 0x00031190

;========== Do not change this area ===========

initialization
	LDR r0, =0xDEADBEEF				; seed for random number
	LDR r1, =float_number_series	
	LDR r2, =10000  				; The number of element in stored sereis
	LDR r3, =0x0EACBA90				; constant for random number

save_float_series
	CMP r2, #0
	BEQ ms_init
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
	
ms_init
	LDR sp, =0x00060000
	LDR r0, =float_number_series
	LDR r1, =sorted_number_series
	LDR r9, =sorted_number_series2
	LDR r2, =final_result_series
	
	LDR r3, =9999 ;p
	MOV r4, r3 ;r (total amount -1)
	MOV r3, #0
	BL MergeSort
	MOV r1, #0
CopyResult
	CMP r1, #1000 
	BEQ CopyEND
	LDMIA r0!, {r3-r12}
	STMIA r2!, {r3-r12}
	ADD r1, r1, #1
	B CopyResult
CopyEND	
	MOV pc, #0
	
MergeSort
	STMFD sp!,{r3-r7, lr} ;keep p and r
	CMP r3, r4 ;compare p and r
	LDMFDGE sp!, {r3-r7, pc} ;if p >= r -> POP
	MOV r6, r3 ;save p
	MOV r7, r4 ;save r
	ADD r5, r3, r4 ;r5 = q
	MOV r5, r5, LSR #1 ;q = (p + r) / 2
	MOV r4, r5
	BL MergeSort ;MergeSort(p, q)
	ADD r3, r5, #1
	MOV r4, r7
	BL MergeSort ;MergeSort(q+1, r)
	MOV r3, r6
	MOV r4, r7
	BL Merge ;Merge(p, q, r)
	LDMFD sp!, {r3-r7, pc}
	
	;r3 = p / r4 = r / r5 = q 
Merge
	STMFD sp!, {lr}
	SUB r6, r5, r3
	ADD r6, r6, #1 ;r6 = n1 = q - p + 1
	MOV r12, #0 ;i
forN1
	CMP r12, r6 ;r12 is i!
	BGE ENDforN1
	ADD r10, r3, r12 ; r10 = p + i
	LDR r8, [r0, r10, LSL #2] ; r8 = A[p + i]
	STR r8, [r1, r12, LSL #2] ; L[i] = r8 = A[p + i]
	ADD r12, r12, #1
	B forN1
ENDforN1	
	SUB r7, r4, r5 ;r7 = n2 = r - q
	MOV r11, #0  ;j
forN2
	CMP r11, r7 ;r11 is j!
	BGE ENDforN2
	ADD r10, r5, r11
	ADD r10, r10, #1 ; r10 = q + j + 1
	LDR r8, [r0, r10, LSL #2] ; r8 = A[q + j + 1]
	STR r8, [r9, r11, LSL #2] ; R[j] = r8 = A[q + j - 1]
	ADD r11, r11, #1	
	B forN2
ENDforN2	
	LDR r8, =0x7fffffff ;infinite number(the largest number)
	STR r8, [r1, r6, LSL #2] ;L[n1] = infinite
	STR r8, [r9, r7, LSL #2] ;R[n2] = infinite
	MOV r11, #0; j = 0
	MOV r12, #0 ; i = 0
	MOV r10, r3 ;k = p
for_Loop
	CMP r10, r4 ;for k = p to r
	LDMFDGT sp!, {pc}
	LDR r6, [r1, r12, LSL #2] ;r6 = L[i]
	LDR r7, [r9, r11, LSL #2] ;r7 = R[j]
	;compare start r8 is flag now
	MOV r8, #0
	CMP r6, #0
	ADDLT r8, r8, #1
	CMP r7, #0
	ADDLT r8, r8, #1
	CMP r8, #2
	MOV r8, #0
	BLEQ compareNEG; both negative
	CMP r6, r7
	MOVLE r8, #1
	CMP r8, #1
	STREQ r6, [r0, r10, LSL #2]
	ADDEQ r12, r12, #1 ;i++
	STRNE r7, [r0, r10, LSL #2]
	ADDNE r11, r11, #1 ;j++
	ADD r10, r10, #1 ;k++
	B for_Loop
	
compareNEG
	CMP r7, r6
	MOVLE r8, #1
	ADD pc, lr, #8
	
exit
	END
;========== End your code here ===========