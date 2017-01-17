		AREA project, CODE, READONLY
			
			EXPORT MAIN			;NEEDED LINE
				ENTRY			;SHOWS WHEN THE CODE STARTS
				
			;CLOCK ACTIVATION	
			LDR R3,=0x40023830
			LDR R11,[R3]
			LDR R12,=0x3
			ORR R2,R12,R11
			STR R2,[R3]
						
MAIN	
			;GENERAL PURPOSE INPUT
			;MOD
			LDR R3,=0x40020000
			LDR R11,[R3]
			LDR R12,=0x0
			ORR R2,R12,R11
			STR R2,[R3]
			;SPEED SETTING
  			LDR R3,=0x40020008
  			LDR R11,[R3]
  			LDR R12,=0x0
  			ORR R2,R12,R11
  			STR R2,[R3]		
 			;PULL UP PULL DOWN
  			LDR R3,=0x4002000c
  			LDR R11,[R3]
  			LDR R12,=0x0
  			ORR R2,R12,R11
  			STR R2,[R3]
			
INPUT_IDR   NOP
			LDR R3,=0x40020010
			LTORG
			LDR R11,[R3]
			TST R11,#0x1
			BEQ INPUT_IDR		;USED AS LABEL
			;; Variable (Register) Definition
			MOV R0,#0			;LINE COUNTER(LINES ARE DEFINED AT THE END)
			MOV R1,#0			;COLUMN COUNTER
			MOV	R4,#0			;OVERALL COUNTER(GOES UNTILL 15*15 - 1)
			MOV R5,#0x20000000	;STACK POINTER
			ADR R6,LINE1		;ARRAY START POINTER
			MOV R8,#0			;TEMPORARY REGISTER FOR WIEGHT MULTIPLICATIONS
			MOV R9,#0			;TEMPORARY REGISTER FOR WIEGHT MULTIPLICATIONS
			MOV R10,#0			;TEMPORAY FOR LOAD
			
LOOP		ADD R4,R4,#1
			CMP R4,#256
			BEQ EOF				;BRANCH TO EOF
			MOV R7,#0			;ADDED RESULT FOR EACH BYTE
			ADD R6,R6,#+1		;SET THE ELEMENTS
			ADD R1,R1,#+1
			CMP R1,#16
			BEQ NEWLINE
			;COPIES FIRST ELEMENT TO THE R7
			;FOR PROCESSING AND ADDS +1 TO THE
			;ARRAY START POINTER - POST INDEXED
			
			LDR  R10,[R6]
			ADD  R7,R7,R10,LSL#2		;WEIGHT 4 FOR CURRENT ELEMNET
			MOV  R10,#0
			
			LDR  R10,[R6,#-18]
			ADD  R7,R7,R10			;WEISGHT 1 FOR DIAGNOAL ELEMENT (UPPER LEFT)
			
			LDR  R10,[R6,#-16]
			ADD  R7,R7,R10			;WEIGHT 1 FOR DIAGNOAL ELEMENT (UPPER RIGHT)
			
			LDR  R10,[R6,#+16]
			ADD  R7,R7,R10			;WEIGHT 1 FOR DIAGNOAL ELEMENT (LOWER LEFT)
			
			LDR  R10,[R6,#+18]
			ADD	 R7,R7,R10			;WEIGHT 1 FOR DIAGNOAL ELEMENT (LOWER RIGHT)
			
			
			LDR  R9,[R6,#-17]
			MOV  R8,R9			
			ADD  R7,R7,R8,LSL#1		;WEIGHT 2 FOR ABOVE ELEMENT
			MOV  R8,#0
			MOV  R9,#0
			
			LDR  R9,[R6,#-1]
			MOV  R8,R9      	
			ADD  R7,R7,R8,LSL#1		;WEIGHT 2 FOR LEFT ELEMENT
			MOV  R8,#0
			MOV  R9,#0
			
			LDR  R9,[R6,#+1]
			MOV  R8,R9		
			ADD  R7,R7,R8,LSL#1		;WEIGHT 2 FOR RIGHT ELEMENT
			MOV  R8,#0
			MOV  R9,#0
			
			LDR  R9,[R6,#+17]
			MOV	 R8,R9		
			ADD  R7,R7,R8,LSL#1		;WEIGHT 2 FOR BELOW ELEMENT
			MOV  R8,#0
			MOV  R9,#0
			
			MOV  R7,R7,ASR#4	
			STR  R7,[R5],#+1		;STORE THE AVERAGE PIXEL ON THE STACK POINTER AND INCREMENT SP
			
			B    LOOP				;BRANCH TO LOOP		
NEWLINE		MOV  R1,#0				;RESET THE COLUMN COUNTER
			ADD  R6,R6,#+1			;SET THE NEW LINE ADDRESS
			B    LOOP		
			
			;GENERAL PURPOSE OUTPUT
			;MOD
			LTORG
			LDR R3,=0x40020400
			LDR R11,[R3]
			LDR R12,=0x1
			ORR R2,R12,R11
			STR R2,[R3]
			;TYPE
			LTORG
			LDR R3,=0x40020404
			LTORG
			LDR R11,[R3]
			LDR R12,=0x0
			ORR R2,R12,R11
			STR R2,[R3]
			;SPEED SETTING
  			LDR R3,=0x40020408
  			LDR R11,[R3]
  			LDR R12,=0x0
  			ORR R2,R12,R11
  			STR R2,[R3]
			
 			;PULL UP PULL DOWN
  			LDR R3,=0x4002040c
  			LDR R11,[R3]
  			LDR R12,=0x0


EOF	B	EOF						;END OF ALGORITHM	

LINE0	DCD	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0					;ZERO BLOCK
LINE1	DCD	0,119,99,111,141,43,0,12,7,0,10,16,15,33,33,31,0
LINE2	DCD	0,96,93,108,112,134,58,2,0,9,0,0,14,24,22,22,0
LINE3	DCD 0,110,103,103,106,123,120,59,8,0,0,0,3,9,12,15,0
LINE4	DCD	0,101,130,111,96,101,122,125,70,10,3,2,0,5,4,9,0
LINE5	DCD	0,127,103,101,109,108,114,123,124,76,5,0,4,10,0,7,0
LINE6	DCD	0,113,118,119,114,109,119,112,116,135,112,26,0,13,0,3,0
LINE7	DCD	0,111,116,118,114,110,112,121,102,110,142,106,26,0,10,0,0
LINE8	DCD	0,108,113,116,115,112,128,96,117,124,101,129,118,23,0,17,0
LINE9	DCD	0,107,111,115,115,114,116,119,125,114,97,109,123,116,43,10,0
LINE10	DCD	0,108,110,114,115,115,113,119,116,116,119,110,113,136,134,56,0
LINE11	DCD	0,111,110,113,115,116,124,108,112,120,115,120,124,112,139,142,0
LINE12	DCD	0,115,111,113,115,116,110,139,114,94,124,122,104,123,114,132,0
LINE13	DCD	0,118,112,113,115,116,119,116,125,120,103,114,126,110,101,110,0
LINE14	DCD	0,118,113,91,117,103,113,113,113,114,115,116,116,117,105,104,0
LINE15	DCD	0,124,117,94,117,103,112,113,113,114,115,116,116,116,122,108,0
LINE16	DCD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0					;ZERO BLOCK

	END	
