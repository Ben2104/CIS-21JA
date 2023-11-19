TITLE  Assignment 7: procedures and macros
;Name: Hoang Khoi Do

INCLUDE Irvine32.inc

mWriteStr MACRO buffer
	push edx
	mov edx, offset buffer

	call writestring
	call crlf
	pop edx

ENDM 

.data
	prompt BYTE "Enter a positive number: ", 0
	negative_error BYTE "Number must be positve", 0
	overflow_error BYTE "your value is over 16bits, the max value is 65535", 0
	hexString BYTE 4 DUP ('0'),'h',0
	continue BYTE "Continue? y/n:"
.code

main PROC

mainLoop:
	
	push esi			;save room for the address returning
	;push 3 arguements to the stack for readInput
	push offset prompt	
	push offset negative_error
	push offset overflow_error


	call readInput
	pop eax			;retrieve the valid integer from the readInput
	
	mov edi, offset hexString
	call convert
	
	mov ecx, 4
	mov ebx, 0
;Check if there is 0s lead and erase it
hexLoop:
	cmp hexString[ebx], '0'
	jne next
	clearElement:
		mov hexString[ebx], 8h		;8h is the backspace in ascii table to clear the element that is 0s lead
		inc ebx
	next:
		loop hexLoop

	mWriteStr hexString
	mWriteStr continue
	call readchar
	call writeChar
	call crlf
	

	mov dword ptr [hexString], '0000'	;reset the hexString array
	
	cmp al, 'y'
	je mainLoop
	cmp al, 'Y'
	je mainLoop

COMMENT !
	for (ecx = 0; ecx < 4; ecx++){
		set ebx = 0
		if (hexString[ebx] == '0'){
			mov hexString[ebx], 8h	to remove the 0s
			ebx++
		}
	}
!


	exit	
main ENDP



;stack frame:
;	ret value		+20
;	prompt			+16
;	negative_error	+12
;	overflow_error	+8
;	ret address		+4
;	ebp
;	eax

readInput PROC
	push ebp

	mov ebp, esp

	push eax
;[ebp + 16] => prompt
;[ebp + 12] => negative_error
;[ebp + 8] => overflow_error

Prompt_user:
	mWriteStr prompt
	call readInt
	 
	cmp eax, 0		;if the input is negative jump to negativeError
	js negativeError
	cmp eax, 65535
	ja overflowError; if the input is over 2^16 jump to overflowError
	
	mov [ebp + 20], eax
	pop eax
	pop ebp



	ret 4*3

overflowError:
	mWriteStr overflow_error
	jmp Prompt_user

negativeError:
	mWriteStr negative_error
	jmp Prompt_user

readInput ENDP

convert PROC
;while (eax != 0)
; mov ebx, eax
; masking with 1111 retrieves the remainder
; eax/= 16

	
	
	convertLoop:
		mov ebx, eax
		and ebx, 0Fh
		shr eax, 4

		call toChar
		
		;set ecx to 3
		mov ecx, 3
		mov [edi + ecx], bl		;add edi + 3 to store the hexstring to the 3rd element and decrement edi until eax = 0 		
		dec edi

		test eax, 1			;test if eax is 0 
		jnz convertLoop

	ret


convert ENDP

toChar PROC
	cmp bx, 10
	jae elseBlock

	;if (bx < 10){
	;	bl += 30h
	;}
	;else{
	;	bl += 37h
	;}
	ifBlock:
		add bl, 30h
		jmp break
	elseBlock:
		add bl, 37h

	break:
		ret

toChar ENDP
END main