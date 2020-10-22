
IDEAL
MODEL small
STACK 100h
p186
jumps
DATASEG
; --------------------------
screenChr db 0
chr db 0
x_cord db 1
y_cord db 1
color dw 0
wall db 0
endTime db 0
timend db 0
ten db 10
number db 0
number2 db 0
diamond db 0
reachedFirst db 0
frame db 201, 18 dup (205),187,10,13
db 	     186,' ',' ',200,188,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186,10,13 
db 	     186,' ',' ',' ',' ',' ',' ',201,205,205,187,' ',205,205,205,205,205,' ',205,185,10,13  
db 	     204,205,205,187,' ',186,' ',186,219,219,186,' ',' ',' ',' ',205,205,' ',205,185,10,13  
db 	     186,219,219,186,' ',186,' ',186,219,219,186,' ',201,187,' ',' ',' ',' ',' ',186,10,13  
db 	     204,205,205,188,' ',186,' ',200,205,205,188,' ',200,202,205,205,205,' ',205,185,10,13  
db 	     186,' ',' ',' ',' ',186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186,10,13                  
db 	     186,' ',201,187,' ',186,' ',205,205,205,205,187,' ',201,205,205,205,187,' ',186,10,13                         
db 	     186,' ',200,188,' ',186,' ',' ',' ',' ',' ',186,' ',186,219,219,219,186,' ',186,10,13                         
db 	     186,' ',' ',' ',' ',186,' ',201,205,187,' ',186,' ',200,187,219,219,186,' ',186,10,13 
db 	     186,' ',201,187,' ',186,' ',186,219,186,' ',186,' ',' ',186,219,219,186,' ',186,10,13 
db 	     186,' ',200,188,' ',186,' ',200,205,188,' ',204,187,' ',186,219,219,186,' ',186,10,13 
db 	     186,' ',' ',' ',' ',186,' ',' ',' ',' ',' ',204,185,' ',186,219,219,186,' ',186,10,13 
db 	     204,205,205,' ',205,202,205,205,205,205,' ',204,185,' ',200,187,219,186,' ',186,10,13                                          
db 	     186,' ',' ',' ',201,205,187,' ',' ',' ',' ',204,185,' ',' ',186,219,186,' ',186,10,13                                          
db 	     186,' ',' ',201,188,219,186,' ',201,205,205,202,202,187,' ',186,219,186,' ',186,10,13                                          
db 	     186,' ',201,188,219,219,186,' ',186,219,219,219,219,186,' ',186,219,186,' ',186,10,13                  
db 	     204,205,202,205,205,205,188,' ',186,219,219,219,219,186,' ',200,205,202,' ',185,10,13                  
db 	     186,004,' ',' ',' ',' ',' ',' ',200,205,205,205,205,188,' ',' ',' ',' ',' ',186,10,13                                      
db 		 200, 18 dup (205),188,10,13,'$'
instructions db 'The Maze',10,13
		     db 'get th diamond to win',10,13
		     db 'you have one minute or you loss',10,13
		     db 'press anything to continue',10,13,'$'
lostscreen db '          _   _         _   _  ',10,13                         
db '         | | | |       | | | |  ',10,13                          
db '         | |_| | __ _  | |_| | __ _ 	',10,13   
db '	 |  _  |/ _` | |  _  |/ _` |	',10,13   
db '	 | | | | (_| | | | | | (_| |	',10,13   
db '	 \_| |_/\__,_| \_| |_/\__,_|	',10,13 
db '          	 _     ',10,13
db '         	| |        ',10,13
db '		| | ___  ___  ___ _ __ ',10,13
db '		| |/ _ \/ __|/ _ \  __|',10,13
db '		| | (_) \__ \  __/ |   ',10,13
db '		|_|\___/|___/\___|_|   ',10,13,'$'
won db '.----------------.    .----------------.  .----------------.  .-----------------. ',10,13 
db '| .--------------. |  | .--------------. || .--------------. || .--------------. | ',10,13
db '| | _____  _____ | |  | | _____  _____ | || |     ____     | || | ____  _____  | | ',10,13
db '| ||_   _||_   _|| |  | ||_   _||_   _|| || |   .     `.   | || ||_   \|_   _| | | ',10,13
db '| |  | |    | |  | |  | |  | | /\ | |  | || |  /  .--.  \  | || |  |   \ | |   | | ',10,13
db '| |  | |    | |  | |  | |  | |/  \| |  | || |  | |    | |  | || |  | |\ \| |   | | ',10,13
db '| |   \ `--  /   | |  | |  |   /\   |  | || |  \  `--  /  | || | _| |_\   |_  | | ',10,13
db '| |    `.__.     | |  | |  |__/  \__|  | || |   `.____.    | || ||_____|\____| | | ',10,13
db '| |              | |  | |              | || |              | || |              | | ',10,13
db '| -------------- | |   --------------  ||  --------------  ||  --------------  | ',10,13
db ' ----------------      ----------------    ----------------    ----------------  ',10,13,'$'
; --------------------------
CODESEG
;calculates the end time of the game
proc calculate_End_Time
	pusha
	mov ah, 2ch
	int 21h
	mov [number2], dh
	mov [endTime], dh
	cmp [endTime], 0
	je reset
	dec [endTime]
	jmp dec_1
reset:
	add [endTime],59
dec_1:
	popa
	ret
endp calculate_End_Time
;checks whether the end time is met
proc checkEndTime
	pusha
	mov ah, 2ch
	int 21h
	cmp dh, [endTime]
	je timend11
	jmp timenotend
timend11:
	mov [timend], 1
timenotend:
	cmp [number2], dh
	jg larger
	jmp smaller
larger:
	add dh, 60
smaller:
	mov [number], dh
	mov ch, [number2]
	sub [number], ch
	call print_Number
	popa
	ret
endp checkEndTime
;prints a number in decimal
proc print_number
	pusha
	;sets cursor on the corner
	mov dh, 19 ; row
	mov dl, 35 ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	mov al, [number]
	mov ah, 0
	div [ten]
	add ax, '00'
	mov dx, ax
	mov ah, 2h
	int 21h
	mov dl, dh
	mov ah, 2h
	int 21h
	popa
	ret
endp print_Number
;print a string on the screen assuming the string offset is in dx
proc printString
	pusha
	mov ah, 9h
	int 21h ; interrupt that displays a string
	popa
	ret
endp printString
; reads a character into chr
proc readChr
	pusha
	; waits for character
	mov ah, 0h
	int 16h
	mov [chr], al ; save character to [chr]
	popa
	ret
endp readChr
;sets the cursor location
proc setCursorePosition
    pusha
	; set cursore location
	mov dh, [y_cord] ; row
	mov dl, [x_cord] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret
endp setCursorePosition
;draws the character on the screen
proc drawCharacter
    pusha
	; draw smiley - ascii 2 at cursor position
	mov ah, 9
	mov al, 2 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	popa
	ret
endp drawCharacter
;draws the wall on the screen
proc drawWall
    pusha
	; draw wall - ascii 205 at cursor position
	mov ah, 9
	mov al, 205 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	popa
	ret
endp drawWall
;draws the diamond on the screen
proc drawDiamond
    pusha
	; draw diamond - ascii 4 at cursor position
	mov ah, 9
	mov al, 4 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	popa
	ret
endp drawDiamond
;reads the char that is on the screen
proc readScreenChr 
	pusha
	mov bh, 0h ; Page=1
	mov ah, 08h ; Read character function
	int 10h ; return the character to al
	mov [screenChr], al
	popa
	ret
endp readScreenChr 
;proc that call the readScreenChr and check if it's a wall
proc checkScreenChr
	mov [wall], 0
	call setCursorePosition
	call readScreenChr
	cmp [screenChr], 186
	je wall1
	cmp [screenChr], 187
	je wall1
	cmp [screenChr], 188
	je wall1
	cmp [screenChr], 200
	je wall1
	cmp [screenChr], 201
	je wall1
	cmp [screenChr], 205
	je wall1
	cmp [screenChr], 204
	je wall1
	cmp [screenChr], 185
	je wall1
	cmp [screenChr], 202
	je wall1
	cmp [screenChr], 004
	je winner
	jmp finish
winner:
	mov [diamond], 1
	jmp finish
wall1:
	mov [wall], 1
finish:
	ret
endp checkScreenChr
proc movDiamond
	pusha
	mov al, [x_cord]
	mov ah, [y_cord]
	mov [x_cord], 1
	mov [y_cord], 18
	call setCursorePosition
	mov [color], 0
	call drawDiamond
	sub [y_cord], 2
	call setCursorePosition
	cmp [reachedFirst], 1
	je continue2
	mov [color], 0Fh
	jmp continue3
continue2:
	mov [color], 0h
	call drawDiamond
	mov [x_cord], 18
	mov [y_cord], 18
	call setCursorePosition
	mov [color], 0Fh
	call drawDiamond
	jmp finish1
continue3:
	call drawDiamond
	mov [reachedFirst], 1
finish1:
	mov [x_cord], al
	mov [y_cord], ah
	popa
	ret
endp movDiamond
start:
	mov ax, @data
	mov ds, ax
	
	;print the instructions
	mov dx, offset instructions
	call printString
	
	;wait for the user to continue
	call readChr
	
	;enter graphic mode
	mov ax, 13h
	int 10h
	
	;print the frame
	mov dx, offset frame
	call printString
	
	;print the player
	mov [color], 0Eh
	call setCursorePosition
	call drawCharacter
	
	call calculate_End_Time
	
mainGameLoop:
	mov [chr], 0
	mov ah, 1h
	int 16h
	
	jz time
	
	call readChr
	
	cmp [chr], 'd'
	je right
	
	cmp [chr], 's'
	je down
	
	cmp [chr], 'a'
	je left
	
	cmp [chr], 'w'
	je up
	
	cmp [chr], 'q'
	je lost
	
	jmp mainGameLoop
	
right:
	mov [color], 0h
	call setCursorePosition
	call drawCharacter
	inc [x_cord]
	call checkScreenChr
	cmp [wall], 0
	je move
	dec [x_cord]
	jmp move
	
left:
	mov [color], 0h
	call setCursorePosition
	call drawCharacter
	dec [x_cord]
	call checkScreenChr
	cmp [wall], 0
	je move
	inc [x_cord]
	jmp move
	
down:
	mov [color], 0h
	call setCursorePosition
	call drawCharacter
	inc [y_cord]
	call checkScreenChr
	cmp [wall], 0
	je move
	dec [y_cord]
	jmp move
	
up:
	mov [color], 0h
	call setCursorePosition
	call drawCharacter
	dec [y_cord]
	call checkScreenChr
	cmp [wall], 0
	je move
	inc [y_cord]
	jmp move
	
move:
	cmp [x_cord], 2
	jne continue
	cmp [y_cord], 18
	jne continue
	cmp [reachedFirst], 1
	je continue
	call movDiamond
	
continue:
	cmp [x_cord], 1
	jne continue4
	cmp [y_cord], 15
	jne continue4
	call movDiamond
	
continue4:
	cmp [x_cord], 18
	jne continue5
	cmp [y_cord], 16
	jne continue5
	inc [y_cord]
	mov [color], 0Fh
	call setCursorePosition
	call drawWall
	dec [y_cord]
	
continue5:
	mov [color], 0Eh
	call setCursorePosition
	call drawCharacter
	cmp [diamond], 1
	je win
	
time:
	call checkEndTime
	cmp [timend], 1
	je lost
	jmp mainGameLoop
	
lost:
	mov ax, 2h
	int 10h
	
	mov dx, offset lostscreen
	call printString
	
	call readChr
	
	jmp exit
	
win:
	mov ax, 2h
	int 10h
	
	mov dx, offset won
	call printString
	
	call readChr
	
	jmp exit
	
;--------------------------	
exit:
	mov ax, 2h
	int 10h
	mov ax, 4c00h
	int 21h
END start