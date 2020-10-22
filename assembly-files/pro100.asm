IDEAL
MODEL small
STACK 100h
p186
DATASEG
; --------------------------
;the game is calld PACMAN. the goal of the game is to get 99 score.To get 99 score you need to eat the white dots but,you need to be careful from the ghosts
;if you hit them you will lose.when you lose you can start over or if you win you can start again.
;the main lope is 'print' it call the main screen and to the players(pacman and ghosts) than it jumps to the lope that
; moves the pacman check what was pressed and then to the lope that moves the ghosts by random number.  
;opening screen 
msg	db  ' ',' ',' ',' ',' ',' ',' ',201,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,187 , 10, 13
	db ' ',' ',' ',' ',' ',' ',' ',186, ' ____   ____    __     ' ,186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '|    \ /    |  /  ]    ' ,186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '|  o  )  o  | /  /     ',186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '|   _/|     |/  /      ' ,186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '|  |  |  _  /   \_     ' ,186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '|  |  |  |  \     |    ' ,186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '|__|  |__|__|\____|    ' ,186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, ' ___ ___   ____  ____  ' ,186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '|   |   | /    ||    \ ',186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '| _   _ ||  o  ||  _  |',186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '|  \_/  ||     ||  |  |',186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '|   |   ||  _  ||  |  |' ,186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '|   |   ||  |  ||  |  |',186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '|___|___||__|__||__|__|' ,186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, ' .-.   .-.    .--.     ',186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '| OO| | OO|  / _.-` .-.' ,186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, '|   | |   |  \  `-. `-`' ,186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',186, ' ^^^   ^^^     ---     ' ,186,10,13
	db ' ',' ',' ',' ',' ',' ',' ',200,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,188 , 10, 13
	db ' ',' ',' ',' ',' ',' ',' ',' to start the game press S ',10,13
	db ' ',' ',' ',' ',' ',' ',' ',' to exit the game press E',10,13
	db ' ',' ',' ',' ',' ',' ',' ',' to see the instruction press I',10,13,'$'


;instruction how to play
my  db ' ',10,13
	db ' ',10,13
	db ' to move the pacman use the letters:',10,13
	db ' S-down ',10,13
	db ' A-left <',10,13
	db ' D-right>',10,13
	db ' W-up^',10,13
	db ' ',10,13
	db ' to win you need 99 score food',10,13
	db ' you can not touch the ghost if you tuch it you die',10,13
	db ' if you want to exit you need to press E',10,13,'$'
;lose screen 
lose 	db '       _________    _____   ____    ',10,13
		db '      / ___\__  \  /     \_/ __ \   ',10,13
		db '     / /_/  > __ \|  Y Y  \  ___/   ',10,13
		db '     \___  (____  /__|_|  /\___  >  ',10,13
		db '     /_____/     \/      \/     \/ ',10,13
		db '      _______  __ ___________  ',10,13
		db '      /  _ \  \/ // __ \_  __ \ ',10,13
		db '     (  <_> )   /\  ___/|  | \/ ',10,13
		db '      \____/ \_/  \___  >__|    ',10,13
		db '                      \/        ',10,13
		db '       to start again press s',10,13
		db '       to exit the game press e',10,13,'$'
		;wining screen
win		db ' ',' ',' ', ' ',' ', ' ','     _   _  ___  _   _ ',10,13
		db ' ',' ',' ', ' ',' ', ' ','    | | | |/ _ \| | | |',10,13
		db ' ',' ',' ', ' ',' ', ' ','    | |_| | (_) | |_| |',10,13
		db ' ',' ',' ', ' ',' ', ' ','     \__, |\___/ \__,_|',10,13
		db ' ',' ',' ', ' ',' ', ' ','      __/ | ',10,13
		db ' ',' ',' ', ' ',' ', ' ','     |___/ ',10,13
		db ' ',' ',' ', ' ',' ', ' ',' ',' ',' ', ' ',' ', ' ',' ',' ',' ', ' ',' ', ' ',' ', ' ',' ',' ',' ', ' ',' ', ' ',' ',' ', ' ',' _ _ _ ',10,13
		db ' ',' ',' ', ' ',' ', ' ',' ',' ',' ', ' ',' ', ' ',' ',' ',' ', ' ',' ', ' ',' ', ' ',' ',' ',' ', ' ',' ', ' ',' ',' ', ' ','| | | |',10,13
		db ' ',' ',' ', ' ',' ', ' ',' __      _____  _ __   | | | |',10,13
		db ' ',' ',' ', ' ',' ', ' ',' \ \ /\ / / _ \| ,_ \  | | | |',10,13
		db ' ',' ',' ', ' ',' ', ' ','  \ V  V / (_) | | | | |_|_|_|',10,13
		db '  ',' ',' ', ' ',' ', ' ','  \_/\_/ \___/|_| |_| (_|_|_)',10,13
		db ' ',' ',' ',10,13
		db ' ',' ',' ',10,13
		db ' ',' ',' ', ' ',' ', ' ','       to start again press s',10,13
		db ' ',' ',' ', ' ',' ','       to exit the game press e',10,13,'$'
;game screen
maze db ' ',10,13
	 db  ' ',' ',201,205,203,205,205,205,205,203,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,187,10,13
     db  ' ',' ',186,4,200,205,205,205,205,188,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,186,10,13
	 db  ' ',' ',186,4,4,4,4,4,4,4,4,201,205,4,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,4,4,201,205,205,185,10,13
	 db  ' ',' ',204,205,205,205,187,4,205,205,205,188,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,186,10,13
	 db  ' ',' ',204,205,205,205,188,4,4,4,4,4,4,201,205,205,187,4,201,205,187,4,201,205,205,205,187,4,201,187,4,4,4,201,187,4,186,10,13
	 db  ' ',' ',186,4,4,4,4,4,201,205,205,187,4,186,' ',' ',186,4,186,' ',186,4,186,' ',' ',' ',186,4,186,186,4,4,4,186,186,4,186,10,13
	 db  ' ',' ',186,4,4,205,205,205,202,205,205,188,4,200,205,205,188,4,200,205,188,4,200,205,205,205,188,4,200,188,4,4,4,200,188,4,186,10,13
	 db  ' ',' ',186,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,186,10,13
	 db  ' ',' ',186,4,201,205,205,205,187,4,201,205,205,205,205,205,205,187,4,201,205,205,205,187,4,205,205,205,4,4,201,205,205,205,187,4,186,10,13
	 db  ' ',' ',186,4,186,' ',' ',' ',186,4,186,' ',' ',' ',' ',' ',' ',186,4,186,' ',' ',' ',186,4,4,4,4,4,4,186,' ',' ',' ',186,4,186,10,13
	 db  ' ',' ',186,4,200,205,205,205,188,4,200,205,205,205,205,205,205,188,4,200,205,205,205,188,4,201,205,205,187,4,200,205,205,205,188,4,186,10,13
	 db  ' ',' ',186,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,186,' ',' ',186,4,4,4,4,4,4,4,186,10,13
	 db  ' ',' ',186,4,4,201,205,205,187,4,4,4,201,205,205,187,4,4,4,201,205,205,205,187,4,200,205,205,188,4,4,4,4,4,4,4,186,10,13
	 db  ' ',' ',186,4,4,186,' ',' ',186,4,4,4,200,205,205,188,4,4,4,186,' ',' ',' ',186,4,4,4,4,4,201,205,205,205,205,187,4,186,10,13
	 db  ' ',' ',186,4,4,200,205,205,188,4,4,4,4,4,4,4,4,4,4,200,205,205,205,188,4,201,205,187,4,200,205,205,205,205,188,4,186,10,13
	 db  ' ',' ',186,4,201,187,4,4,4,4,201,205,205,205,187,4,201,187,4,201,187,4,4,4,4,186,' ',186,4,4,4,4,4,4,4,4,186,10,13
	 db  ' ',' ',186,4,200,188,4,201,187,4,186,' ',' ',' ',186,4,186,186,4,200,188,4,4,4,4,200,205,188,4,205,205,205,205,' ',' ',' ',186,10,13
	 db  ' ',' ',186,4,4,4,4,200,188,4,200,205,205,205,188,4,200,188,4,4,4,4,201,205,205,187,4,4,4,4,4,4,4,4,4,4,186,10,13
	 db  ' ',' ',186,4,205,205,4,4,4,4,4,4,4,4,4,4,4,4,4,201,187,4,200,205,205,188,4,4,201,205,205,187,4,4,4,4,186,10,13
	 db  ' ',' ',186,4,4,4,4,4,4,201,205,205,205,205,187,4,4,4,4,186,186,4,4,4,4,4,4,4,204,205,205,185,4,201,187,4,186,10,13
	 db  ' ',' ',200,205,205,205,205,205,205,202,205,205,205,205,202,205,205,205,205,202,202,205,205,205,205,205,205,205,202,205,205,202,205,202,202,205,188,10,13,'$'
	 
	 ;pacman
	y_coordinate db 2; Row number pacman
	x_coordinate db 3; Column number pacman
	x_temp db 0 ;temprary vaiable keeping x coordinate
	y_temp db 0;temprary vaiable keeping y coordinate
	color db 14;color pacman
	canMove db 1;get the color of the pacman
	boozzz db 0;count the food that pacman eat
	direction db ?;chack the direction of the pacman
	
;ghost1 color pink
	y_coor db 18; Row number
	x_coor db 35;Column number
	xtemp db 0;temprary vaiable keeping x coor
	ytemp db 0;temprary vaiable keeping y coor
	color1 db 5;the ghost 1 color
	can_Move db 1;get the color of the ghost 1
	randomnum dw ?;Receives a random number
	savebx dw 5;save bx to get the random number
;ghost 2 color blue
	y_coor2 db 10; Row number
	x_coor2 db 9;Column number
	color2 db 9;the ghost 2 color
	xtemp2 db 0;temprary vaiable keeping x coor2
	ytemp2 db 0;temprary vaiable keeping y coor2
    can_Move2 db 1;get the color of the ghost 2
	randomnum2 dw ?;Receives a random number
	savebx2 dw 9;save bx to get the random number
;ghost 3 color gray
	y_coor3 db 5; Row number
	x_coor3 db 21;Column number
	color3 db 7;the ghost 3 color
	xtemp3 db 0;temprary vaiable keeping x coor3
	ytemp3 db 0;temprary vaiable keeping y coor3
	can_Move3 db 1;get the color of the ghost 3
	randomnum3 dw ?;Receives a random number
	savebx3 dw 7;save bx to get the random number
;ghost 4 color green
	y_coor4 db 20; Row number
	x_coor4 db 3;Column number
	color4 db 10;the ghost 4 color
	xtemp4 db 0;temprary vaiable keeping x coor4
	ytemp4 db 0;temprary vaiable keeping y coor4
	can_Move4 db 1;get the color of the ghost 4
	randomnum4 dw ?;Receives a random number
	savebx4 dw 10;save bx to get the random number
	
	boozzz1 db 0
	score db ?;get the score of the player
	ten db 10;variable with ten
	gofood1 db ?;if the ghost was on the food so he can move
	gofood2 db ?;if the ghost was on the food so he can move
	gofood3 db ?;if the ghost was on the food so he can move
	gofood4 db ?;if the ghost was on the food so he can move
; --------------------------
CODESEG
; This procedure place the character pacman in the starting spot
proc lev
	mov bh, 0
	mov dh, [y_coordinate] ; Row number
	mov dl, [x_coordinate] ; Column number
	mov ah, 2h		; change to text mode
	int 10h
	mov ah, 9  ;interrupt code for print a character with color
	mov al, 2	;character to display - asci code
	mov bh,0h ;Page - always 0
	mov bl, [color] ;BL = Foreground
	mov cx, 1 ;number of times to write character
	int 10h
	ret;finish the procedure
endp lev
; This procedure place the character Ghost 1 in the starting spot
proc go
	mov bh, 0
	mov dh, [y_coor] ; Row number
	mov dl, [x_coor] ; Column number
	mov ah, 2h   ; change to text mode
	int 10h
	mov ah, 9  ;interrupt code for print a character with color
	mov al, 1	;character to display - asci code
	mov bh,0h ;Page - always 0
	mov bl, [color1] ;BL = Foreground
	mov cx, 1 ;number of times to write character
	int 10h
	ret;finish the procedure
endp go

; This procedure place the character Ghost 2 in the starting spot
proc go2
	mov bh, 0
	mov dh, [y_coor2] ; Row number
	mov dl, [x_coor2] ; Column number
	mov ah, 2h   ; change to text mode
	int 10h
	mov ah, 9  ;interrupt code for print a character with color
	mov al, 1	;character to display - asci code
	mov bh,0 ;Page - always 0
	mov bl, [color2] ;BL = Foreground
	mov cx, 1 ;number of times to write character
	int 10h
	ret;finish the procedure
endp go2

;This procedure place the character Ghost 3 in the starting spot
proc go3
	mov bh, 0
	mov dh, [y_coor3] ; Row number
	mov dl, [x_coor3] ; Column number
	mov ah, 2h   ; change to text mode
	int 10h
	mov ah, 9  ;interrupt code for print a character with color
	mov al, 1	;character to display - asci code
	mov bh,0h ;Page - always 0
	mov bl, [color3] ;BL = Foreground
	mov cx, 1 ;number of times to write character
	int 10h
	ret;finish the procedure
endp go3

;This procedure place the character Ghost 4 in the starting spo
proc go4
	mov bh, 0
	mov dh, [y_coor4] ; Row number
	mov dl, [x_coor4] ; Column number
	mov ah, 2h  ; change to text mode
	int 10h
	mov ah, 9  ;interrupt code for print a character with color
	mov al, 1	;character to display - asci code
	mov bh,0h ;Page - always 0
	mov bl, [color4] ;BL = Foreground
	mov cx, 1 ;number of times to write character
	int 10h
	ret;finish the procedure
endp go4
;The procedure uses the int 10 to place the pacman by the coordinates.  
proc place
	mov bh, 0
	mov dh, [y_coordinate]
	mov dl, [x_coordinate]
	mov ah, 2h   ; change to text mode
	int 10h
	ret;finish the procedure
endp place
;The procedure uses the int 10 to chack the place ghost 1 by the coordinates.  
proc place1
	mov bh, 0
	mov dh, [y_coor]
	mov dl, [x_coor]
	mov ah, 2h   ; change to text mode
	int 10h
	ret;finish the procedure
endp place1
;The procedure uses the int 10 to chack the place ghost 2 by the coordinates.  
proc place2
	mov bh, 0
	mov dh, [y_coor2]
	mov dl, [x_coor2]
	mov ah, 2h   ; change to text mode
	int 10h
	ret;finish the procedure
endp place2
;The procedure uses the int 10 to chack the place ghost 3 by the coordinates.  
proc place3
	mov bh, 0
	mov dh, [y_coor3]
	mov dl, [x_coor3]
	mov ah, 2h   ; change to text mode
	int 10h
	ret;finish the procedure
endp place3
;The procedure uses the int 10 to chack the place ghost 4 by the coordinates.  
proc place4
	mov bh, 0
	mov dh, [y_coor4]
	mov dl, [x_coor4]
	mov ah, 2h   ; change to text mode
	int 10h
	ret;finish the procedure
endp place4

;pacman
proc right ;if the player chose right the pacman will move right
	inc [x_coordinate];add one to x coordinate to move the pacman right
	ret;finish the procedure
endp right
proc left;if the player chose left the pacman will move left
	sub [x_coordinate],1;subtract one to x coordinate to move the pacman left
	ret;finish the procedure
endp left
proc up;if the player chose up the pacman will move up
	sub [y_coordinate],1;subtract one to y coordinate to move the pacman up
	ret;finish the procedure
endp up
proc down;if the player chose down the pacman will move down
	inc [y_coordinate];add one to y coordinate to move the pacman down
	ret;finish the procedure
endp down

;ghost 1
proc right3;check the random num if it is 1 so ghost 1 will go right 
	inc [x_coor];add one to x coordinate to move ghost 1 right
	ret;finish the procedure
endp right3
proc left3;check the random num if it is 2 so ghost 1 will go left
	sub [x_coor],1;subtract one to x coordinate to move  ghost 1 left
	ret;finish the procedure
endp left3
proc up3;check the random num if it is 0 so ghost 1 will go up 
	sub [y_coor],1;subtract one to y coordinate to move  ghost 1 up
	ret;finish the procedure
endp up3
proc down3;check the random num if it is 3 so ghost 1 will go down
	inc [y_coor];add one to y coordinate to move  ghost 1 down
	ret;finish the procedure
endp down3

;ghost 2
proc rightgo2;check the random num if it is 1 so ghost 2 will go right 
	inc [x_coor2];add one to x coordinate to move ghost 2 right
	ret;finish the procedure
endp rightgo2
proc leftgo2;check the random num if it is 2 so ghost 2 will go left
	sub [x_coor2],1;subtract one to x coordinate to move  ghost 2 left
	ret;finish the procedure
endp leftgo2
proc upgo2;check the random num if it is 0 so ghost 2 will go up 
	sub [y_coor2],1;subtract one to y coordinate to move  ghost 2 up
	ret;finish the procedure
endp upgo2
proc downgo2;check the random num if it is 3 so ghost 2 will go down
	inc [y_coor2];add one to y coordinate to move  ghost 2 down
	ret;finish the procedure
endp downgo2


;ghost 3
proc rightgo3;check the random num if it is 1 so ghost 3 will go right 
	inc [x_coor3];add one to x coordinate to move ghost 3 right
	ret
endp rightgo3;finish the procedure
proc leftgo3;check the random num if it is 2 so ghost 3 will go left
	sub [x_coor3],1;subtract one to x coordinate to move  ghost 3 left
	ret
endp leftgo3;finish the procedure
proc upgo3;check the random num if it is 0 so ghost 3 will go up 
	sub [y_coor3],1;subtract one to y coordinate to move  ghost 3 up
	ret
endp upgo3;finish the procedure
proc downgo3;check the random num if it is 3 so ghost 3 will go down
	inc [y_coor3];add one to y coordinate to move  ghost 3 down
	ret
endp downgo3;finish the procedure

;ghost 4
proc rightgo4;check the random num if it is 1 so ghost 4 will go right
	inc [x_coor4];add one to x coordinate to move ghost 4 right
	ret
endp rightgo4;finish the procedure
proc leftgo4;check the random num if it is 2 so ghost 4 will go left
	sub [x_coor4],1;subtract one to x coordinate to move  ghost 4 left
	ret
endp leftgo4;finish the procedure
proc upgo4;check the random num if it is 0 so ghost 4 will go up 
	sub [y_coor4],1;subtract one to y coordinate to move  ghost 4 up
	ret
endp upgo4;finish the procedure
proc downgo4;check the random num if it is 3 so ghost 4 will go down
	inc [y_coor4];add one to y coordinate to move  ghost 4 down
	ret
endp downgo4;finish the procedure

proc checkMove
	real:
	pusha          ;Push of all Registers
	mov al, [x_coordinate]         ;check the next step of the pacman and puts the y and the x coordinatein y and x temp and then in al
	mov [x_temp], al 
	mov al, [y_coordinate]
	mov [y_temp], al
	call place ;call the procedure that check the place of the pacman
	xor bx, bx 
	xor dx, dx 
	xor ax, ax 
	mov bh, 0h 
	mov ah, 08h		; read the character in the cursor position to al
	int 10h 
	cmp al,1 ;check if the next step is 1 the asci code of the ghost if it is so continue to endgame
	jne check;if it isnt 1 so jmp to check
	cmp al, 'q'
	je exittttt
endgame:
	mov [boozzz], 1;put in boozzz the asci code of the ghost
	jmp roni
exittttt:
	jmp exit
	roni:
	popa ;pull all Registers
	ret
check:
	cmp al,4;check if the next step is 4 the asci code of the food if it isnt 4 so continue
	je eatfood ; if it is so jmp to eatfood
	cmp al, 0;check if the next step is 0 the asci code of the color black if it is so jmp to movepac
	jne not_move;if it isnt 0 so jmp to not_move
	jmp movepac
eatfood:
	add [score],1;if the asci code is one so the score will grow with 1 point
	call foodscore ;call the procedure that print the score and continue to movepac
		
movepac:;procedure that move the pac if it isnt 1,0 and move him one step
	mov [canMove], 1
	mov al, [x_temp]
	mov [x_coordinate], al 
	mov al, [y_temp]
	mov [y_coordinate], al
	call place;call the procedure that check the place of the pacman
soff:
	popa;pull all Registers
	ret
not_move: ;if the code asci is not 0,4,1 so the pacman will stop and wait for character
	mov [canMove], 0
	mov al, [x_temp]
	mov [x_coordinate], al 
	mov al, [y_temp]
	mov [y_coordinate], al
	call place;call the procedure that check the place of the pacman
	popa;pull all Registers
	ret
endp checkMove;finish the procedure

;ghost1
proc check_Move
	pusha;Push of all Registers
	mov al, [x_coor]               ;check the next step of ghost1 and puts the y and the x coordinatein y and x temp and then in al
	mov [xtemp], al 
	mov al, [y_coor]
	mov [ytemp], al
	call place1;call the procedure that check the place of the ghost
	xor bx, bx 
	xor dx, dx 
	xor ax, ax 
	mov bh, 0h 
	mov ah, 08h 		; read the character in the cursor position to al
	int 10h
	cmp al,2;check if the next step is 2 the asci code of the pacman if it is so continue to endgame1
	jne check1;if it isnt 2 so jmp to check1
endgame1:
	mov [boozzz1], 2;put in boozzz1 the asci code of the pacman
	popa
	ret;finish the procedure
check1:
	cmp al,4;check if the next step is 4 the asci code of the food if it isnt so continue
	je go1move;if it is 4 so jmp to go1move
	cmp al, 0;check if the next step is 0 the asci code of the color black if it is so jmp to go1move
	jne notmove;if it isnt 0 so jmp to notmove
	jmp go1move
go1move:;operation that move the ghost if it isnt 2,0 and move him one step
	mov [gofood1],al
	mov [can_Move], 1
	mov al, [xtemp]
	mov [x_coor], al 
	mov al,[ytemp]
	mov [y_coor], al
	call place1;call the procedure that check the place of the ghost
soff1:
	popa;pull all Registers
	ret
notmove:  ;if the code asci is not 0,4,2 so the ghost will stop and change her direction
	mov [can_Move], 0
	mov al, [xtemp]
	mov [x_coor], al 
	mov al, [ytemp]
	mov [y_coor], al
	call place1;call the procedure that check the place of the ghost
	popa;pull all Registers
	ret
endp check_Move;finish the procedure
;ghost2
proc check_Movego2
	pusha;Push of all Registers
	mov al, [x_coor2]               ;check the next step of ghost1 and puts the y and the x coordinatein y and x temp and then in al
	mov [xtemp2], al 
	mov al, [y_coor2]
	mov [ytemp2], al
	call place2;call the procedure that check the place of the ghost
	xor bx, bx 
	xor dx, dx 
	xor ax, ax 
	mov bh, 0h 
	mov ah, 08h 		; read the character in the cursor position to al
	int 10h
	cmp al,2;check if the next step is 2 the asci code of the pacman if it is so continue to endgame2
	jne check2;if it isnt 2 so jmp to check2
endgame2:
	mov [boozzz1], 2;put in boozzz1 the asci code of the pacman
	popa;pull all Registers
	ret
check2:
	cmp al,4;check if the next step is 4 the asci code of the food if it isnt so continue
	je go2move;if it is 4 so jmp to go2move
	cmp al, 0;check if the next step is 0 the asci code of the color black if it is so jmp to go2move
	jne notmove2;if it isnt 0 so jmp to notmove2
	jmp go2move
go2move:;operation that move the ghost if it isnt 2,0 and move him one step
	mov [gofood2],al
	mov [can_Move2], 1
	mov al, [xtemp2]
	mov [x_coor2], al 
	mov al, [ytemp2]
	mov [y_coor2], al
	call place2;call the procedure that check the place of the ghost
	popa;pull all Registers
	ret
notmove2: ;if the code asci is not 0,4,2 so the ghost will stop and change her direction
	mov [can_Move2], 0
	mov al, [xtemp2]
	mov [x_coor2], al 
	mov al, [ytemp2]
	mov [y_coor2], al
	call place2;call the procedure that check the place of the ghost
	popa;pull all Registers
	ret
endp check_Movego2;finish the procedure
;ghost3
proc check_Movego3
	pusha;Push of all Registers
	mov al, [x_coor3]               ;check the next step of ghost1 and puts the y and the x coordinatein y and x temp and then in al
	mov [xtemp3], al 
	mov al, [y_coor3]
	mov [ytemp3], al
	call place3;call the procedure that check the place of the ghost
	xor bx, bx 
	xor dx, dx 
	xor ax, ax 
	mov bh, 0h 
	mov ah, 08h 		; read the character in the cursor position to al
	int 10h
	cmp al,2;check if the next step is 2 the asci code of the pacman if it is so continue to endgame3
	jne check3;if it isnt 2 so jmp to check3
endgame3:
	mov [boozzz1], 2;put in boozzz1 the asci code of the pacman
	popa;pull all Registers
	ret
check3:
	cmp al,4;check if the next step is 4 the asci code of the food if it isnt so continue
	je go3move;if it is 4 so jmp to go3move
	cmp al, 0;check if the next step is 0 the asci code of the color black if it is so jmp to go3move
	jne notmove3;if it isnt 0 so jmp to notmove3
	jmp go3move
go3move:;operation that move the ghost if it isnt 2,0 and move him one step
	mov [gofood3],al
	mov [can_Move3], 1
	mov al, [xtemp3]
	mov [x_coor3], al 
	mov al, [ytemp3]
	mov [y_coor3], al
	call place3;call the procedure that check the place of the ghost
soff3:
	popa;pull all Registers
	ret
notmove3:;if the code asci is not 0,4,2 so the ghost will stop and change her direction 
	mov [can_Move3], 0
	mov al, [xtemp3]
	mov [x_coor3], al 
	mov al, [ytemp3]
	mov [y_coor3], al
	call place3;call the procedure that check the place of the ghost
	popa;pull all Registers
	ret
endp check_Movego3;finish the procedure
;ghost4
proc check_Movego4
	pusha;Push of all Registers
	mov al, [x_coor4]               ;check the next step of ghost1 and puts the y and the x coordinatein y and x temp and then in al
	mov [xtemp4], al 
	mov al, [y_coor4]
	mov [ytemp4], al
	call place4;call the procedure that check the place of the ghost
	xor bx, bx 
	xor dx, dx 
	xor ax, ax 
	mov bh, 0h 
	mov ah, 08h 		; read the character in the cursor position to al
	int 10h
	cmp al,2 ;check if the next step is 2 the asci code of the pacman if it is so continue to endgame4
	jne check4;if it isnt 2 so jmp to check4
endgame4:
	mov [boozzz1], 2;put in boozzz1 the asci code of the pacman
	popa;pull all Registers
	ret
check4:
	cmp al,4;check if the next step is 4 the asci code of the food if it isnt so continue
	je go4move;if it is 4 so jmp to go4move
	cmp al, 0;check if the next step is 0 the asci code of the color black if it is so jmp to go4move
	jne notmove4;if it isnt 0 so jmp to notmove4
	jmp go4move
go4move:;operation that move the ghost if it isnt 2,0 and move him one step
	mov [gofood4],al
	mov [can_Move4], 1
	mov al, [xtemp4]
	mov [x_coor4], al 
	mov al, [ytemp4]
	mov [y_coor4], al
	call place4;call the procedure that check the place of the ghost
soff4:
	popa;pull all Registers
	ret
notmove4:;if the code asci is not 0,4,2 so the ghost will stop and change her direction 
	mov [can_Move4], 0
	mov al, [xtemp4]
	mov [x_coor4], al 
	mov al, [ytemp4]
	mov [y_coor4], al
	call place4;call the procedure that check the place of the ghost
	popa;pull all Registers
	ret
endp check_Movego4;finish the procedure

proc delay		; Waiting a little while
	mov cx, 03h ;High Word
	mov dx, 500 ;Low Word
	xor al,al
	mov ah, 86h ;Wait
	int 15h
	ret
endp delay;finish the procedure
proc random; get an random number to randomnum
	mov bx, [savebx]   ;ghost 1
	add bx, ax
	mov ax, 40h;put segment number in register es 
	mov es,ax
	mov ax,[es:6ch];move random number to ax
	xor ax, [bx]
	mov [savebx], bx
	and ax, 11b;set range to 0-3
	mov [randomnum], ax
	ret
endp random;finish the procedure

proc randomgo2;get an random number to randomnum
	mov bx, [savebx2]   ;ghost 2
	add bx, ax  
	mov ax, 40h;put segment number in register es 
	mov es,ax
	mov ax,[es:6ch];move random number to ax 
	xor ax, [bx] 
	mov [savebx2], bx
	and ax, 11b;set range to 0-3
	mov [randomnum2], ax
	ret
endp randomgo2;finish the procedure

proc randomgo3;get an random number to randomnum
	mov bx, [savebx3]   ;ghost 3
	add bx, ax
	mov ax, 40h;put segment number in register es 
	mov es,ax
	mov ax,[es:6ch];move random number to ax
	xor ax, [bx]
	mov [savebx3], bx
	and ax, 11b;set range to 0-3
	mov [randomnum3], ax
	ret
endp randomgo3;finish the procedure

proc randomgo4;get an random number to randomnum
	mov bx, [savebx4]   ;ghost 4
	add bx, ax
	mov ax, 40h;put segment number in register es 
	mov es,ax
	mov ax,[es:6ch];move random number to ax
	xor ax, [bx]
	mov [savebx4], bx
	and ax, 11b;set range to 0-3
	mov [randomnum4], ax
	ret
endp randomgo4;finish the procedure

proc updatedirection;put in the direction that the player chose to direction
	cmp al,'w'
	je update 
	cmp al,'a'
	je update 
	cmp al,'s'
	je update 
	cmp al,'d'
	je update
	cmp al,'q'
	je update
	jmp endupdate
update:
	mov [direction],al
endupdate:
	ret
endp updatedirection;finish the procedure

proc drawblackspace;Deletes the last nove of ghost1
	mov bh, 0
	mov dh, [y_coor] ; Row number
	mov dl, [x_coor] ; Column number
	mov ah, 2h  ; change to text mode
	int 10h
	mov ah, 9  ;interrupt code for print a character with color
	mov al, [gofood1]	;character to display - asci code
	mov bh,0h ;Page - always 0
	mov bl, 15 ;BL = Foreground
	mov cx, 1 ;number of times to write character
	int 10h
	ret
endp drawblackspace;finish the procedure

proc drawblackspacego2;Deletes the last nove of ghost2
	mov bh, 0
	mov dh, [y_coor2] ; Row number
	mov dl, [x_coor2] ; Column number
	mov ah, 2h   ; change to text mode
	int 10h
	mov ah, 9  ;interrupt code for print a character with color
	mov al, [gofood2]	;character to display - asci code
	mov bh,0h ;Page - always 0
	mov bl,15 ;BL = Foreground
	mov cx, 1 ;number of times to write character
	int 10h
	ret
endp drawblackspacego2;finish the procedure

proc drawblackspacego3;Deletes the last nove of ghost3
	mov bh, 0
	mov dh, [y_coor3] ; Row number
	mov dl, [x_coor3] ; Column number
	mov ah, 2h   ; change to text mode
	int 10h
	mov ah, 9  ;interrupt code for print a character with color
	mov al, [gofood3]	;character to display - asci code
	mov bh,0h ;Page - always 0
	mov bl,15 ;BL = Foreground
	mov cx, 1 ;number of times to write character
	int 10h
	ret
endp drawblackspacego3;finish the procedure

proc drawblackspacego4;Deletes the last nove of ghost4
	mov bh, 0
	mov dh, [y_coor4] ; Row number
	mov dl, [x_coor4] ; Column number
	mov ah, 2h   ; change to text mode
	int 10h
	mov ah, 9  ;interrupt code for print a character with color
	mov al, [gofood4]	;character to display - asci code
	mov bh,0h ;Page - always 0
	mov bl, 15 ;BL = Foreground
	mov cx, 1 ;number of times to write character
	int 10h
	ret
endp drawblackspacego4;finish the procedure

proc losego;call and print the lose screen
	mov al, 13h ;(40x25)
	mov ah, 0;go to Graphic mode
	int 10h
	mov  dx, offset lose
	mov  ah, 9h		;print the String in dx
	int  21h
	mov ah,0h	; wait for character
	int 16h
	ret
endp losego;finish the procedure
proc zero;reset all the variables 
	mov [y_coordinate], 2
	mov [x_coordinate], 3
	mov [x_temp], 0
	mov [y_temp], 0
	mov [color] , 14
	mov [canMove], 1
	mov [boozzz] , 0
	mov [direction] , 0
	mov [savebx] , 5
	mov [boozzz1], 0
	mov [y_coor] , 18
	mov [x_coor] ,35
	mov [xtemp] , 0
	mov [ytemp] , 0
	mov [color1] , 5
	mov [can_Move] , 1
	mov [y_coor2] , 10
	mov [x_coor2] , 9
	mov [color2] , 9
	mov [xtemp2] , 0
	mov [ytemp2] , 0
    mov [can_Move2] , 1
	mov [savebx2] , 9
	mov [y_coor3], 5
	mov [x_coor3] , 21
	mov [color3], 7
	mov [xtemp3] , 0
	mov [ytemp3] , 0
	mov [can_Move3] , 1
	mov [savebx3] , 9
	mov [y_coor4] , 20
	mov [x_coor4] , 3
	mov [color4] , 10
	mov [xtemp4] , 0
	mov [ytemp4] , 0
	mov [can_Move4] , 1
	mov [savebx4] , 9
	mov [y_coor] ,20
	mov [x_coor] , 6
	mov [color] , 4
	mov [score], 0
	mov [gofood1], 0
	mov [gofood2], 0
	mov [gofood3], 0
	mov [gofood4], 0
	mov [ten],10
	ret
endp zero;finish the procedure

proc foodscore;print the score to the screen
	mov bh, 0
	mov dh, 23
	mov dl, 2
	mov ah, 2h   ; change to text mode
	int 10h
	mov al, [score]
	mov ah, 0
	div [ten]
	add ax, '00'
	mov dx, ax
	mov ah, 2h   ; change to text mode
	int 21h
	mov dl, dh		;print a number to the screen (score)
	int 21h
	ret
endp foodscore;finish the procedure
proc startscreen;print the start screen to the screen
	call Graphic
	mov  dx, offset msg
	mov  ah, 9h		;print the String in dx
	int  21h
	ret
endp startscreen;finish the procedure
proc Graphic
	mov al, 13h ;(40x25);go to Graphic mode
	mov ah, 0h
	int 10h
	ret
endp Graphic
proc waitfor
	mov ah,0h; wait for chararcter
	int 16h
	ret
endp waitfor

start:
	mov ax, @data
	mov ds, ax
; --------------------------
; Your code here
	call startscreen
chackin:
	call waitfor
	cmp al,'i';check if i was press
	je instruction;if it is so jump to the instruction
	cmp al,'s';check if s was press
	je printa;if it is so jump to the start point
	cmp al,'e';check if e was press
	je priexit;if it is so jump to the end

	jmp chackin;if nothing was prass wait again to character
	
instruction:
	mov  dx, offset my;print the instruction to the screen
	mov  ah, 9h		;print the String in dx
	int  21h
	call waitfor

printa:
	call Graphic
	mov  dx, offset maze;print the game screen to the screen
	mov  ah, 9h		;print the String in dx
	int  21h

print:;call the characters of the game and print them to the screen
	call go;call ghost number1
	call go2;call ghost number2
	call go3;call ghost number3 
	call go4;call ghost number4 
	call lev;call pacman
	call delay;call procedure delay
	mov ah,1; wait for chararcter
	int 16h
    jz cont;check the zero flag and jump to cont
	call waitfor; wait for chararcter
	call updatedirection;call procedure updatedirection

cont:
	cmp [direction],'q'
	je priexit
	cmp [direction],'w';check the press on the keyboard
	je up1;jmp if it is equal to w
	cmp [direction],'a';check the press on the keyboard
	je prileft1;jmp if it is equal to a
	cmp [direction],'s';check the press on the keyboard
	je pridown1;jmp if it is equal to s
	cmp [direction],'d';check the press on the keyboard
	je priright1;jmp if it is equal to d
	mov [color], 14;change the color on the screen
	jmp goast;if nothing was pressed jump to ghost
	
priexit:
	jmp exit
	
up1:;move the pacman up
	mov [color],0
	call lev
	call up
	call checkMove
	cmp [canMove], 1
	je primove_lev
	cmp [boozzz], 1
	je prilosepac
	call down
	mov [color], 14
	jmp goast
	
prileft1:       ;because of a big jump 
	jmp left1
priright1:       ;because of a big jump 
	jmp right1
pridown1:       ;because of a big jump 
	jmp down1
	
left1:;move the pacman left
	mov [color],0
	call lev
	call left
	call checkMove
	cmp [canMove], 1
	je primove_lev
	cmp [boozzz], 1
	je prilosepac
	call right
	mov [color], 14
	jmp goast
	
primove_lev:       ;because of a big jump 
	jmp move_lev
prilosepac:       ;because of a big jump 
	jmp losepac
	
down1:;move the pacman down
	mov [color],0
	call lev
	call down
	call checkMove
	cmp [canMove], 1
	je move_lev
	cmp [boozzz], 1
	je losepac
	call up
	mov [color], 14
	jmp goast
	
right1:;move the pacman right
	mov [color],0
	call lev
	call right
	call checkMove
	cmp [canMove], 1
	je move_lev
	cmp [boozzz], 1
	je losepac
	call left
	mov [color], 14
	jmp goast
	
move_lev:;change the pacman color
	mov [color], 14
	cmp [score],99;check if the 
	je winpac1
	jmp goast

winpac1:
	call Graphic
	mov  dx, offset win;call the win screen and print him
	mov  ah, 9h		;print the String in dx
	int  21h
	call waitfor; wait for character
	
winpac2:
	cmp al,'s';check if s was press if it wasnt press continue
	je pri5printa;if s was press jump to restart the game
	cmp al,'e';check if e was press if it wasnt press continue
	je prexit;if e was press jump to the end of the game
	jmp goast
	
prexit:        ;because of a big jump
	jmp exit
	
pri5printa:;reset the game if s was press
	call zero
	jmp printa
	
losepac:;if the pacman lost print the lose screen to the screen
	call losego
	jmp losepac1
	
losepac1:
	cmp al,'s';check if s was press if it wasnt press continue
	je pri5printa;if s was press jump to restart the game
	cmp al,'e';check if e was press if it wasnt press continue
	je prexit;if e was press jump to the end of the game
	
skiprandom:;check what is the random number and move th ghost according to the random number
	cmp [randomnum],0
	je up2
	cmp [randomnum],2
	je left2
	cmp [randomnum],3
	je down2
	cmp [randomnum],1
	je priright2
	mov [color1], 5	
	
goast:;the ghost 1 move lev
	call lev
	jmp skiprandom
	jmp goast2

up2:;move ghost 1 up
	mov [color1],0
	call drawblackspace;call to delete the last move
	call up3
	call check_Move
	cmp [can_Move], 1;check if the next step is enter and he can move
	je primove1
	cmp [boozzz1], 2;check if the next step is pacman
	je prilosego1
	call random;get randomnum 
	call down3
	mov [color1],5
	jmp goast2

left2:;move ghost 1 left
	mov [color1],0
	call drawblackspace;call to delete the last move
	call left3
	call check_Move
	cmp [can_Move], 1;check if the next step is enter and he can move
	je primove1
	cmp [boozzz1], 2;check if the next step is pacman
	je prilosego1
	call random;get randomnum 
	call right3
	mov [color1], 5
	jmp goast2
	
primove1:       ;because of a big jump
	jmp move_go
prilosego1:       ;because of a big jump
	jmp losego1
priright2:       ;because of a big jump
	jmp right2
	
down2:;move ghost 1 down
	mov [color1],0
	call drawblackspace;call to delete the last move
	call down3
	call check_Move
	cmp [can_Move], 1;check if the next step is enter and he can move
	je move_go
	cmp [boozzz1], 2;check if the next step is pacman
	je losego1
	call random;get randomnum 
	call up3
	mov [color1],5
	jmp goast2

right2:;move ghost 1 right
	mov [color1],0
	call drawblackspace;call to delete the last move
	call right3
	call check_Move
	cmp [can_Move], 1;check if the next step is enter and he can move
	je move_go
	cmp [boozzz1], 2;check if the next step is pacman
	je losego1
	call random;get randomnum 
	call left3
	mov [color1], 5
	jmp goast2

move_go:;check if the pacman lost and change his color
	cmp [boozzz1], 2
	je losego1
	mov [color1], 5
	jmp goast2
	
losego1:
	call losego;if the pacman lost print the lose screen to the screen
	cmp al,'s';check if s was press if it wasnt press continue
	je pri1printa;if s was press jump to restart the game
	cmp al,'e';check if e was press if it wasnt press continue
	je pri1exit;if e was press jump to the end of the game
	jmp losego1
	
pri1printa:;reset the game if s was press
	call zero
	jmp printa
pri1exit:        ;because of a big jump
	jmp exit
	
skiprandom2:;check what is the random number and move th ghost according to the random number
	cmp [randomnum2],0
	je upg2
	cmp [randomnum2],2
	je leftg2
	cmp [randomnum2],3
	je downg2
	cmp [randomnum2],1
	je prirightg2
	mov [color2], 9
	
goast2:;the ghost 2 move
	jmp skiprandom2
	jmp goast3
	
upg2:;move ghost 2 up
	mov [color2],0
	call drawblackspacego2;call to delete the last move
	call upgo2;move up
	call check_Movego2;check the next step
	cmp [can_Move2], 1;check if the next step is enter and he can move
	je primove2
	cmp [boozzz1], 2;check if the next step is pacman
	je prilosego2
	call randomgo2;get randomnum 
	call downgo2;move down
	mov [color2],9
	jmp goast3

leftg2:;move ghost 2 left
	mov [color2],0
	call drawblackspacego2;call to delete the last move
	call leftgo2;move left
	call check_Movego2;check the next step
	cmp [can_Move2], 1;check if the next step is enter and he can move
	je move_go2
	cmp [boozzz1], 2;check if the next step is pacman
	je losego2
	call randomgo2;get randomnum 
	call rightgo2;move right
	mov [color2], 9
	jmp goast3
	
primove2:       ;because of a big jump
	jmp move_go2
prilosego2:       ;because of a big jump
	jmp losego2
prirightg2:       ;because of a big jump
	jmp rightg2
	
downg2:;move ghost 2 down
	mov [color2],0
	call drawblackspacego2;call to delete the last move
	call downgo2;move down
	call check_Movego2;check the next step
	cmp [can_Move2], 1;check if the next step is enter and he can move
	je move_go2
	cmp [boozzz1], 2;check if the next step is pacman
	je losego2
	call randomgo2;get randomnum 
	call upgo2;move up
	mov [color2],9
	jmp goast3

rightg2:;move ghost 2 right
	mov [color2],0
	call drawblackspacego2;call to delete the last move
	call rightgo2;move right
	call check_Movego2;check the next step
	cmp [can_Move2], 1;check if the next step is enter and he can move
	je move_go2
	cmp [boozzz1], 2;check if the next step is pacman
	je losego2
	call randomgo2;get randomnum 
	call leftgo2;move left
	mov [color2], 9
	jmp goast3

move_go2:;check if the pacman lost and change his color
	cmp [boozzz1], 2
	je losego2
	mov [color2], 9
	jmp goast3
	
losego2:
	call losego;if the pacman lost print the lose screen to the screen
	cmp al,'s';check if s was press if it wasnt press continue
	je pri2printa;if s was press jump to restart the game
	cmp al,'e';check if e was press if it wasnt press continue
	je pri2exit;if e was press jump to the end of the game
	jmp losego2
		
pri2printa:;reset the game if s was press
	call zero
	jmp printa
pri2exit:        ;because of a big jump
	jmp exit
	
goast3:;the ghost 3 move
	jmp skiprandom3
	jmp goast4

 skiprandom3:;check what is the random number and move th ghost according to the random number
	cmp [randomnum3],0
	je upg3
	cmp [randomnum3],2
	je leftg3
	cmp [randomnum3],3
	je downg3
	cmp [randomnum3],1
	je prirightg3
	mov [color3], 7
	
upg3:;move ghost 3 up
	mov [color3],0
	call drawblackspacego3;call to delete the last move
	call upgo3;move up
	call check_Movego3;check the next step
	cmp [can_Move3], 1;check if the next step is enter and he can move
	je primove3
	cmp [boozzz1], 2;check if the next step is pacman
	je prilosego3
	call randomgo3;get randomnum 
	call downgo3;move down
	mov [color3],7
	jmp goast4

leftg3:;move ghost 3 left
	mov [color3],0
	call drawblackspacego3;call to delete the last move
	call leftgo3;move left
	call check_Movego3;check the next step
	cmp [can_Move3], 1;check if the next step is enter and he can move
	je move_go3
	cmp [boozzz1], 2;check if the next step is pacman
	je losego3
	call randomgo3;get randomnum 
	call rightgo3;move right
	mov [color3], 7
	jmp goast4
	
primove3:       ;because of a big jump
	jmp move_go3
prilosego3:       ;because of a big jump
	jmp losego3
prirightg3:       ;because of a big jump
	jmp rightg3
	
downg3:;move ghost 3 down
	mov [color3],0
	call drawblackspacego3;call to delete the last move
	call downgo3;move down
	call check_Movego3;check the next step
	cmp [can_Move3], 1;check if the next step is enter and he can move
	je move_go3
	cmp [boozzz1], 2;check if the next step is pacman
	je losego3
	call randomgo3;get randomnum 
	call upgo3;move up
	mov [color3],7
	jmp goast4

rightg3:;move ghost 3 right
	mov [color3],0
	call drawblackspacego3;call to delete the last move
	call rightgo3;move right
	call check_Movego3;check the next step
	cmp [can_Move3], 1;check if the next step is enter and he can move
	je move_go3
	cmp [boozzz1], 2;check if the next step is pacman
	je losego3
	call randomgo3;get randomnum 
	call leftgo3;move left
	mov [color3], 7
	jmp goast4

move_go3:;check if the pacman lost and change his color
	cmp [boozzz1], 2
	je losego3
	mov [color3], 7
	jmp goast4
	
losego3:
	call losego;if the pacman lost print the lose screen to the screen
	cmp al,'s';check if s was press if it wasnt press continue
	je pri3printa;if s was press jump to restart the game
	cmp al,'e';check if e was press if it wasnt press continue
	je pri3exit;if e was press jump to the end of the game
	jmp losego3
	
pri3printa:;reset the game if s was press
	call zero
	jmp printa
pri3exit:        ;because of a big jump
	jmp exit

goast4:;the ghost 4 move
	jmp skiprandom4
	jmp print
	
 skiprandom4:;check what is the random number and move th ghost according to the random number
	cmp [randomnum4],0
	je upg4
	cmp [randomnum4],2
	je leftg4
	cmp [randomnum4],3
	je downg4
	cmp [randomnum4],1
	je prirightg4
	mov [color4], 10
	
upg4:;move ghost 4 up
	mov [color4],0
	call drawblackspacego4;call to delete the last move
	call upgo4;move up
	call check_Movego4;check the next step
	cmp [can_Move4], 1;check if the next step is enter and he can move
	je primove4
	cmp [boozzz1], 2;check if the next step is pacman
	je prilosego4
	call randomgo4;get randomnum 
	call downgo4;move down
	mov [color4],10
	jmp print

leftg4:;move ghost 4 left
	mov [color4],0
	call drawblackspacego4;call to delete the last move
	call leftgo4;move left
	call check_Movego4;check the next step
	cmp [can_Move4], 1;check if the next step is enter and he can move
	je move_go4
	cmp [boozzz1], 2;check if the next step is pacman
	je losego4
	call randomgo4;get randomnum 
	call rightgo4;move right
	mov [color4], 10
	jmp print
	
primove4:       ;because of a big jump
	jmp move_go4
prilosego4:       ;because of a big jump
	jmp losego4
prirightg4:       ;because of a big jump
	jmp rightg4
	
downg4:;move ghost 4 down
	mov [color4],0
	call drawblackspacego4;call to delete the last move
	call downgo4;move down
	call check_Movego4;check the next step
	cmp [can_Move4], 1;check if the next step is enter and he can move
	je move_go4
	cmp [boozzz1], 2;check if the next step is pacman
	je losego4
	call randomgo4;get randomnum 
	call upgo4;move up
	mov [color4],10
	jmp print

rightg4:;move ghost 4 right
	mov [color4],0
	call drawblackspacego4;call to delete the last move
	call rightgo4;move right
	call check_Movego4;check the next step
	cmp [can_Move4], 1;check if the next step is enter and he can move
	je move_go4
	cmp [boozzz1], 2;check if the next step is pacman
	je losego4
	call randomgo4;get randomnum 
	call leftgo4;move left
	mov [color4], 10
	jmp print

move_go4:;check if the pacman lost and change his color
	cmp [boozzz1], 2;check if the next step is pacman
	je losego4
	mov [color4], 10
	jmp print
	
losego4:
	call losego;if the pacman lost print the lose screen to the screen
	cmp al,'s';check if s was press if it wasnt press continue
	je pri4printa;if s was press jump to restart the game
	cmp al,'e';check if e was press if it wasnt press continue
	je exit;if e was press jump to the end of the game
	jmp losego4

	
pri4printa:;reset the game if s was press
	call zero
	jmp printa
; --------------------------
exit:
	mov ax, 4c00h		;exit the program
	int 21h
END start