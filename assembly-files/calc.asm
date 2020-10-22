IDEAL
MODEL small
STACK 100h
p186
DATASEG
;var for printing the answer
ten db 10
;input var
num1 db 0
;input var
num2 db 0
;var that keeps the leftover
keep db 0
;var that keeps instructions
input_text db 'Enter one digit number: $'
add_text db 'Addition: $'
sub_text db 'Subtraction: $'
mul_text db 'Multiplication: $'
div_text db 'Division: $'
CODESEG
;proc to get input to al
proc readUserInput
	; get user first input number to al
	mov ah, 1h
	int 21h
	sub al, '0'
	ret
endp readUserInput
;proc to get input to al
proc newLine
	pusha
	; new line
	mov dl, 0ah
	mov ah, 2h
	int 21h
	popa
	ret
endp newLine
;proc to print the result
proc printNum
	pusha
	; print the result stored in AL
	mov ah, 0
	div [ten]
	add ax, '00'
	mov dx, ax
	mov ah, 2h
	int 21h
	mov dl, dh
	int 21h
	popa
	ret
endp printNum
start:
	mov ax, @data
	mov ds, ax
mainLoop:
	; print message
	mov dx, offset input_text
	mov ah, 9h
	int 21h 
	
	call readUserInput
	
	; move user input to [num1]
	mov [num1], al
	
	;exit if equals 0
	cmp [num1], 0
	je exit1
	
	call newLine
	
	; print message
	mov dx, offset input_text
	mov ah, 9h
	int 21h 
	
	call readUserInput
	
	; move user input to [num2]
	mov [num2], al
	
	;exit if equals 0
	cmp [num2], 0
	je exit1
	
	call newLine
	
	;print the add text
	mov dx, offset add_text
	mov ah, 9h
	int 21h 
	
	;add operation
	mov al, [num1]
	add al, [num2]
	call printNum
	call newLine
	
	;print the sub text
	mov dx, offset sub_text
	mov ah, 9h
	int 21h 
helpJ:
 jmp helpJ1
exit1:
 jmp exit
helpJ1:
	;sub operation
	mov al, [num1]
	sub al, [num2]
	call printNum
	call newLine
	
	;print the mul text
	mov dx, offset mul_text
	mov ah, 9h
	int 21h 
	
	;mul operation
	mov al, [num1]
	mov bl, [num2]
	mul bl
	call printNum
	call newLine
	
	;print the div text
	mov dx, offset div_text
	mov ah, 9h
	int 21h 
	
	;div operation
	mov ax, 0
	mov al, [num1]
	mov bl, [num2]
	div bl
	mov [keep], ah
	call printNum
	
	;print char 
	mov dl,' ' 
	mov ah, 2
	int 21h
	
	;print char
	mov dl,'('
	mov ah, 2
	int 21h
	
	mov al, [keep]
	
	call printNum
	
	;print char
	mov dl,')'
	mov ah, 2
	int 21h
	
	call newLine
	
	;restarts the calculator
	jmp mainLoop
	
exit:
	mov ax, 4c00h
	int 21h
END start


