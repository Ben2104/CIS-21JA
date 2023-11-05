TITLE Lab 3: Define variables, IO			

;;;;; Q1: Don't forget to document your program 			
; Name:   Hoang Khoi Do
; Date:   10/16/2023

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Answer each question below by writing code at the APPROPRIATE places at the end
;;;;; of the file as indicated.

;;;;; Q2: Write the directive to bring in the IO library			

;;;;; Q3: Create a constant called DAYS_PER_WEEK and initialize it to 5
;;;;;     Create a constant called WEEKS_PER_YEAR and initialize it to 49

;;;;; Q4: Create a constant called DAYS_PER_YEAR by using DAYS_PER_WEEK and 
;;;;;     WEEKS_PER_YEAR (of Q3) in an integer expression constant

;;;;; Q5: Define an array of 10 signed doublewords, use any array name you like. 
;;;;;     Initialize:
;;;;;	- the 1st element to the DAYS_PER_YEAR value defined in Q4
;;;;;	- the 2nd element to the hexadecimal value: B285
;;;;;	- the 3rd element to the 4-bit binary value: 1001 
;;;;;	- the 4th element to the decimal value: -250
;;;;; and leave the rest of the array uninitialized.  

;;;;; Q6. Define the string "Output = ", use any variable name you like.

;;;;; Q7. Define a prompt that asks the user for a negative number

;;;;; Q8. Write code to prompt the user for a number, using the prompt string that 
;;;;;     you defined in Q7

;;;;; Q9. Write code to read in the user input, which is guaranteed to be negative 

;;;;; Q10. Write code to print "Output = " and then print to screen the user input
;;;;;	   which should be a negative value

;;;;; Q12. Write code to print "Output = " and then print the first element of the 
;;;;;      array defined in Q5, without the + symbol in front.

;;;;; Q13. Build, run, and debug your code
;;;;; Your output should be similar to this (without the commented explanation)

;;;;; Enter a negative number: -10
;;;;; Output = -10							
;;;;; Output = 245							
;;;;; Press any key to continue . . .

;;;;; Q14. At the end of the source file, without using semicolons (;), add a comment 
;;;;;      block to show:
;;;;;	   - how bigData appears in memory. You should copy from the debugger memory
;;;;;        window the correct number of bytes for the answer.
;;;;;      - note that the 8 bytes in memory doesn't look identical to the 8 bytes
;;;;;        that are used to define bigData. Explain why the 8-byte sequences
;;;;;        are different

;;;;; 1pt EC (Extra Credit):
;;;;; In the same comment block, explain how many bytes the array of Q5 occupy 
;;;;; in memory. Make sure to explain how you arrive at the number of bytes.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;   Put your answers below this line, in the correct locations
INCLUDE Irvine32.inc
	DAYS_PER_WEEK = 5
	WEEKS_PER_YEAR = 49
	DAYS_PER_YEAR = 49*5
.data
	arr sdword DAYS_PER_YEAR, 0b285h, 1001b, -250, ?, ?, ?, ?, ?, ?
	output byte "Output = ", 0
	prompt byte "Input a negative number: ", 0


bigData QWORD 9876543210fedcbah
	

.code
main PROC

	mov edx, OFFSET prompt
	call writestring
	call ReadInt

	mov edx, OFFSET output
	call writeString
	call writeInt
	call crlf

	mov edx, OFFSET output
	call writestring
	mov eax, [arr]
	call writeDec

	exit	
main ENDP

END main

COMMENT !
	bigData: ba dc fe 10 32 54 76 98
	The data type of bigData is QWORD which is 8 bytes. Beside, the value of bigData is a hexadecimal value because it has 'h' at the end.
	the sequence is different because the bytes of each element are in little endian order (lowest byte at lowest address)
	
	there are 40 bytes the array occupy in memory. Becaues the data type of the array is sign double word which is 4 bytes/element.
	And there is 10 elements in this array => 4 bytes * 10 = 40 bytes 
	arr: f5 00 00 00 b0 85 02 00 09 00 00 00 06 ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
!
