;my main file with the game
;the main game starts with the choose mode screen
;after the user chooses a mode, I print the instructions
;after the instructions I print the openning string
;I print all the food and portal (if needed) and then I start the main game loop
;in the main game loop I get an arrow with a direction and move the snake or I just move the snake
;I also move the boss if needed 
;if the player wins or loses I print a picture according to it
IDEAL
MODEL small
STACK 100h
p186
jumps
DATASEG
	
;import all the variables
INCLUDE 'vars.asm'

CODESEG

;import all the macros
INCLUDE 'macros.asm'

;import all the procs
INCLUDE 'procs.asm'

start:
	mov ax, @data
	mov ds, ax
	
	;enter graphic mode
	mov ax, 13h     
	int 10h      
	
	call printFrame
	
	call chooseMode
	
	cmp [quit], 1
	je exit
	
	;enter graphic mode
	mov ax, 13h     
	int 10h      
	
	;print instructions according the mode
	cmp [mode], 'e'
	je easyInstPrint
	cmp [mode], 'm'
	je medInstPrint
	cmp [mode], 'h'
	je hardInstPrint
	
easyInstPrint:
	print easyInst
	jmp continue1
	
medInstPrint:
	print medInst
	jmp continue1

hardInstPrint:
	print hardInst
	jmp continue1
	
continue1:
	call printPicture
	
	; check if there is a character to read
	mov [chr], 0 
	mov ah, 1h
	int 16h
	
	jz noKey1
	
	;read a char
	call readChr
	
	cmp [chr], 'q'
	je exit
	
	jmp continue12
	
noKey1:
	;wait and delete the picture
	call delayString
	call delayString
	call deletePicture
	jmp continue1

	
continue12:
	; text mode 80 * 25
	mov ax, 10h
	int 10h
	
	;print the openning screen
	call printOpenningScreen
	
	call readChr
	
	cmp [chr], 'q'
	je exit
	
doOver:
	;enter graphic mode
	mov ax, 13h
	int 10h
	
	;reset all the variables in case of a replay
	call resetVariables
	
	;print the frame of the game
	print frame
	
	;put si and bx on the cords arrays and the length in cx (the loop length)
	lea si, [parts_y]
	lea bx, [parts_x]
	mov cx, [snakeLen]
	
	;begin with increasing si and bx to skip the future location
@@printer:
	inc si
	inc bx
	setCords bx, si
	mov [color], GREEN	
	call drawCharacter
	loop @@printer
	
	;print the apple
printFood1:
	drawObject x_temp, y_temp, LIGHT_RED, 162
	
	cmp [mode], 'e'
	jne looper
	
	call readChr
	jmp gameLoop
	
	;print 2 increase speed food
looper:
	mov cx, 2
	
powerups1:
	drawObject x_temp, y_temp, 09h, 42
	loop powerups1
	
	;print 2 decrease speed food
	mov cx, 2
	
powerups2:
	drawObject x_temp, y_temp, 0Dh, 15
	loop powerups2
	
	;print 2 decrease length food
	mov cx, 2
	
powerups:
	drawObject x_temp, y_temp, YELLOW, 232
	loop powerups
	
	;skip creating the portals if the mode isn't medium (if it's easy it wouldn't get here)
	
	cmp [mode], 'm'
	je continue2

	call createPortals
	
continue2:
	call readChr
	
gameLoop:
	;play a note and move to the next one
	call playSound
	cmp [currentNote], 21
	je restart
	inc [currentNote]
	jmp cont3
	
restart:
	mov [currentNote], 0
	
cont3:
	;check if the player won
	cmp [snakeLen], 27
	je won
	
	;check if the player lost
	cmp [lost], 1
	je end_game
	
	;skip drawing the boss and portals if the mode isn't hard
	cmp [mode], 'h'
	jne next1
	
	call drawBossAndPorals
	jmp next1
	
next1:
	;print the score
	call print_score
	
	; check if there is a character to read
	mov [chr], 0 
	mov ah, 1h
	int 16h
	
	jz noKey

	call readChr
	
	;compare the char the was read to the arrows
	cmp [chr], RIGHT
	je turnRight
	
	cmp [chr], LEFT
	je turnLeft
	
	cmp [chr], UP
	je turnUp
	
	cmp [chr], DOWN
	je turnDown
	
	;check if the user wants to quit
	cmp [chr], 'q'
	je end_game
	
	jmp noKey

;change the direction of the snake:
;dont change if doing a 180 degree turn direction
turnRight:
	cmp [dir], 'l'
	je noKey
	mov [dir], 'r'
	jmp noKey
	
turnLeft:
	cmp [dir], 'r'
	je noKey
	mov [dir], 'l'
	jmp noKey
	
turnUp:
	cmp [dir], 'd'
	je noKey
	mov [dir], 'u'
	jmp noKey

turnDown:
	cmp [dir], 'u'
	je noKey
	mov [dir], 'd'
	jmp noKey
	
noKey:
	cmp [mode], 'h'
	jne continue7
	cmp [canKillBoss], 1
	jne continue11
	call checkEndTime

continue11:
	;skip moving the boss if the user hasn't reached 10 points
	cmp [snakeLen], 12
	jl continue7
	call moveTheBoss
	cmp [lost], 1
	je end_game
	
continue7:
	;calculate the snake's cords and move the snake and go to next turn
	call calcCords
	call moveTheSnake
	call delay
	jmp gameLoop

end_game:
	;in case the user asked to quit
	mov [lost], 1
	
	;set the cords and print the lost string
	mov [x_cord], 14
	mov [y_cord], 10
	setCords x_cord, y_cord
	
	print lostStr
	
	call readChr
	
	;enter graphic mode
	mov ax, 13h
	int 10h
	
	;print the end picture and the score
	call printEnd
	call print_score
	
	;in case if the user wants to retry
	call chooseMode
	cmp [quit], 1
	je exit
	jmp doOver

won:
	;set the cords and print the won string
	mov [x_cord], 8
	mov [y_cord], 10
	setCords x_cord, y_cord
	
	print wonStr
	
	call readChr
	
	;enter graphic mode
	mov ax, 13h
	int 10h
	
	;print the end picture and the score
	call printEnd
	
	;in case if the user wants to retry
	call chooseMode
	cmp [quit], 1
	je exit
	jmp doOver
	
exit:
	; text mode 80 * 25
	mov ax, 2h
	int 10h
	mov ax, 4c00h
	int 21h
END start

