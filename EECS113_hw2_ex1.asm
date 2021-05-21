ORG	00H
	SJMP MAIN

ORG 40H
	N1: DB "143"
	DB 0
	N2: DB "234"
	DB 0

MAIN:
	MOV R0, #3H	; number of digits in N1
	MOV R1, #3H ; number of digits in N2

	;;transfer N1
	MOV DPTR, #N1
	;;copy the last bit
	DEC R0
	MOV A, R0
	MOVC A, @A+DPTR ; copy the 'unit'
	SUBB A, #30H
	MOV R2, A		; store the unit in R2
	MOV A, R0
JZ N1F		; jump to the end of fetching N1

	;;copy the tens bit
	DEC R0
	MOV A, R0
	MOVC A, @A+DPTR
	SUBB A, #30H
	MOV B, #0AH		; 10D = 0AH
	MUL AB			; give the right weight to the 'ten'
	ADD A, R2
	MOV R2, A
	MOV A, R0
JZ N1F		;
	;;copy the hundred bit
	DEC R0
	MOV A, R0
	MOVC A, @A+DPTR
	SUBB A, #30H
	MOV B, #64H		; give the right weight to hundred
	MUL AB
	ADD A, R2
	MOV R2, A
N1F:	;; end of fetching N1

	;;transfer N2
	MOV DPTR, #N2
	;;copy the last bit
	DEC R1
	MOV A, R1
	MOVC A, @A+DPTR ; copy the 'unit'
	SUBB A, #30H
	MOV R3, A		; store the unit in R2
	MOV A, R1
JZ N2F		; jump to the end of fetching N1

	;;copy the tens bit
	DEC R1
	MOV A, R1
	MOVC A, @A+DPTR
	SUBB A, #30H
	MOV B, #0AH		; 10D = 0AH
	MUL AB			; give the right weight to the 'ten'
	ADD A, R3
	MOV R3, A
	MOV A, R1
JZ N2F		;
	;;copy the hundred bit
	DEC R1
	MOV A, R1
	MOVC A, @A+DPTR
	SUBB A, #30H
	MOV B, #64H		; give the right weight to hundred
	MUL AB
	ADD A, R3
	MOV R3, A
N2F:	;; end of fetching N1

MOV A, R2
MOV B, R3
MUL AB
MOV 40H, B
MOV 41H, A

HERE: SJMP HERE
END
