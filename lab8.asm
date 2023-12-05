TITLE  Assignment 8
;Name: Hoang Khoi Do


INCLUDE Irvine32.inc 

	MAX = 415
	MIN_A = MAX * 90/100
	MIN_B = MAX * 80/100
	MIN_C = MAX * 70/100
	numcol = 8
	numrow = 3
mWriteStr MACRO string	;macro for printing the string
		push edx
		mov edx, offset string
		call writeString
		pop edx
ENDM 

mNum MACRO numbers	;macro for the numbers with space
	push eax
	mov eax, numbers
	call writeInt
	mov eax, ' '
	call writeChar
	pop eax
ENDM 

mBracket MACRO numbers	;macro for the numbers in the bracket
	push eax
	mov eax, '['
	call writeChar
	mov eax,  numbers
	call writeDec
	mov eax, ']'
	call writeChar
	pop eax
ENDM 
.data
scores	DWORD	0, 0, 2, 2, 0, 0, 3, 0		; Extra credit
		DWORD	5, 3, 4, 4, 5, 1, 3, 5		; quizzes
		DWORD	14,14,12,11,13,12,11,12		; lab

mid1 DWORD 72  ; midterm 1
mid2 DWORD 64    ; midterm 2

	drop BYTE "Dropping quiz at [row][col]: ", 0
	string BYTE "Min final scores for A, B, C: ", 0
.code

main PROC

COMMENT !

	print("Dropping quiz at: ")
	dropScore(scores, 2) # print the row and col of the quiz score being set to 0
	print("Min final scores for A, B, C: ")
	calcFinal(scores, mid1, mid2) # print the minimum final score for A, B, C grade
!
	mWriteStr drop
	push offset scores
	push 2
	call dropScore	;dropScore(scores, 2)
	push offset scores
	push mid1
	push mid2
	call crlf
	mWriteStr string
	call calcFinal	;calc(scores, mid1, mid2)
	
	exit
main ENDP

;stack frame
;	addr scores	+12
;	2			+8
;	ret addr	+4
;	ebp

dropScore PROC
	push ebp
	mov ebp, esp

	pushad
	mov esi, [ebp + 12]
	mov ebx, [ebp + 8]
	mov eax, numcol
	dec ebx		; dec ebx to access the row of 2d array
	mul ebx		;eax = ebx * numcol
	shl eax, 2	;eax = ebx * numcol * 4
	mov ecx, eax	
	add esi, ecx	;set the esi to row 2
	
	COMMENT !
	5, 3, 4, 4, 5, 1, 3, 5	
	index = 0
	lowest = scores[0]
	    for (int i = 8; i > 0; i--){
		current = scores[numcols - i]
        if (current < lowest)
        {
            lowest = current
            index = i
        }
    }
	index = numcol - index
	index += 1
!

	mov ecx, numcol
	mov ebx, 0		;set index to 0
	mov edx, [esi]	;set edx as the first element to the lowest value
	cld
	
top:
	lodsd
	cmp eax, edx		
	ja next				;fall through logic
ifBlock:
	mov edx, eax		; set lowest = current
	mov ebx, ecx		; index = i 
next:
	loop top

	mov ecx, numcol		
	sub ecx, ebx		;subtract the ebx to get the right index
	mov ebx, ecx		; index = numcol - index
	;esi 5, 3, 4, 4, 5, 1, 3, 5
	sub esi, numcol * 4
	mov dword ptr [esi + ebx * 4], 0	;set the lowest value to 0
	inc ebx
	mBracket [ebp + 8]		;print the row number
	mBracket ebx		;print the column number where numbering starts at 1
	popad
	pop ebp

	ret 8
dropScore ENDP

;stack frame
;	addr scores		+16
;	mid1			+12
;	mid2			+8
;	ret address		+4
;	ebp			

calcFinal PROC
	push ebp
	mov ebp, esp

; scores   DWORD 0, 0, 2, 2, 0, 0, 3, 0
;		   DWORD 5, 3, 4, 4, 5, 1, 3, 5
;		   DWORD 14,14,12,11,13,12,11,12

COMMENT !
	set total = 0
	
	for (i = 0; i < scores.size(); i++){
		total += scores[i]
	}
!
	pushad 
	mov ebx, 0			;set total = 0 
	mov esi, [ebp + 16]
	mov ecx, numcol * numrow	;set ecx = to the size of the array
Total:
	lodsd
	add ebx, eax		;total += scores[i]	
	loop Total
	
	add ebx, [ebp + 12]	;total = total + mid1
	add ebx, [ebp + 8]	;total = total + mid2

	mov eax, MIN_A
	mov ecx, MIN_B
	mov edx, MIN_C

	sub eax, ebx
	sub ecx, ebx
	sub edx, ebx

	mNum eax
	mNum ecx
	mNum edx

	popad
	pop ebp

	ret 4*3

calcFinal ENDP
END main