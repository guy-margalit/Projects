IDEAL
MODEL small
STACK 100h
p186
DATASEG
; --------------------------
openscreen db 10,13
db'    ___ _ __ __ _ ____   __ _  __ _ _ __ ___   ___   ',10,13
db'   / __  __/ _  |_  /  / _` |/ _` |  _ ` _ \ / _ \  ',10,13
db'   | (__| | | (_| |/ /  | (_| | (_| | | | | | |  __/ ',10,13
db'    \___|_|  \__,_/___|  \__, |\__,_|_| |_| |_|\___| ',10,13
db'                         __/ |                       ',10,13
db'                         |___/                       ',10,13
db'   THE CRAZ GAME ',10,13
db' ',10,13,'$'
level db ' ' ,10,13
db 'choose the level of the game:',10,13
db 'easy=press e',10,13
db 'medium=press m',10,13
db 'hard=press h',10,13,'$'
student db 10,13	
db'MADE BY: Raz Zantkeren',10,13 
db'press any key to start the game, i to see the instruction and if u want to leave during the game press q',10,13,'$'
road db 40 dup (205),10,13 
	 db 10,13
	 db 40 dup (205),10,13
	 db 10,13
	 db 40 dup (205),10,13
	 db 10,13
	 db 40 dup (205),10,13
	 db 10,13
	 db 40 dup (205),10,13
	 db 10,13
	 db 40 dup (205),10,13
	 db 10,13
	 db 40 dup (205),10,13
	 db 10,13
	 db 40 dup (205),10,13
	 db 10,13
	 db 40 dup (205),10,13,'$'
x_cord db 0 ; column
y_cord db 0 ; row
x_cord1 db 0 ; column
y_cord1 db 0 ; row
color dw 0Eh ; color
screenChr db 0
obstecales_x1 db 4,7,13,24,2,8,20,17,33,10,29
obstecales_x2 db 34,2,1,6,13,25,9,14,35,22,11
obstecales_x3 db 5,13,4,5,2,6,20,17,31,12,23
obstecales_x4 db 9,1,32,4,13,3,15,17,33,9,27
obstecales_x5 db 31,21,12,7,4,6,2,18,24,13,26
obstecales_x6 db 15,27,19,14,12,1,4,17,13,4,25
obstecales_x7 db 16,37,3,29,4,18,38,11,17,5,22
obstecales_x8 db 11,13,33,7,21,14,2,17,19,7,28
obstecales_x9 db 4,23,34,14,12,16,32,27,35,8,31
obstecales_x10 db 1,9,33,29,4,6,27,11,22,31,32
obstecales_x11 db 14,12,15,27,32,36,13,27,22,30,38
obstecales_x12 db 16,39,33,15,23,27,18,1,6,18,37
obstecales_x13 db 28,1,31,37,12,17,24,21,3,1,30
obstecales_x14 db 35,30,33,20,14,11,22,7,29,15,21
chr db 0
easydelay dw 9
mediumdelay dw 6
harddelay dw 2
dealyfinal dw 0
lost db 0
ranOver db 205
lose db 10,13
db '___  _____ _       _    ____ ____ _____' ,10,13 
db '\  \//  _ Y \ /\  / \  /  _ Y ___Y__ __\' ,10,13 
db ' \  /| / \| | ||  | |  | / \|    \ / \ '  ,10,13 
db ' / / | \_/| \_/|  | |_/\ \_/|___ | | | '  ,10,13
db '/_/  \____|____/  \____|____|____/ \_/ '   ,10,13
db 'if u want press r to play the game again' ,10,13,'$'	
won db 10,13,'$'
instruction db 10,13
db 'if you touch the obstecale you lose',10,13
db 'if you want go up, press the arrow up.',10,13
db 'if you go to the right, press the right arrow.',10,13
db 'if you go to the left, press the left arrow.',10,13
db 'if you want go down, press the arrow down.',10,13,'$'
endTime db 0	
ten db 10
number db 0
bx_saver dw 0
rnd db 0
secondCounter db ?
secondsSinceBeginningOfGame db 0
gameTimeup db 0
bonusX db ?
bonusY db ?
; --------------------------

; consts/קבועים
LEFT equ 75
UP equ 72
RIGHT equ 77
DOWN equ 80
WHITE_COLOR equ 0fh
BLACK_COLOR equ 0
RED_COLOR equ 12


CODESEG
;set Cursore Position for the obstacles
proc setCursorePosition1
	pusha
	mov dh, [y_cord1] ; row
	mov dl, [x_cord1] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret
endp setCursorePosition1

; al - row
; ah - col
;set Cursore Position for the obstacles
proc setCursorePosition2
	pusha
	mov dh, al ; row
	mov dl, ah ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret
endp setCursorePosition2


;print a string on the screen
proc printString
	pusha
	mov ah, 9h
	int 21h 
	popa
	ret
endp printString


; VGA color palette: https://upload.wikimedia.org/wikipedia/commons/4/49/VGA_palette.svg
proc draw_bonus
	pusha
	
	mov al, [bonusY]
	mov ah, [bonusX]
	call setCursorePosition2
	
	mov ah, 9 ; print character
	mov al, '@' ; al = character to draw
	mov bl, RED_COLOR ; text color
	mov bh, BLACK_COLOR ; background color
	mov cx, 1 ; cx = number of times to draw character
	int 10h
	popa
	ret
endp draw_bonus

proc initBonusLocation
	pusha
	mov ch, 16
	mov cl, 1
	call randomInRange
	
	mov al, [rnd]
	mov [bonusY], al
	mov [bonusX], 5
	popa
	ret
endp initBonusLocation

;this proc move obstacle
proc movObstecale 
	pusha 
	mov cx, 11 ;move the number of obstacles to cx
	
@@drawLoop:
	;go to obstacle place 
	mov al, [byte ptr bx] ;move the x_cord to al
	mov [x_cord1], al ;move al into x_cord1
	call setCursorePosition1;set Cursore Position for the obstacles
	cmp [x_cord1], 39 ;check if the obstacle rached the end
	jne @@nojump ;if he didn't arrive go to no jump 
	;delete the character
	mov [color], 0h ;black color
	mov al, 254 ;the ascii code of the obstacle
	call drawCharacter ; chracter to draw in al
	mov [byte ptr bx], 1 ;move the x_cord to the beginning for the array 
	mov [x_cord1], 1 ;move the x_cord1 to the beginning to set the cursore position
	call setCursorePosition1;set Cursore Position for the obstacles
	call readScreenChr1 ;reads the char that is on the screen
	cmp [screenChr], 12 ;check if the obstacle is on the player (player ascii = 12)
	je @@lost ;if he did go to lost
	mov [color], 0Eh ;move the color to yellow = 0Eh
	mov al, 254 ;the ascii code of the obstacle
	call drawCharacter ; chracter to draw in al
	jmp @@finish1 ;jump to finish when done
	
@@nojump:
	mov [color], 0h ;move color to black
	mov al, 254 ;the ascii code of the obstacle
	call drawCharacter; chracter to draw in al
	inc [byte ptr bx] ;move the obstacle right
	inc [x_cord1] ;mve the x_cord1 with the obstacle
	call setCursorePosition1;set Cursore Position for the obstacles
	call readScreenChr1 ;reads the char that is on the screen
	cmp [screenChr], 12 ;check if the obstacle is on the player (player ascii = 12)
	je @@lost ;if he did go to lost
	mov [color], 0Eh ;move the color to yellow = 0Eh
	mov al, 254 ;the ascii code of the obstacle
	call drawCharacter ; chracter to draw in al
	
@@finish1:
	inc bx ;move to the next obstacle
	loop @@drawLoop ;loop the draw
	jmp @@finish ;jump to finish when done
	
@@lost:
	mov [lost], 1 ;move 1 to lost to show that the player lost
	
@@finish:
	popa
	ret
endp movObstecale
proc moveAllObstecales
	pusha
	mov bx, offset obstecales_x1
	mov [y_cord1], 2
	call movObstecale ;this proc move obstacle
	
	mov bx, offset obstecales_x2
	mov [y_cord1], 3
	call movObstecale ;this proc move obstacle
	
	mov bx, offset obstecales_x3
	mov [y_cord1], 5
	call movObstecale;this proc move obstacle
	
	mov bx, offset obstecales_x4
	mov [y_cord1], 6
	call movObstecale ;this proc move obstacle
	
	mov bx, offset obstecales_x5
	mov [y_cord1], 8
	call movObstecale ;this proc move obstacle

	mov bx, offset obstecales_x6
	mov [y_cord1], 9
	call movObstecale ;this proc move obstacle
	
	mov bx, offset obstecales_x7
	mov [y_cord1], 11
	call movObstecale ;this proc move obstacle
	
	mov bx, offset obstecales_x8
	mov [y_cord1], 12
	call movObstecale ;this proc move obstacle
	
	mov bx, offset obstecales_x9
	mov [y_cord1], 14
	call movObstecale ;this proc move obstacle
	
	mov bx, offset obstecales_x10
	mov [y_cord1], 15
	call movObstecale ;this proc move obstacle
	
	mov bx, offset obstecales_x11
	mov [y_cord1], 17
	call movObstecale ;this proc move obstacle
	
	mov bx, offset obstecales_x12
	mov [y_cord1], 18
	call movObstecale ;this proc move obstacle
	
	mov bx, offset obstecales_x13
	mov [y_cord1], 20
	call movObstecale ;this proc move obstacle
	
	mov bx, offset obstecales_x14
	mov [y_cord1], 21
	call movObstecale ;this proc move obstacle
	popa
	ret
endp moveAllObstecales
;read a character
proc readChr
	pusha
	mov ah, 0h
	int 16h
	
	cmp al, 'i'
	je @@char_key_pressed
	cmp al, 'q'
	je @@char_key_pressed
	cmp al, 'r'
	je @@char_key_pressed
	cmp al, 'e'
	je @@char_key_pressed
	cmp al, 'm' 
	je @@char_key_pressed
	cmp al, 'h' 
	je @@char_key_pressed
	
	; arrow key pressed
	mov [chr], ah
	jmp @@finish
	
	@@char_key_pressed:
		mov [chr], al
	
	@@finish:
		popa
		ret
endp readChr
; if key not pressed, [chr] = 0
proc readCharIfPressed
	pusha
	mov ah, 1
	int 16h
	jz @@no_key
	
@@key_available:
	call readChr
	jmp @@finish
	
@@no_key:
	mov [chr], 0
	
@@finish:
	popa
	ret
endp readCharIfPressed

;set Cursore Position
proc setCursorePosition
	pusha
	mov dh, [y_cord] ; row
	mov dl, [x_cord] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret
endp setCursorePosition

;draw character
proc drawPlayer
	pusha
	mov al, [playerColor]
	mov [color], 0Eh
	mov al, 12
	call drawCharacter ; chracter to draw in al
	popa
	ret
endp drawPlayer

;delete the character
proc deleteCharacter
	pusha
	cmp [ranOver], 205
	je continue
	mov [color], 0h
	mov al, 12
	jmp continue1
	
continue:
	mov [color], 0Fh
	mov al, 205
	
continue1:
	call drawCharacter ; chracter to draw in al
	mov [ranOver], 12
	popa
	ret
endp deleteCharacter

;reads the char that is on the screen
proc readScreenChr 
	pusha
	mov bh, 0h ; Page=1
	mov ah, 08h ; Read character function
	int 10h ; return the character to al
	mov [ranOver], al ;move the character from al to ranOver
	popa
	ret
endp readScreenChr 
;reads the char that is on the screen
proc readScreenChr1
	pusha
	mov bh, 0h ; Page=1
	mov ah, 08h ; Read character function
	int 10h ; return the character to al
	mov [screenChr], al ;move the character from al to screenChr
	popa
	ret
endp readScreenChr1
; arguments
; chracter to draw in al
proc drawCharacter
	pusha
	mov ah, 9
	;al = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	popa
	ret
endp drawCharacter
;check to where you asked to go 
proc movecharacter 
	pusha	
	
	cmp [chr], LEFT
	je @@move_left
	cmp [chr], RIGHT
	je @@move_right
	cmp [chr], UP
	je @@move_up
	cmp [chr], DOWN
	je @@move_down
	
	jmp @@finish
	
@@move_left:
		cmp [x_cord], 0
		je @@finish
		dec [x_cord]
		jmp @@finish
		
@@move_right:
		cmp [x_cord], 39
		je @@finish
		inc [x_cord]
		jmp @@finish
		
@@move_up:
		cmp [y_cord], 0
		je @@finishWin
		dec [y_cord]
		jmp @@finish	
		
@@move_down:
		cmp [y_cord], 24
		je @@finish
		inc [y_cord]
		jmp @@finish
	
@@finishWin:
	mov [lost], 2
	
@@finish:
		popa
		ret
endp movecharacter

;doing delay
proc delay
	pusha
	mov cx, [dealyfinal] ;High Word
	mov dx, 0d40h ;Low Word
	mov al, 0
	mov ah, 86h ;Wait
	int 15h
	popa
	ret
endp delay
;move the player on the screen 
proc movePlayer
	pusha
	call setCursorePosition ;set Cursore Position
	call deleteCharacter ;delete the character
	call movecharacter ;check to where you asked to go
	call setCursorePosition ;set Cursore Position
	call readScreenChr ;reads the char that is on the screen
	cmp [ranOver], 254
	jne @@continue
	mov [lost], 1
@@continue:
	call drawPlayer ;draw character
	popa
	ret
endp movePlayer
proc resetVar
	mov [lost], 0
	mov [secondsSinceBeginningOfGame], 0
	mov [screenChr], 0
	mov [ranOver], 205 
	call initBonusLocation
	ret
endp resetVar
;print a number on the screen right corner 
proc printNumber
	pusha 
	;sets cursor on the corner
	mov dh, 23 ;row
	mov dl, 35 ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	mov al, [number]
	mov ah, 0
	div [ten]
	add ax,'00'
	mov dx, ax
	mov ah, 2h
	int 21h
	mov dl, dh
	mov ah, 2h
	int 21h
	popa
	ret
endp printNumber
;doing random
proc random
 ;generates a random number and keeps it in rnd
	pusha
	mov bx,[bx_saver]
	;put segment number in
 ;register es
	mov ax, 40h
	mov es, ax
 ;move random number to ax
	mov ax, [es:6Ch]
	xor ax, [bx]
	add [bx_saver], ax
	and al, 0Fh
	mov [rnd], al
	popa
	ret
endp random

; ch - max of range
; cl - min of range
proc randomInRange
	pusha
	
	call random
	mov al, [rnd]
	mov ah, 0
	sub ch, cl
	div ch ; remainder in ah
	
	;add ah, cl ; add minimum
	mov [rnd], ah
	popa
	ret
endp randomInRange


proc updateSecondsCounter
	pusha
	mov ah, 2ch
	int 21h ; number of seconds in dh
	cmp dh, [secondCounter]
	je @@print_number_of_second_since_beginning_of_game
	
	@@seconds_changed:
		mov [secondCounter], dh 
		inc [secondsSinceBeginningOfGame]
	
	@@print_number_of_second_since_beginning_of_game:
		mov al, [secondsSinceBeginningOfGame]
		mov [number], al
		call printNumber
		
	@@check_game_time_up:
		
		
	popa
	ret
endp updateSecondsCounter

; checks if game time is up
; returns 1 in gameTimeup if game time is up, else 0
proc checkGameTimeUp
	pusha
	cmp [secondsSinceBeginningOfGame], 60
	jne @@finish
	
	@@game_time_up:
		mov [gameTimeup], 1	
		
	@@finish:	
		popa
		ret
endp checkGameTimeUp

start:
	mov ax, @data
	mov ds, ax
; --------------------------
	mov dx, offset openscreen
	call printString ;print a string on the screen
	mov dx, offset level
	call printString ;print a string on the screen
	
	wait_for_level_selections:
		call readCharIfPressed
		call readChr
		cmp [chr],'e'
		je easylable
		cmp [chr],'m'
		je mediumlable
		cmp [chr],'h'
		je hardlable
		
		jmp wait_for_level_selections
	
easylable:
	mov ax,[easydelay]
	mov [dealyfinal],ax
	jmp countinue
mediumlable:
	mov ax,[mediumdelay]
	mov [dealyfinal],ax
	jmp countinue
hardlable:	
	mov ax,[harddelay]
	mov [dealyfinal],ax 
countinue:	
	mov dx, offset student
	call printString ;print a string on the screen
	call readChr
	cmp [chr],'i'
	jne jnelable
	mov dx, offset instruction
	call printString ;print a string on the screen
	; waits for character
	call readChr
jnelable:
	; waits for character
	call readChr
	
start1:
	call resetVar
	
	;clear screen by entering graphic mode 40*25
	mov ax, 13h
	int 10h
	
	mov dx, offset road
	call printString ;print a string on the screen
	
	; check if user asks to quit
    cmp al, 'q'
    je end_gameLost
	
	mov [x_cord], 20
	mov [y_cord], 22
	call setCursorePosition ;set Cursore Position
	call drawPlayer ;draw character
	call readChr
	
maingameloop:
	call updateSecondsCounter
	call checkGameTimeUp
	cmp [gameTimeup], 1
	je end_gameLost
	
	cont:
	;read a character
	call readCharIfPressed
	
	;check if user asks to quit
	cmp [chr], 'q'
	je end_gameLost
	
	; make move if direction key was pressed
	call movePlayer
	
	cmp [lost], 1
	je end_gameLost
	
	cmp [lost], 2
	je end_gameWon
	
	call moveAllObstecales
	call draw_bonus
	
; left key was pressed
main_game_loop_iteration_end:
	call delay ;doing delay
	jmp maingameloop

end_gameLost:
	;text  mode
	mov ax, 2h
	int 10h
	
	mov dx, offset lose
	
	call printString ;print a string on the screen
	
	call readChr
	
	cmp [chr], 'r'
	jne exit
	
	; equal to 'r'
	jmp start1
	
end_gameWon:
	;text  mode
	mov ax, 2h
	int 10h
	
	mov dx, offset won
	
	call printString ;print a string on the screen
	
	call readChr
	
	cmp [chr], 'r'
	jne exit
	
	; equal to 'r'
	jmp start1
	
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
END start


