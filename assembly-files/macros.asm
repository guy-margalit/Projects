;all my macros in a seperate file
;macro that gets 2 variables and compares them
macro cmpByte memory1, memory2
	mov al, [byte ptr memory2] ;moves one memory in to al
	cmp [byte ptr memory1], al ;compares the other memory to al
endm cmpByte

;macro that gets color (number), char (number) and 2 variables and then draws a character (color and char) 
;in a random location and retrns it's location to the 2 variables
macro drawObject cord_x, cord_y, charColor, char
	mov [color], charColor ;moves the char color in to the color to print it later
	mov [charac], char ;moves the char in to the charac to print it later
	call drawFood ;calls the draw food proc that prints the character in randm location
	movByte cord_x, x_temp ;moves the random x_cord in to the given variable
	movByte cord_y, y_temp ;moves the random y_cord in to the given variable
endm drawObject

;macro that gets a variable and a number and return a random number 
;(from 1-the number that was given+1) inside the variable given 
macro randomNumber result, max
	mov bx, [bx_saver]
	; put segment number in register es 
	mov ax, 40h
	mov es, ax
	; move random number to ax
	mov ax, [es:6Ch]
	xor ax, [bx]
	add [bx_saver], ax
	and al, max ;checks that al is within given range 
	inc al ;increase al so it won't be 0
	mov [result], al ;moves al (the random number into the given result variable
endm randomNumber

;macro that gets 2 variables and sets the cursore to that location
macro setCords x, y
	mov dh, [y] ;moves the given y_cord to dh for setting the cursore
	mov dl, [x] ;moves the given x_cord to dl for setting the cursore
	call setCursorePosition ;calls the proc that sets the cursore to the coordinates in dh and dl
endm setCords

;macro that gets 2 variables and moves the second inside the first
macro movByte byte1, byte2
	mov al, [byte2] ;moves one memory to al
	mov [byte1], al ;moves al to the other memory
endm movByte

;macro that gets a string and rints it
macro print string
	mov dx, offset string ;offsets the string to dx
	call printString ;calls the proc that prints the string from dx
endm print