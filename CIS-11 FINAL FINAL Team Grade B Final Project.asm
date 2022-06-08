;CIS-11 - 22530
;Professor Nguyen
;6/7/2022
;
;Team: Grade B
;Members: Sarah Welch
;     	  Demitrius De La Corte
;      	  Amtul Syeda
;
;Final Project: Test Score Calculator
;Input: 5 numerical test scores
;Output: Prompts, echoed input,
;     	 letter grades corresponding to numerical
;    	 test scores
;
;Run:     Assemble the program
;     	  Open the Simulate Software
;     	  Load the Assembled program (.obj file)
;    	  Run the code and see the output on the console


.ORIG x3000        ;Sets the origin of the program

;Main

;Displays prompt before getting
;number grade from GRADE and storing it
;into array. => Letter grade is obtained from
;LETTERGRADE function. => Program jumps to POP.

;First Grade
LEA R0, PROMPT
PUTS
PROMPT    .STRINGZ    "Enter test score (50 - 99): "    

LD R0, LINEN ;LD = data movement instruction 
OUT

JSR GRADE
LEA R6, USERG ;LEA = load effective address
STR R4, R6, #0
JSR LETTERGRADE
JSR POP

LD R0, LINEN
OUT

;Second Grade
LEA R0, PROMPT
PUTS

LD R0, LINEN
OUT

JSR GRADE
LEA R6, USERG
STR R4, R6, #1
JSR LETTERGRADE
JSR POP

LD R0, LINEN
OUT

;Third Grade
LEA R0, PROMPT
PUTS

LD R0, LINEN
OUT

JSR GRADE
LEA R6, USERG
STR R4, R6, #2
JSR LETTERGRADE
JSR POP

LD R0, LINEN
OUT

;Fourth Grade
LEA R0, PROMPT
PUTS

LD R0, LINEN
OUT

JSR GRADE
LEA R6, USERG
STR R4, R6, #3
JSR LETTERGRADE
JSR POP

LD R0, LINEN
OUT

;Fifth Grade
LEA R0, PROMPT
PUTS

LD R0, LINEN
OUT        

JSR GRADE
LEA R6, USERG
STR R4, R6, #4
JSR LETTERGRADE
JSR POP

LD R0, LINEN
OUT

;This is where the max is calculated
CALCMAX
LD R2, TOTALTESTS        	;R2 = total tests
LEA R1, USERG            	;R1 = USERG starting address
LD R5, USERG
ST R5, GRADEMAX            	;ST = data movement instruction 
ADD R1, R1, #1                  ;ADD = computational instruction 

FIRSTLOOP LDR R3, R1, #0    	;Access USERG pointer value
NOT R5, R5
ADD R5, R5, #1
ADD R3, R3, R5
BRp MOVEONE            
LEA R0, MAXIMUM
PUTS
LD R4, GRADEMAX
AND R2, R2, #0
JSR INTSNAP            
LD R0, BLANK
OUT
LD R0, LINEN
OUT
JSR RCLEAR

;This is where the min is calculated
CALCMIN
LD R2, TOTALTESTS        ;R2 = total tests
LEA R1, USERG            ;R1 = USERG starting address
LD R5, USERG            
ST R5, GRADEMIN
ADD R1, R1, #1
ADD R2, R2, #-1

SECONDLOOP 
LDR R3, R1, #0    	 ;Access USERG pointer value
NOT R5, R5
ADD R5, R5, #1
ADD R3, R3, R5
BRn MOVETWO   ;

ADD R1, R1, #1
LD R5, USERG
AND R3, R3, #0
ADD R2, R2, #-1
BRp SECONDLOOP

LEA R0, MINIMUM
PUTS
LD R4, GRADEMIN
AND R2, R2, #0
JSR INTSNAP            
LD R0, BLANK            
OUT
JSR RCLEAR
LD R0, LINEN
OUT

;This is where the average is calculated
CALCAVERAGE
LD R2, TOTALTESTS        ;R2 = total tests
LEA R1, USERG            ;R1 = USERG starting address

SUM LDR R5, R1, #0
ADD R4, R4, R5
ADD R1, R1, #1
ADD R2, R2, #-1
BRp SUM

LD R2, TOTALTESTS
NOT R2, R2
ADD R2, R2, #1
ADD R5, R4, #0

THIRDLOOP ADD R5, R5, #0
BRnz AVERAGEFINISHED  	  ;BRnz = control instruction
ADD R6, R6, #1            ;To increment
ADD R5, R5, R2
BRp THIRDLOOP

AVERAGEF
ST R6, SCOREAVERAGE
LEA R0, AVERAGE
PUTS
AND R4, R4, #0
AND R2, R2, #0
AND R5, R5, #0
ADD R4, R4, R6
JSR INTSNAP            

;Average calculation ends here
JSR PGMRESTART
HALT

;Main ends here
;DATA
LINEN            .FILL xA
BLANK            .FILL x20
DECIMALD       	 .FILL #-48
SYMD             .FILL #48
TOTALTESTS       .FILL 5
SECONDR        	 .FILL x3000

GRADEMAX            .BLKW 1
GRADEMIN            .BLKW 1
AVERAGEFINISHED     .BLKW 1
SCOREAVERAGE        .BLKW 1

;Max/Min variables and branches for calculations
MOVETWO
LDR R5, R1, #0
ST R5, GRADEMIN
ADD R1, R1, #1                    ;USERG array up
ADD R2, R2, #-1                   ;counter down
BRnzp SECONDLOOP

MOVEONE                        
LDR R5, R1, #0
ST R5, GRADEMAX
ADD R1, R1, #1                    ;array up
ADD R2, R2, #-1                   ;counter down
BRp FIRSTLOOP

USERG      .BLKW 5
MINIMUM    .STRINGZ    "Minimum "
MAXIMUM    .STRINGZ    "Maximum "
AVERAGE    .STRINGZ    "Average "

;Subroutine time!
;Subroutine that restarts program when the user enters 'y'

PGMRESTART
ST R7, SAVEONE            ;JSR location save
LD R3, LY            	  ;Loads negative Y value
LD R4, UY            
LD R1, ORIGIN             ;This loads ORIGIN x3000

LD R0, LINEN
OUT
LEA R0 PGMRESTART_STR     ;Load string for program restart
PUTS
LD R0, LINEN
OUT

GETC
ADD R2, R2, R0            ;User's input is compared to -y
BRz TRUER           	  ;Branches to restart if true
ADD R4, R4, R0            ;User's input is compared to -Y
BRz TRUER           	  ;Branches to restart if true
HALT                	  ;Else, halt program

TRUER
JMP R1                    ;JMP = control insutruction

;PGMRESTART DATA
PGMRESTART_STR    .STRINGZ    "Thank you for using this program. Would you like to run this program again?"
LY    	.FILL    xFF87    ;-121
UY    	.FILL    xFFA7    ;-89
ORIGIN	.FILL    x3000

;PGMRESTART ends here

;More DATA
SAVEONE     .FILL    x0
SAVETWO     .FILL    x0
SAVETHREE   .FILL    x0
SAVEFOUR    .FILL    x0
SAVEFIVE    .FILL    x0

;GRADE subroutine
GRADE
ST R7, SAVEONE
JSR RCLEAR
LD R5, DECIMALD

;First character
GETC
JSR VALCHECK
OUT

ADD R2, R0, #0            ;Copies inputs to R2
ADD R2, R2, R5            ;Grade is made decimal
ADD R1, R1, #10

M10
ADD R4, R4, R2
ADD R1, R1, #-1            ;Counter decrement
BRp M10            	   ;Loops until counter is made 0

;Second character
GETC
JSR VALCHECK
OUT
ADD R0, R0, R5
ADD R4, R4, R0

LD R0, BLANK
OUT

LD R7, SAVEONE
RET

;GRADE subroutine ends

;INTSNAP subroutine
INTSNAP            
ST R7, SAVEONE
LD R3, SYMD
ADD R5, R4, #0

DIV
ADD R2, R2, #1
ADD R5, R5, #-10
BRp DIV

ADD R2, R2, #-1
ADD R5, R5, #10
ADD R6, R5, #-10
BRnp POS

NEG
ADD R2, R2, #1
ADD R5, R5, #-10

POS
ST R2, QUO
ST R5, REM
LD R0, QUO
ADD R0, R0, R3
OUT
LD R0, REM
ADD R0, R0, R3
OUT

LD R7, SAVEONE
RET

REM    .FILL    x0
QUO    .FILL    x0

;INTSNAP ends here

;PUSH subroutine: adds an item to the stack. 
PUSH
ST R7, SAVETWO
JSR RCLEAR
LD R6, PNTR
ADD R6, R6, #0
BRnz SERROR
ADD R6, R6, #-1    
STR R0, R6, #0
ST R6, PNTR
LD R7, SAVETWO
RET

PNTR    .FILL    x4000    ;Start location for pointer

;PUSH ends here

;POP subroutine: removes an item from the stack
POP
LD R6, PNTR
ST R1, SAVEFIVE
LD R2, BLINE
ADD R2, R2, R6
BRzp SERROR
LD R2, SAVEFIVE
LDR R0, R6, #0
ST R7, SAVEFOUR
OUT
LD R0, BLANK
OUT
ADD R6, R6, #1
ST R6, PNTR
LD R7, SAVEFOUR
RET
SERROR         LEA R0, ERROR
PUTS
HALT
BLINE        .FILL    xC000
ERROR        .STRINGZ    "Stack overflow or underflow detected. The program has been stopped."

;POP ends here

;LETTERGRADE subroutine
;takes numerical grade and returns a letter value
LETTERGRADE
AND R1, R1, #0

GRADEA
LD R0, NUMBERA
LD R2, LETTERA
ADD R1, R4, R0
BRzp STOREG

GRADEB
AND R1, R1, #0
LD R0, NUMBERB
LD R2, LETTERB
ADD R1, R4, R0
BRzp STOREG

GRADEC
AND R1, R1, #0
LD R0, NUMBERC
LD R2, LETTERC
ADD R1, R4, R0
BRzp STOREG

GRADED
AND R1, R1, #0
LD R0, NUMBERD
LD R2, LETTERD
ADD R1, R4, R0
BRzp STOREG

GRADEF
AND R1, R1, #0
LD R0, NUMBERF
LD R2, LETTERF
ADD R1, R4, R0
BRzp STOREG

RET

STOREG
ST R7, SAVEONE
AND R0, R0, #0

ADD R0, R2, #0
JSR PUSH
LD R7, SAVEONE
RET

NUMBERA    .FILL    #-90
LETTERA    .FILL    x41
NUMBERB    .FILL    #-80
LETTERB    .FILL    x42
NUMBERC    .FILL    #-70
LETTERC    .FILL    x43
NUMBERD    .FILL    #-60
LETTERD    .FILL    x44
NUMBERF    .FILL    #-50
LETTERF    .FILL    x46

;LETTERGRADE ends here

;RCLEAR subroutine
RCLEAR
AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0

RET
;RCLEAR ends here

;VALCHECK subroutine
VALCHECK
ST R2, SAVEFIVE
ST R1, SAVEFOUR
ST R4, SAVETHREE

LD R2, MIND
ADD R1, R0, R2
BRn INVALID

LD R2, MAXD
ADD R4, R0, R2
BRp INVALID

LD R2, SAVEFIVE
LD R1, SAVEFOUR
LD R4, SAVETHREE

RET

;VALCHECK ends here

;VALCHECK variables and branches
INVALID
LEA R0, INVALID_STR
PUTS
LD R0, LINEN2
OUT
LD R7, BEGIN
JMP R7

INVALID_STR    .STRINGZ    "Sorry, that entry is invalid. The program will now restart."
BEGIN        .FILL    x3000
MIND        .FILL    #-48    
MAXD        .FILL    #-57
LINEN2        .FILL    xA    

;VALCHECK variables and branches ends here

;This is the end of program
.END