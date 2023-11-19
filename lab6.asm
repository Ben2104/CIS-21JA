TITLE  Assignment 6: Bit-wise instructions

;;; lab requirement: use bitwise instructions when possible to make the code shorter
		
; Name:  Hoang Khoi Do

INCLUDE Irvine32.inc

.data
num1 BYTE "Number of ones in ", 0				; output for questions 1 and 2
is BYTE " is ", 0								; output for questions 1 and 2
arr BYTE 1, -2, 3, -4, 5, -6, 7, -8				; array for question 3


.code
main PROC
; Question 1 (5pts)
; Add code below to print how many 1 bits there are in the binary value in eax.
; The final value of eax should remain the same so it can be printed out.
; You cannot copy the value of eax to another register in order to do the counting of 1's.

mov eax, -17	; change eax value to test your code
;; add code to count number of 1's here:

mov ecx, 32 
mov ebx, 0	;set the counter to 0

bitLoop:
	ror eax, 1			; test if the LSB is 1, if the ZF is not set jump to setBit
	test eax, 1
	jnz setBit

	jmp nextBit
setBit: 
	inc ebx
nextBit: 
	loop bitLoop
	
mov edx, OFFSET num1	; print "Number of ones in "
call writeString
call writeInt			; print eax value
mov edx, OFFSET is
call writeString		; print " is "
;; add code to print the number of 1's here:
mov eax, ebx
call writeDec
call crlf

; Question 2
; Another way to print how many 1's there are in eax is described in the classic
; "The C Programming Language" book by Kernighan and Ritchie: 
;      for (c = 0; v; c++)    // v is the value to be counted, c is the count of 1's
;         v &= v - 1; 
; The pseudocode is:
;   set c to 0
;   while v != 0
;       v = v and (v-1)   where 'and' is the bit-wise and operation
;       increment c

;; (2pts) Implement the pseudocode in assembly:
mov eax, -17			; v is eax value

mov esi, eax			;store eax into esi
mov ebx, 0				; set c to 0

whileLoop:

	test eax, eax
	mov ecx, eax	; mov eax into ecx
	jz loopExit		;as long as eax is not 0

	dec ecx			; v-1
	and eax, ecx	; v and v v-1
	inc ebx			; increment c
	jmp whileLoop	; go back to whileLoop


loopExit: ;break the loop

mov eax,esi
mov edx, OFFSET num1	; print "Number of ones in "
call writeString
call writeInt			; print eax value
mov edx, OFFSET is
call writeString		; print " is "
;; add code to print the number of 1's here:
mov eax, ebx
call writeDec
call crlf




; (3pts) Between the algorithms in Question 1 and Question 2, which one is likely to run faster?
; Explain why it's faster.
; You'll need to work out by hand some examples of the 2nd algorithm to understand how it works
; in order to see which way is faster.

COMMENT !
	I think the algorithms in question 2 is likely to run faster because it iterates in the loop most likely less than
	algorithms in question 1. For algo 1, we have to assume that the loop is 32 because of eax is 32 bits.

	For example, we work on decimal 3 which is 0000 0110 in binary, for the algo 1 we have to loop over 32 times while we just need 2 times of iteration
	to get the result.  
!



; Question 3 (5pts): Given an array  arr  as defined in .data, and ebx is initialized below.
; Using ebx (not the array name), write ONE instruction to reverse the MSB of the last 4 elements of arr.  
; Reverse means 0 changes to 1 or 1 changes to 0.  
; Your code should work with any value in arr (not just the sample values above).

; arr BYTE 1, -2, 3, -4, 5, -6, 7, -8				; array for question 3

mov ebx, OFFSET arr
xor dword ptr [ebx + sizeof arr - 4], 80808080h


	exit	
main ENDP

END main
