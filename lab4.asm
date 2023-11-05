TITLE  Assignment 4: arithmetic and status flags
; Don't forget this beginning documentation block
; Name: Hoang Khoi Do
 
; Part 1 (9 pts): Find minimum number of coins
INCLUDE Irvine32.inc
MAX = 1000
.data
amount byte "Amount= ", 0
cents BYTE " cents", 0
quarters BYTE " quarters, ", 0
dimes BYTE " dimes, ", 0
nickels BYTE " nickels, ", 0
pennies BYTE " pennies", 0
.code
main PROC
	call randomize			; generate a seed for the random number generator. This is done once in the program.

	;call random number into cents
	mov edx, OFFSET amount
	call writestring
	mov eax, MAX
	call randomRange
	call writedec			;print amount
	mov edx, OFFSET cents
	call writestring
	call crlf
		
	;CALCULATION:

	;calculate the quarters
	mov bl, 25			;random number / 25 = quotient quarters
	div bl
	mov cl, ah			;ah is the remainder, 
						;store ah into cl for the next calculation
	movzx eax, al		
	call writedec		;print the quarters
	mov edx, OFFSET quarters
	call writestring

	;calculate the dimes
	mov al, cl			;mov the remainder into al
	mov bl, 10			;remainder / 10 = quotient quartes
	div bl
	mov cl,ah
	movzx eax, al
	call writedec		;print the dimes
	mov edx, OFFSET dimes
	call writestring

	;calculate the nickels
	mov al, cl			;mov the remainder into al again
	mov bl, 5			;remainder / 10 = quotient nickels
	div bl
	mov cl, ah			;store ah which is the remainder from the calculation
						;into cl for pennies
	movzx eax, al
	call writedec		;print the nickels
	mov edx, OFFSET nickels
	call writestring

	;calculate the pennies
	mov al,cl			;mov the remainder from the above calculation into al 
	movzx eax, al
	call writedec		;print the pennies
	mov edx, OFFSET pennies
	call writestring


	
	exit	
main ENDP

END main


COMMENT !
Part 2 (6 pts): status flags

Assume ZF, SF, CF, OF are all clear at the start, and the 3 instructions below run one after another. 
Do the following 3 steps:
a. fill in the value of all 4 flags after each instruction runs 
b. explain why CF and OF flags have the value you chose.
   Your explanation should not refer to signed or unsigned data values, 
   the ALU doesn't see data as signed or unsigned but it can still set the flags.
   This means your explanation should not say: 
   "because 124 is too large for a byte" (since it's only too large for unsigned data)
   or "2 positive numbers cannot add to a negative number" (since positive/negative refer to signed data)
   Instead, use the same reasoning that the CPU uses.
   Hint: see the class exercise solution for how the reasoning that the CPU uses.
c. answer yes or no for the questions

mov al, 0B0h 
add al, 70h     
; a. ZF = 0  SF = 0  CF = 1  OF = 0 
; b. explanation for CF:  1011 0000 + 0111 0000 = (1) 0010 0000 => CF = 1
;    explanation for OF: carry in is 1 and carry out is 1 => 1 xor 1 = 0
; c. If unsigned data, is it valid?   No
;     If signed data, is it valid?    Yes
;	
sub al, 0a0h   => 0010 0000 - 1010 0000
using 2's complement to reverse 1010 0000 -> 0110 0000
=> 0010 0000 + 0110 0000 = (0) 1000 0000 because we use the 2's complement therefore the CF is 1
; a. ZF = 0  SF = 1  CF = 1  OF = 1
; b. explanation for CF: because the carry out is 0 => CF = 1
;    explanation for OF: the carry out is 0 and carry in is 1 => 0 xor 1 = 1 => OF = 1
; c. If unsigned data, is it valid? No
;     If signed data, is it valid? No
!