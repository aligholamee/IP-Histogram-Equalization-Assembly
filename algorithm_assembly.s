		AREA project, CODE, READONLY
			
			EXPORT MAIN			;NEEDED LINE
				ENTRY			;SHOWS WHEN THE CODE STARTS
				
				
MAIN							;USED AS LABEL
			;; Variable (Register) Definition
			MOV R0,#0			;LINE COUNTER(LINES DEFINED AT THE END)
			MOV	R1,#3			;HISTOGRAM WIDTH
			MOV R2,#3			;HISTOGRAM HEIGHT
			MOV R3,#0			;HISTOGRAM PIXEL COUNTER
			MOV	R4,#0			;OVERALL COUNTER(GOES UNTILL 15*15 - 1)
			MOV R5,#0x20000000	;STACK POINTER
			ADR R6,LINE1		;ARRAY START POINTER
LOOP		ADD R4,R4,#1
			MOV R7,#0			;ADDED RESULT FOR EACH BYTE
			;COPIES FIRST ELEMENT TO THE R7
			;FOR PROCESSING AND ADDS +1 TO THE
			;ARRAY START POINTER - POST INDEXED
			ADD R7,[R6,#-16]
			ADD  R7,[R6,#-15]
			ADD  R7,[R6,#-14]
			ADD  R7,[R6,#-1]
			ADD  R7,[R6,#+1]
			ADD  R7,[R6,#+14]
			ADD	 R7,[R6,#+15]
			ADD	 R7,[R6,#+16]

			
			
EOF	B	EOF						;END OF ALGORITHM		



LINE1	DCB	119,99,111,141,43,0,12,7,0,10,16,15,33,33,31
LINE2	DCB	96,93,108,112,134,58,2,0,9,0,0,14,24,22,22
LINE3	DCB	110,103,103,106,123,120,59,8,0,0,0,3,9,12,15
LINE4	DCB	101,130,111,96,101,122,125,70,10,3,2,0,5,4,9
LINE5	DCB	127,103,101,109,108,114,123,124,76,5,0,4,10,0,7
LINE6	DCB	113,118,119,114,109,119,112,116,135,112,26,0,13,0,3
LINE7	DCB	111,116,118,114,110,112,121,102,110,142,106,26,0,10,0
LINE8	DCB	108,113,116,115,112,128,96,117,124,101,129,118,23,0,17
LINE9	DCB	107,111,115,115,114,116,119,125,114,97,109,123,116,43,10
LINE10	DCB	108,110,114,115,115,113,119,116,116,119,110,113,136,134,56
LINE11	DCB	111,110,113,115,116,124,108,112,120,115,120,124,112,139,142
LINE12	DCB	115,111,113,115,116,110,139,114,94,124,122,104,123,114,132
LINE13	DCB	118,112,113,115,116,119,116,125,120,103,114,126,110,101,110
LINE14	DCB	118,113,91,117,103,113,113,113,114,115,116,116,117,105,104
LINE15	DCB	124,117,94,117,103,112,113,113,114,115,116,116,116,122,108
END	