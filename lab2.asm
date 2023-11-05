TITLE Assignment 2 Lab				

; The purpose of this lab is to introduce debugging features of the IDE 
; and reinforce concepts of modules 1 and 2.
; By successfully finishing this lab you will learn basic debugging 
; skills that will help you debug your labs later in the quarter.

; There are 3 debugging techniques that you will learn in this lab:
; 1. how to set a break point so execution will stop at a certain line of code, 
;     and then how to step through each subsequent line of code
; 2. how to look at data stored in registers
; 3. how to look at data stored in memory

;;;;;; STEP 1: How to document all your programs in this class			;;;;;;;
; Name: Hoang Khoi Do

INCLUDE Irvine32.inc

.data
bigData QWORD 9876543210fedcbah

.code
main PROC

;;;;;; STEP 2: How to set a breakpoint:									;;;;;;
;;;;;;         Set the break point at the "mov" line of code below by	;;;;;;
;;;;;;         clicking in the grey border on the left of this text		;;;;;;
;;;;;;         editor window, at the line of code.						;;;;;;
;;;;;;         You should see a red circle appear in the border if		;;;;;;
;;;;;;         you've successfully set the breakpoint.					;;;;;;
	mov eax, -2		; set the breakpoint on this line
	
;;;;;; STEP 3: How to start the program and run to the breakpoint:		;;;;;;
;;;;;;         At the Debug pull down menu, select Start Debugging so	;;;;;;
;;;;;;         that execution will run to the break point and stop		;;;;;;
;;;;;;         right BEFORE running the line of code at the breakpoint. ;;;;;;
;;;;;;         You should see a yellow arrow pointing at the 'mov' line ;;;;;;
;;;;;;         of code, indicating that 'mov' is the next instruction 	;;;;;;
;;;;;;         that will run.											;;;;;;

;;;;;; STEP 4: How to look at register values at a breakpoint:			;;;;;;
;;;;;;         At the Debug pull down menu, select Windows -> Registers ;;;;;;
;;;;;;         This opens the register window, showing the content      ;;;;;;
;;;;;;         of all registers, in hexadecimal.                        ;;;;;;

;;;;;; STEP 5: How to step through each line of code:					;;;;;;
;;;;;;         At the Debug pull down menu, select Step Into or hit F11 ;;;;;;
;;;;;;         to step through (execute) the line of code.				;;;;;;
;;;;;;         You should see changes in the register window, in red,   ;;;;;;
;;;;;;         after the line of code runs.								;;;;;;
;;;;;;         Running a line of code always changes at least			;;;;;;
;;;;;;         1 register value											;;;;;;
;;;;;;		   The new (red) value of EAX is the result of the 'mov'	;;;;;;
;;;;;;		   instruction												;;;;;;

;;;;;; STEP 6: Follow the instructions of step 5 to step through each	;;;;;;
;;;;;;         of the 4 lines of code below.							;;;;;;
;;;;;;         For each line of code:									;;;;;;
;;;;;;         - hit F11 or select Step Into (You should see the yellow ;;;;;;
;;;;;;           arrow move to the next line of code)					;;;;;; 
;;;;;;         - then record the value of the register that you see     ;;;;;;
;;;;;;           in the register window in the file Lab2.docx			;;;;;;
;;;;;;         Make sure the value you enter MATCHES THE SIZE of the	;;;;;;
;;;;;;         register in the question. For example, AH will not have	;;;;;;
;;;;;;		   the same number of digits as EAX.						;;;;;;
;;;;;;         And make sure that you record the register value	AFTER	;;;;;;
;;;;;;         you've run the line of code next to it, which means 		;;;;;;
;;;;;;         AFTER the arrow has moved to the next line of code.  	;;;;;;

;;;;;;         Note: After you type in the first value and step through ;;;;;;
;;;;;;         the next line of code, the debugger will warn you that   ;;;;;;
;;;;;;         the source file has been changed.						;;;;;;
;;;;;;         You can hit OK to continue because you're only changing  ;;;;;;
;;;;;;         the comments, not the code.								;;;;;;

	mov ah, 101b	;   AX =		(record the value in lab2.docx file)
	sub ah, 0ch		;   AH =		(record the value in lab2.docx file)
	inc al			;   AL =		(record the value in lab2.docx file)
	xor eax, 0ffffh ;   EAX =		(record the value in lab2.docx file)

;;;;;; STEP 7:  How to see memory values:								;;;;;;
;;;;;;			From the Debug pull down menu, select Memory -> Memory1 ;;;;;;
;;;;;;			At the memory window Address field, type in             ;;;;;;
;;;;;;			"&bigData" without quotes. (Those with C language       ;;;;;;
;;;;;;			background will notice that &bigData means "address		;;;;;;
;;;;;;			of bigData")											;;;;;;
;;;;;;			As shown in the class notes, the left column has the    ;;;;;;
;;;;;;			address of the memory, and the middle column is the     ;;;;;;
;;;;;;			data that's stored in memory.                           ;;;;;;
;;;;;;			The first 8 bytes of data shown in the memory window    ;;;;;;
;;;;;;			is bigData's value.	Recall that each byte of data is    ;;;;;;
;;;;;;			2 hexadecimal digits.			     			        ;;;;;;
;;;;;;			Enter below what bigData looks like in memory.			;;;;;;

;    bigData in memory = 


;;;;;; STEP 8: How to stop debugging                               ;;;;;;
;;;;;;         At the Debug pull down menu, select Stop Debugging  ;;;;;;
;;;;;;         Execution should stop and the program ends          ;;;;;;


	call crlf
	exit	
main ENDP

END main