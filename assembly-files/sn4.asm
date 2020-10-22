IDEAL
MODEL small
STACK 100h
DATASEG
; --------------------------
; Your variables here
	x_temp dw 140
	x_coordinate dw 140
	y_temp dw 100
	y_coordinate dw 100
	color dw 6
	len dw 5
	direction db 2 ; down-0, up-1 right-2, left-3
	limit dw 0
	scale dw 5
	eatenapple dw 0
	x_applegrid dw 0
	y_applegrid dw 0
	x_applenotgrid dw 0
	y_applenotgrid dw 0
	x_frame dw 5
	y_frame dw 5
	eatenapples_counter dw -1
	apples_to_win dw 50 ; keep number under 50 for the smoothest game, don't go over 300 no matter what
	
	y_snake dw 100,100,100,100,100,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	x_snake dw 140,145,150,155,160,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1

	StartScreen db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '                 Snake', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '         To Start Game Press P', 10, 13
	db '      To Read Instructions Press R', 10, 13
	db '           To Exit Press Esc', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '       Made By Alon Gilaie Dotan', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13, '$'
	
	InstructionScreen db '', 10, 13
	db '          Snake Instructions', 10, 13
	db '', 10, 13
	db '- The Objective Of The Game Is To Eat', 10, 13
	db '  50 Apples Without Dying', 10, 13
	db '- An Apple Will Apper Randomly On The', 10, 13
	db '  Screen And You Will Need To Eat It To', 10, 13
	db '  Make Your Snake Longer', 10, 13
	db '- To Eat An Apple You Need To Run Into', 10, 13
	db '  It With Your Snake', 10, 13
	db '- You Will Die If You Hit Yourself Or', 10, 13
	db '  The Frame', 10, 13
	db '- Keys:', 10, 13
	db '- Press Up To Move Snake Up', 10, 13
	db '- Press Down To Move Snake Down', 10, 13
	db '- Press Left To Move Snake Left', 10, 13
	db '- Press Right To Move Snake Right', 10, 13
	db '', 10, 13
	db '- Press P To Begin Playing', 10, 13
	db '- Press Esc To Exit', 10, 13
	db '', 10, 13
	db '- Good Luck', 10, 13,'$'
	
	GameOverScreen db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '               Game Over', 10, 13
	db '          Thanks For Playing', 10, 13
	db '          Press P to Restart', 10, 13
	db '          Press Esc to Exit', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '       Made By Alon Gilaie Dotan', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13, '$'
	
	CongratulationsScreen db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '       Congratulations, You Won', 10, 13
	db '          Thanks For Playing', 10, 13
	db '          Press P to Restart', 10, 13
	db '          Press Esc to Exit', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '       Made By Alon Gilaie Dotan', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13
	db '', 10, 13, '$'
	
; --------------------------
CODESEG
proc DrawPixel
	push ax
	push bx
	push cx
	push dx
	xor bh, bh
	mov cx, [x_temp]
	mov dx, [y_temp]
	mov ax, [color]
	mov ah, 0ch
	int 10h ; set color for single pixel
	pop dx
	pop cx
	pop bx
	pop ax
	ret
	endp
	
proc DrawLine
	push ax
	push bx
	push cx
	push dx
	mov cx, [len]
	mov ax, [x_coordinate]
	mov [x_temp], ax	
Pixel:
	call DrawPixel
	inc [x_temp]
	loop Pixel
	pop dx
	pop cx
	pop bx
	pop ax
	ret
	endp

proc DrawSquare
	push ax
	push bx
	push cx
	push dx
	mov cx, [len]
	mov ax, [y_coordinate]
	mov [y_temp], ax
Line:
	call DrawLine
	inc [y_temp]
	loop Line
	mov bx, [y_coordinate]
	mov [y_temp], bx
	pop dx
	pop cx
	pop bx
	pop ax
	ret
	endp

proc Delay
	push ax
	push bx
	push cx
	push dx
	mov cx, 01h
	mov dx, 000h
	mov ah, 86h
	int 15h ; wait function
	call CheckLoc
	call CheckColor
	call ReceiveChar
	pop dx
	pop cx
	pop bx
	pop ax
	ret
	endp
	
proc ReceiveChar
	push ax
	push bx
	push cx
	push dx
	mov ah, 1h 
	int 16h ; wait for key in the keyboard buffer
	jnz CheckChar
	jmp CheckDirection
CheckChar:
	mov ah, 0h 
	int 16h ; wait for key
	cmp ah, 48h ; check if up arrow was pressed
	jne C1
	call MoveUp
C1:
	cmp ah, 4bh ; check if left arrow was pressed
	jne C11
	call MoveLeft
C11:
	cmp ah, 4dh ; check if right arrow was pressed
	jne C111
	call MoveRight
C111:
	cmp ah, 50h ; check if down arrow was pressed
	jne CheckDirection
	call MoveDown
CheckDirection:
	cmp [direction], 0
	jne A1
	call MoveDown
A1:
	cmp [direction], 1
	jne A11
	call MoveUp
A11:
	cmp [direction], 2
	jne A111
	call MoveRight
A111:
	call MoveLeft
	pop dx
	pop cx
	pop bx
	pop ax
	ret
	endp
	
proc MoveUp ; moves snake upwards
	push ax
	push bx
	mov bx, 0
	cmp [direction], 0 ; checks that snake won't do a 180 degrees turn
	jne B1
	call MoveDown
B1:
	mov [direction], 1 ; changes direction to new direction of movement
	add bx, 2
	cmp [eatenapple], 1 ; check if apple was eaten in last movement
	jne NotAteUp
	jmp AteUp
NotAteUp:
	cmp [y_snake+bx], -1
	je FinSnakeUpNotAte
	add bx, 2
	jmp NotAteUp ; loop until you reach one spot after the snake in the array (value there is -1)
FinSnakeUpNotAte:
	sub bx, 2 ; returns to spot in array that represents the snake's head
	mov [color], 0 ; changes color of square to black (color of the background)
	mov ax, [y_snake+0] ; move the y value for the tail of the snake to ax
	mov [y_coordinate], ax
	mov ax, [x_snake+0] ; move the x value for the tail of the snake to ax
	mov [x_coordinate], ax
	call DrawSquare ; draws a black square on the tail of the snake (essentially erasing the tail)
	mov [color], 6 ; turns color back to the color of the snake
	mov ax, [y_snake+bx] ; move the y value for the head of the snake to ax
	mov [y_coordinate], ax 
	mov ax, [x_snake+bx] ; move the x value for the head of the snake to ax
	mov [x_coordinate], ax 
	sub [y_coordinate], 5 ; because the snake is moving then the new head will be printed in a new place (according to the movement)
	call DrawSquare ; draws new head
	mov bx, 2
MoveAllSnakeUp: ; moves the whole array forwards (basically the values of what was the n+1 part of the snake are now in the n part of the snake)
	cmp [y_snake+bx], -1
	je FinMoveUp
	mov ax, [y_snake+bx]
	sub bx, 2
	mov [y_snake+bx], ax
	add bx, 2
	mov ax, [x_snake+bx]
	sub bx, 2
	mov [x_snake+bx], ax
	add bx, 4
	jmp MoveAllSnakeUp
FinMoveUp:
	sub bx, 2
	mov ax, [y_coordinate] 
	mov [y_snake+bx], ax ; moves new head y value to array
	mov ax, [x_coordinate]
	mov [x_snake+bx], ax ; moves new head x value to array
	jmp EndUp
AteUp:
	cmp [y_snake+bx], -1
	je FinSnakeUpAte
	add bx, 2
	jmp AteUp ; loop until you reach one spot after the snake in the array (value there is -1)
FinSnakeUpAte:
	sub bx, 2 ; returns to spot in array that represents the snake's head
	mov [eatenapple], 0 ; because we are now already changing the length of the snake then we can return the value of [eatenapple] back to 0 so that the snake will continue moving after this without growing until he eats another apple
	mov ax, [y_snake+bx] ; move the y value for the head of the snake to ax
	mov [y_coordinate], ax
	mov ax, [x_snake+bx] ; move the x value for the head of the snake to ax
	mov [x_coordinate], ax
	sub [y_coordinate], 5 ; because the snake is moving then the new head will be printed in a new place (according to the movement)
	call DrawSquare ; draws new head
	add bx, 2 ; moves to new spot in array (because snake got longer)
	mov ax, [y_coordinate] 
	mov [y_snake+bx], ax ; moves new head y value to array
	mov ax, [x_coordinate]
	mov [x_snake+bx], ax ; moves new head x value to array
	call DrawApple ; draws new apple because the last one is gone
EndUp:
	call Delay
	pop bx
	pop ax
	ret
	endp
	
proc MoveDown ; moves snake downwards
	push ax
	push bx
	mov bx, 0
	cmp [direction], 1 ; checks that snake won't do a 180 degrees turn
	jne B11
	call MoveUp
B11:
	mov [direction], 0 ; changes direction to new direction of movement
	add bx, 2
	cmp [eatenapple], 1 ; check if apple was eaten in last movement
	jne NotAteDown
	jmp AteDown
NotAteDown:
	cmp [y_snake+bx], -1
	je FinSnakeDownNotAte
	add bx, 2
	jmp NotAteDown ; loop until you reach one spot after the snake in the array (value there is -1)
FinSnakeDownNotAte:
	sub bx, 2 ; returns to spot in array that represents the snake's head
	mov [color], 0 ; changes color of square to black (color of the background)
	mov ax, [y_snake+0] ; move the y value for the tail of the snake to ax
	mov [y_coordinate], ax
	mov ax, [x_snake+0] ; move the x value for the tail of the snake to ax
	mov [x_coordinate], ax
	call DrawSquare ; draws a black square on the tail of the snake (essentially erasing the tail)
	mov [color], 6 ; turns color back to the color of the snake
	mov ax, [y_snake+bx] ; move the y value for the head of the snake to ax
	mov [y_coordinate], ax
	mov ax, [x_snake+bx] ; move the x value for the head of the snake to ax
	mov [x_coordinate], ax
	add [y_coordinate], 5 ; because the snake is moving then the new head will be printed in a new place (according to the movement)
	call DrawSquare ; draws new head
	mov bx, 2
MoveAllSnakeDown: ; moves the whole array forwards (basically the values of what was the n+1 part of the snake are now in the n part of the snake)
	cmp [y_snake+bx], -1
	je FinMoveDown
	mov ax, [y_snake+bx]
	sub bx, 2
	mov [y_snake+bx], ax
	add bx, 2
	mov ax, [x_snake+bx]
	sub bx, 2
	mov [x_snake+bx], ax
	add bx, 4
	jmp MoveAllSnakeDown
FinMoveDown:
	sub bx, 2
	mov ax, [y_coordinate] 
	mov [y_snake+bx], ax ; moves new head y value to array
	mov ax, [x_coordinate]
	mov [x_snake+bx], ax ; moves new head x value to array
	jmp EndDown
AteDown:
	cmp [y_snake+bx], -1
	je FinSnakeDownAte
	add bx, 2
	jmp AteDown ; loop until you reach one spot after the snake in the array (value there is -1)
FinSnakeDownAte:
	sub bx, 2 ; returns to spot in array that represents the snake's head
	mov [eatenapple], 0 ; because we are now already changing the length of the snake then we can return the value of [eatenapple] back to 0 so that the snake will continue moving after this without growing until he eats another apple
	mov ax, [y_snake+bx] ; move the y value for the head of the snake to ax
	mov [y_coordinate], ax 
	mov ax, [x_snake+bx] ; move the x value for the head of the snake to ax
	mov [x_coordinate], ax
	add [y_coordinate], 5 ; because the snake is moving then the new head will be printed in a new place (according to the movement)
	call DrawSquare ; draws new head
	add bx, 2 ; moves to new spot in array (because snake got longer)
	mov ax, [y_coordinate]
	mov [y_snake+bx], ax ; moves new head y value to array
	mov ax, [x_coordinate]
	mov [x_snake+bx], ax ; moves new head x value to array
	call DrawApple ; draws new apple because the last one is gone
EndDown:
	call Delay
	pop bx
	pop ax
	ret
	endp
	
proc MoveLeft ; moves snake left
	push ax
	push bx
	mov bx, 0
	cmp [direction], 2 ; checks that snake won't do a 180 degrees turn
	jne B111
	call MoveRight
B111:
	mov [direction], 3 ; changes direction to new direction of movement
	add bx, 2
	cmp [eatenapple], 1 ; check if apple was eaten in last movement
	jne NotAteLeft
	jmp AteLeft
NotAteLeft:
	cmp [y_snake+bx], -1
	je FinSnakeLeftNotAte
	add bx, 2
	jmp NotAteLeft ; loop until you reach one spot after the snake in the array (value there is -1)
FinSnakeLeftNotAte:
	sub bx, 2 ; returns to spot in array that represents the snake's head
	mov [color], 0 ; changes color of square to black (color of the background)
	mov ax, [y_snake+0] ; move the y value for the tail of the snake to ax
	mov [y_coordinate], ax
	mov ax, [x_snake+0] ; move the x value for the tail of the snake to ax
	mov [x_coordinate], ax
	call DrawSquare ; draws a black square on the tail of the snake (essentially erasing the tail)
	mov [color], 6 ; turns color back to the color of the snake
	mov ax, [y_snake+bx] ; move the y value for the head of the snake to ax
	mov [y_coordinate], ax
	mov ax, [x_snake+bx] ; move the x value for the head of the snake to ax
	mov [x_coordinate], ax
	sub [x_coordinate], 5 ; because the snake is moving then the new head will be printed in a new place (according to the movement)
	call DrawSquare ; draws new head
	mov bx, 2
MoveAllSnakeLeft: ; moves the whole array forwards (basically the values of what was the n+1 part of the snake are now in the n part of the snake)
	cmp [y_snake+bx], -1
	je FinMoveLeft
	mov ax, [y_snake+bx]
	sub bx, 2
	mov [y_snake+bx], ax
	add bx, 2
	mov ax, [x_snake+bx]
	sub bx, 2
	mov [x_snake+bx], ax
	add bx, 4
	jmp MoveAllSnakeLeft
FinMoveLeft:
	sub bx, 2
	mov ax, [y_coordinate]
	mov [y_snake+bx], ax ; moves new head y value to array
	mov ax, [x_coordinate]
	mov [x_snake+bx], ax ; moves new head x value to array
	jmp EndLeft
AteLeft:
	cmp [y_snake+bx], -1
	je FinSnakeLeftAte
	add bx, 2
	jmp AteLeft ; loop until you reach one spot after the snake in the array (value there is -1)
FinSnakeLeftAte:
	sub bx, 2 ; returns to spot in array that represents the snake's head
	mov [eatenapple], 0 ; because we are now already changing the length of the snake then we can return the value of [eatenapple] back to 0 so that the snake will continue moving after this without growing until he eats another apple
	mov ax, [y_snake+bx] ; move the y value for the head of the snake to ax
	mov [y_coordinate], ax
	mov ax, [x_snake+bx] ; move the x value for the head of the snake to ax
	mov [x_coordinate], ax
	sub [x_coordinate], 5 ; because the snake is moving then the new head will be printed in a new place (according to the movement)
	call DrawSquare ; draws new head
	add bx, 2 ; moves to new spot in array (because snake got longer)
	mov ax, [y_coordinate]
	mov [y_snake+bx], ax ; moves new head y value to array
	mov ax, [x_coordinate]
	mov [x_snake+bx], ax ; moves new head x value to array
	call DrawApple ; draws new apple because the last one is gone
EndLeft:
	call Delay
	pop bx
	pop ax
	ret
	endp
	
proc MoveRight ; moves snake right
	push ax
	push bx
	mov bx, 0
	cmp [direction], 3 ; checks that snake won't do a 180 degrees turn
	jne B1111
	call MoveLeft
B1111:
	mov [direction], 2 ; changes direction to new direction of movement
	add bx, 2
	cmp [eatenapple], 1 ; check if apple was eaten in last movement
	jne NotAteRight
	jmp AteRight
NotAteRight:
	cmp [y_snake+bx], -1
	je FinSnakeRightNotAte
	add bx, 2
	jmp NotAteRight ; loop until you reach one spot after the snake in the array (value there is -1)
FinSnakeRightNotAte:
	sub bx, 2 ; returns to spot in array that represents the snake's head
	mov [color], 0 ; changes color of square to black (color of the background)
	mov ax, [y_snake+0] ; move the y value for the tail of the snake to ax
	mov [y_coordinate], ax
	mov ax, [x_snake+0] ; move the x value for the tail of the snake to ax
	mov [x_coordinate], ax
	call DrawSquare ; draws a black square on the tail of the snake (essentially erasing the tail)
	mov [color], 6 ; turns color back to the color of the snake
	mov ax, [y_snake+bx] ; move the y value for the head of the snake to ax
	mov [y_coordinate], ax
	mov ax, [x_snake+bx] ; move the x value for the head of the snake to ax
	mov [x_coordinate], ax
	add [x_coordinate], 5 ; because the snake is moving then the new head will be printed in a new place (according to the movement)
	call DrawSquare ; draws new head
	mov bx, 2
MoveAllSnakeRight: ; moves the whole array forwards (basically the values of what was the n+1 part of the snake are now in the n part of the snake)
	cmp [y_snake+bx], -1
	je FinMoveRight
	mov ax, [y_snake+bx]
	sub bx, 2
	mov [y_snake+bx], ax
	add bx, 2
	mov ax, [x_snake+bx]
	sub bx, 2
	mov [x_snake+bx], ax
	add bx, 4
	jmp MoveAllSnakeRight
FinMoveRight:
	sub bx, 2
	mov ax, [y_coordinate]
	mov [y_snake+bx], ax ; moves new head y value to array
	mov ax, [x_coordinate]
	mov [x_snake+bx], ax ; moves new head x value to array
	jmp EndRight
AteRight:
	cmp [y_snake+bx], -1
	je FinSnakeRightAte
	add bx, 2
	jmp AteRight ; loop until you reach one spot after the snake in the array (value there is -1)
FinSnakeRightAte:
	sub bx, 2 ; returns to spot in array that represents the snake's head
	mov [eatenapple], 0 ; because we are now already changing the length of the snake then we can return the value of [eatenapple] back to 0 so that the snake will continue moving after this without growing until he eats another apple
	mov ax, [y_snake+bx] ; move the y value for the head of the snake to ax
	mov [y_coordinate], ax
	mov ax, [x_snake+bx] ; move the x value for the head of the snake to ax
	mov [x_coordinate], ax
	add [x_coordinate], 5 ; because the snake is moving then the new head will be printed in a new place (according to the movement)
	call DrawSquare ; draws new head
	add bx, 2 ; moves to new spot in array (because snake got longer)
	mov ax, [y_coordinate]
	mov [y_snake+bx], ax ; moves new head y value to array
	mov ax, [x_coordinate]
	mov [x_snake+bx], ax ; moves new head x value to array
	call DrawApple ; draws new apple because the last one is gone
EndRight:
	call Delay
	pop bx
	pop ax
	ret
	endp
	
proc DrawSnake
	push ax
	mov [color], 6 ; color of the snake
	mov [len], 5 ; each square that builds the snake is a 5 * 5 square
	mov ax, [y_snake+0]
	mov [y_coordinate], ax
	mov ax, [x_snake+0]
	mov [x_coordinate], ax
	call DrawSquare ; draws first square from the back (tail)
	mov ax, [y_snake+2]
	mov [y_coordinate], ax
	mov ax, [x_snake+2]
	mov [x_coordinate], ax
	call DrawSquare ; draws second square from the back
	mov ax, [y_snake+4]
	mov [y_coordinate], ax
	mov ax, [x_snake+4]
	mov [x_coordinate], ax
	call DrawSquare ; draws third square from the back
	mov ax, [y_snake+6]
	mov [y_coordinate], ax
	mov ax, [x_snake+6]
	mov [x_coordinate], ax
	call DrawSquare ; draws fourth square from the back
	mov ax, [y_snake+8]
	mov [y_coordinate], ax
	mov ax, [x_snake+8]
	mov [x_coordinate], ax
	call DrawSquare ; draws fifth square from the back (head)
	pop ax
	ret
	endp
	
proc Random
	push ax
	push dx
	push es
RandomY:
	xor bx, bx
	xor dx, dx
	xor ax, ax
	mov ax, 40h 
	mov es, ax
	mov ax, [es:6Ch] ; generates random number and puts it in ax
	xor dx, dx
	mov [limit], 160
	div [limit] ; divides ax by [limit] and puts the remainder in dx
	add dx, 20 ; so that the playing board will look centralised and not sticking to one side
	mov [y_applenotgrid], dx
	mov ax, [y_applenotgrid]
	xor dx, dx
	div [scale] ; divides ax by [scale] and puts the remainder in dx
	cmp dx, 0 ; if remainder is zero that means that the apple will be eaten fully and not partially 
	je OnGridY
	jmp MoveToGridY
OnGridY:
	mov ax, [y_applenotgrid]
	mov [y_applegrid], ax
	jmp RandomX
MoveToGridY:
	sub [y_applenotgrid], dx ; because dx is the amount that needs to be decreased in order for it to divide by [scale]
	mov ax, [y_applenotgrid]
	mov [y_applegrid], ax
RandomX:
	xor ah, al
	and al, ah ; random number (not using the same thing that we did for the y axis because the timer won't change and thus the number that would have been generated would have been the same number)
	mov [limit], 280
	div [limit] ; divides ax by [limit] and puts the remainder in dx
	add dx, 20 ; so that the playing board will look centralised and not sticking to one side
	mov [x_applenotgrid], dx
	mov ax, [x_applenotgrid]
	xor dx, dx
	div [scale] ; divides ax by [scale] and puts the remainder in dx
	cmp dx, 0 ; if remainder is zero that means that the apple will be eaten fully and not partially 
	je OnGridX
	jmp MoveToGridX
OnGridX:
	mov ax, [x_applenotgrid]
	mov [x_applegrid], ax
	jmp CompareRandom
MoveToGridX:
	sub [x_applenotgrid], dx ; because dx is the amount that needs to be decreased in order for it to divide by [scale]
	mov ax, [x_applenotgrid]
	mov [x_applegrid], ax
	xor bx, bx
CompareRandom: ; checks if apple coordinates were generated on the snake
	cmp [x_snake+bx], -1
	je CheckRandom
	add bx,2
	jmp CompareRandom
CheckRandom:
	sub bx, 2
	mov ax, [x_applegrid]
	mov dx, [y_applegrid]
CompareAllSnake:
	cmp bx,0
	je EndRandom
	sub bx, 2
	cmp [x_snake+bx], ax
	jne CompareAllSnake
CompareSnakeY:
	cmp [y_snake+bx], dx
	jne CompareAllSnake
DrawRandomAppleBad:
	jmp RandomY ; if the apple's coordinates landed on the snake then jump back to the beginning of randomising process
EndRandom:
	pop es
	pop dx
	pop ax
	ret
	endp
	
proc DrawApple
	push ax
	push bx
	add [eatenapples_counter], 1 ; an apple is drawn only when one was eaten (or at the start and that is why the counter starts at -1)
	mov bx, [apples_to_win]
	cmp [eatenapples_counter], bx ; checks if enough apples were eaten to win
	jne NotWonGame
	jmp Congratulations
NotWonGame:
	call Random
	mov ax, [y_applegrid]
	mov [y_coordinate], ax
	mov ax, [x_applegrid]
	mov [x_coordinate], ax
	mov [len], 5
	mov [color], 4 ; changes the color to red for drawing the apple
	call DrawSquare ; draws apple
	mov [len], 1 ; changes the size of the square to a pixel for the stem of the apple
	add [x_coordinate], 2 ; because the stem is not on the corner of the apple moves the stem to the middle of the apple (on the top)
	mov [color], 10 ; changes color to green for the stem
	call DrawSquare ; draws stem
	mov [len], 5 ; returns the length of each drawn square to 5 because snake is built of 5 * 5 squares and it moves by drawing squares
	mov [color], 6 ; returns the color of each drawn pixel to the color of the snake
	pop bx
	pop ax
	ret
	endp
	
proc CheckColor
	push ax
	push bx
	push cx
	push dx
	mov cx, [x_applegrid]
	mov dx, [y_applegrid]
	mov ah, 0dh
	int 10h ; check color of pixel
	cmp al, 6 ; if the apple's pixel is now in the snake's color that means the snake went over it (ate the apple)
	jne NotEatenApple
	mov [eatenapple], 1 ; an apple was eaten
NotEatenApple:
	pop dx
	pop cx
	pop bx
	pop ax
	ret
	endp
	
proc CheckLoc
	push ax
	push bx
	push dx
	xor bx, bx
CheckLocAll:
	cmp [x_snake+bx],-1
	je ContinueCheckLoc
	add bx,2
	jmp CheckLocAll ; loop until you reach one spot after the snake in the array (value there is -1)
ContinueCheckLoc:	
	sub bx,2 ; returns to spot in array that represents the snake's head
	mov ax, [x_snake+bx]
	mov dx,[y_snake+bx]
CheckLeftWall: ; checks if the snakes head hit the left side of the frame
	cmp ax, 5
	jne CheckRightWall
	jmp GameOver
CheckRightWall: ; checks if the snakes head hit the right side of the frame
	cmp ax, 310
	jne CheckTopWall
	jmp GameOver
CheckTopWall: ; checks if the snakes head hit the top side of the frame
	cmp dx, 5
	jne CheckBottomWall
	jmp GameOver
CheckBottomWall: ; checks if the snakes head hit the bottom side of the frame
	cmp dx, 190
	jne CompareAllX
	jmp GameOver
CompareAllX: ; checks if the head's x value is equal to any other part of the snake's x value
	cmp bx, 0 ; checked the whole array and snake did not hit itself
	je NotAteItself
	sub bx, 2
	cmp [x_snake+bx], ax
	jne CompareAllX
CompareAllY: ; if they do have the same x value then check if their y value is equal
	cmp [y_snake+bx], dx
	jne CompareAllX ; if not equal then continue check
	jmp GameOver
NotAteItself:
	pop dx
	pop bx
	pop ax
	ret
	endp
	
proc DrawFrame
	push ax
	push dx
	mov ax, [x_frame]
	mov [x_coordinate], ax ; sets it on the left side of the frame
	mov dx, [y_frame]
	mov [y_coordinate], dx ; sets it on the top side of the frame
	mov [len], 5
	mov [color], 3 ; color of the frame
	call DrawSquare
DrawTopFrame:
	add [x_coordinate], 5
	call DrawSquare
	cmp [x_coordinate], 310
	jne DrawTopFrame ; starting from the top left corner draws squares of 5 * 5 until it reaches the top right corner
DrawRightFrame:
	add [y_coordinate], 5
	call DrawSquare
	cmp [y_coordinate], 190
	jne DrawRightFrame ; starting from the top right corner draws squares of 5 * 5 until it reaches the bottom right corner
	mov ax, [x_frame] 
	mov [x_coordinate], ax ; ; sets it on the left side of the frame
	call DrawSquare
DrawBottomFrame:
	add [x_coordinate], 5
	call DrawSquare
	cmp [x_coordinate], 310
	jne DrawBottomFrame ; starting from the bottom left corner draws squares of 5 * 5 until it reaches the bottom right corner
	mov ax, [x_frame]
	mov [x_coordinate], ax ; sets it on the left side of the frame
	mov dx, [y_frame]
	mov [y_coordinate], dx ; sets it on the top side of the frame
DrawLeftFrame:
	add [y_coordinate], 5
	call DrawSquare
	cmp [y_coordinate], 190
	jne DrawLeftFrame ; starting from the top left corner draws squares of 5 * 5 until it reaches the bottom left corner
	pop dx
	pop ax
	ret
	endp
	
	
start:
	mov ax, @data
	mov ds, ax
; --------------------------
; Your code here
	mov al, 01h
	mov ah, 0
	int 10h ; enter text mode
	mov dx, offset StartScreen 
	mov ah, 9h
	int 21h ; print start screen
CheckKey:
	mov ah, 0h
	int 16h ; wait for key
	cmp al, 'p' ; check if 'p' was pressed
	jne InstructionScreenCheck
	jmp StartGame
InstructionScreenCheck:
	cmp ah, 01h ; check if escape was pressed
	jne DoesNotWantToExitNow1
	jmp exit
DoesNotWantToExitNow1:
	cmp al, 'r' ; check if 'r' was presses
	jne CheckKey
	mov dx, offset InstructionScreen
	mov ah, 9h
	int 21h ; prints instruction screen
ReadingInstructionScreen:
	cmp ah, 01h ; check if escape was pressed
	jne DoesNotWantToExitNow2
	jmp exit
DoesNotWantToExitNow2:
	mov ah, 0h
	int 16h ; wait for key
	cmp al, 'p' ; check if 'p' was pressed
	jne ReadingInstructionScreen
	jmp StartGame
RestartGame: ; restarts everything that is needed to the starting position
	mov [x_snake+0], 140
	mov [x_snake+2], 145
	mov [x_snake+4], 150
	mov [x_snake+6], 155
	mov [x_snake+8], 160	
	mov [y_snake+0], 100
	mov [y_snake+2], 100
	mov [y_snake+4], 100
	mov [y_snake+6], 100
	mov [y_snake+8], 100
	mov bx, 10
AdjustArraysToRestart:
	cmp [x_snake+bx],-1
	je ContinueAdjustToRestart
	mov [x_snake+bx],-1
	mov [y_snake+bx],-1
	add bx,2
	jmp AdjustArraysToRestart
ContinueAdjustToRestart:
	xor bx, bx
	mov [eatenapples_counter], -1
	mov [eatenapple], 0
	mov [direction], 2
StartGame:
	mov ax, 13h
	int 10h ; Enter Graphic Mode
	call DrawSnake
	call DrawFrame
	call DrawApple
	call MoveRight
GameOver:
	mov al, 01h
	mov ah, 0
	int 10h ; enter text mode
	mov dx, offset GameOverScreen
	mov ah, 9h
	int 21h ; print game over screen
	jmp ContinueGame
Congratulations:
	mov al, 01h
	mov ah, 0
	int 10h ; enter text mode
	mov dx, offset CongratulationsScreen
	mov ah, 9h
	int 21h ; print winning screen
	jmp ContinueGame
ContinueGame:
	mov ah, 0h
	int 16h ; wait for key
	cmp ah, 01h ; check if escape was pressed
	je exit 
	cmp al, 'p' ; check if 'p' was pressed
	jne ContinueGame
	jmp RestartGame ; restarts game
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
END start


