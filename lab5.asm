TITLE  Assignment 5: Branching and review of arithmetic operations
;name: Hoang Khoi Do

INCLUDE Irvine32.inc

.data
	prompt BYTE "Enter a positive number: ", 0
	negative_error BYTE "Number must be positve", 0
	overflow_error BYTE "your value is over 16bits, the max value is 65535", 0
	hexString BYTE 4 DUP (?),'h',0
	resultString BYTE "The hexadecimal value is ", 0
.code

main PROC

Prompt_user:
	mov edx, OFFSET prompt	;prompt the user to enter the positve number
	call writeString
	call readInt
	cmp eax, 0		;if the input is negative jump to negativeError
	js negativeError
	cmp eax, 65535
	ja overflowError; if the input is over 2^16 jump to overflowError
	
	mov ecx, 4	
	mov ebx, 3
ConvertLoop:	;loop until ecx is 0 and store the Loop into hexString
	;Calculation for converting decimal into hexadecimal:
	mov dx, 0
	mov si, 16
	div si
	;if (dx < 10)
	;	dl = dl + 30 to get the ascii character
	;
	;else
	;	dl = dl + 37 ; to get the ascii character of 10-15
	cmp dx, 10		;compare the remainder to 10
	jae elseBlock   ;jump to elseBlock if dx > 10

	ifBlock:		
		add dl, 30h
		jmp StorehexString		;jmp over elseBlock
	elseBlock:
		add dl, 37h
	StorehexString: 
		 mov hexString[ebx], dl	;store the convertion of heximal value in the hexString array
		 dec ebx
		 loop ConvertLoop		;loop the ConvertLoop
								;the loop will end until ecx is 0

	mov edx, offset resultString
	call writestring
	mov edx, offset hexString	; print the hexString
	call writestring
	
	call crlf
	jmp Prompt_user				; jump back to Prompt_user to continue prompting the user

COMMENT !
	StorehexString:
		we need to store the character from the convertion into the hexString array
		mov hexString[3], dl
		mov hexString[2], dl
		mov hexString[1], dl
		mov hexString[0], dl
		
		to not repeat the code, we use the loop with ecx = 4 and ebx = 3
!



overflowError:					;if the input is over 2^16, call the error
	mov edx, OFFSET overflow_error
	call writestring
	call crlf
	jmp Prompt_user				;jump back to the Prompt_user

negativeError:					;if the input is negative, call the error
	mov edx, OFFSET negative_error
	call writestring
	call crlf
	jmp Prompt_user				;jump back to the Prompt_user

	exit	
main ENDP

END main