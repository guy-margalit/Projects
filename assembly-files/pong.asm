IDEAL
MODEL small
STACK 100h
p186
DATASEG
; --------------------------
openScreen db' ',10,13
db '________ ______ _______ _______ _     ' ,10,13
db '___  __ \_  __ \__  __ \__  __ `/  ' ,10,13  
db '__  /_/ // /_/ /_  / / /_  /_/ /   ' ,10,13  
db '_  .___/ \____/ /_/ /_/ _\__, /    ' ,10,13  
db '/_/                     /____/' ,10,13
db '  ',10,13
db'A masterpiece by Ido Gurevitz',10,13 
db 'press ANY key to start the match',10,13,'$'

court  db 201,30 dup(205),187,10,13
       db 175,30 dup(' '),174,10,13 
	   db 175,30 dup(' '),174,10,13 
	   db 175,30 dup(' '),174,10,13 
	   db 175,30 dup(' '),174,10,13 
	   db 175,30 dup(' '),174,10,13 
	   db 175,30 dup(' '),174,10,13  
	   db 175,30 dup(' '),174,10,13 
	   db 175,30 dup(' '),174,10,13  
	   db 175,30 dup(' '),174,10,13  
	   db 175,30 dup(' '),174,10,13  
       db 175,30 dup(' '),174,10,13 
	   db 175,30 dup(' '),174,10,13 
	   db 175,30 dup(' '),174,10,13 
	   db 175,30 dup(' '),174,10,13 
	   db 175,30 dup(' '),174,10,13 
	   db 200,30 dup(205),188,10,13
	   db 'press S to start the game',10,13,'$'
chr db 0 
color dw 15
len dw 5
len2 dw 20
character db 0
y_ball db 7
x_ball db 16
y_cord db 7
x_cord db 29
y_cord1 db 7
x_cord1 db 3
x_temp db 0
y_temp db 0 
blocked db 0
screenChr db 0
lost db 0
dir1 db 'l'
dir2 db 'u'

UP equ 72
DOWN equ 80
; --------------------------
CODESEG

; print a string on the screen assuming the string offset is in dx
proc printString
	pusha
	mov ah, 9h
	int 21h ;interrupt that displays a string
	popa	
	ret
endp printString

proc readChr
; waits for character
	mov ah, 0h
	int 16h
	mov [chr], al ; save character to [chr]
	ret
endp readChr

; print character
proc drawCharacter
	pusha
	mov ah, 9
	mov al, [character] ; al = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	popa
	ret
endp drawCharacter

proc delay
	pusha
	mov cx, 03h ;High Word
	mov dx, 0d40h ;Low Word
	mov al, 0
	mov ah, 86h ;Wait
	int 15h
	popa
	ret
endp delay

proc setBallCursorePosition
	pusha
	mov dh, [y_ball]; row
	mov dl, [x_ball] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret 
endp setBallCursorePosition

proc setCursorePosition1
	pusha
	mov dh, [y_cord1]; row
	mov dl, [x_cord1] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret 
endp setCursorePosition1

proc setCursorePosition
	pusha
	mov dh, [y_cord]; row
	mov dl, [x_cord] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret 
endp setCursorePosition

;reads the char that is on the screen
proc readScreenChr
	pusha
	mov bh, 0h ; Page=1
	mov ah, 08h ; Read character function
	int 10h ; return the character to al
	mov [screenChr], al ;move the character from al to screenChr
	popa
	ret
endp readScreenChr

proc checkScreenChr
	pusha
	mov [blocked], 0
	call readScreenChr
	cmp [screenChr], 205
	jne @@finish
	mov [blocked], 1
@@finish:
	popa
	ret
endp checkScreenChr

proc drawPlayerUp
	pusha
	call setCursorePosition
	mov [character], 219
	mov [color], 0h
	call drawCharacter
	dec [y_cord]
	call setCursorePosition
	call drawCharacter
	dec [y_cord]
	call setCursorePosition
	call drawCharacter
	
	inc [y_cord]
	call setCursorePosition
	mov [character], 219
	mov [color], 0Fh
	call drawCharacter
	dec [y_cord]
	call setCursorePosition
	call drawCharacter
	dec [y_cord]
	call setCursorePosition
	call checkScreenChr
	cmp [blocked], 1
	jne @@continue
	add [y_cord], 3
@@continue:
	call setCursorePosition
	call drawCharacter
	cmp [blocked], 1
	je @@continue1
	add [y_cord], 2
@@continue1:
	popa
	ret
endp drawPlayerUp
	
proc drawPlayerDown
	pusha
	call setCursorePosition
	mov [character], 219
	mov [color], 0h
	call drawCharacter
	dec [y_cord]
	call setCursorePosition
	call drawCharacter
	dec [y_cord]
	call setCursorePosition
	call drawCharacter
	
	inc [y_cord]
	call setCursorePosition
	mov [character], 219
	mov [color], 0Fh
	call drawCharacter
	inc [y_cord]
	call setCursorePosition
	call drawCharacter
	inc [y_cord]
	call setCursorePosition
	call checkScreenChr
	cmp [blocked], 1
	jne @@continue
	sub [y_cord], 3
@@continue:
	call setCursorePosition
	call drawCharacter
	cmp [blocked], 1
	jne @@continue1
	add [y_cord], 2
@@continue1:
	popa
	ret
endp drawPlayerDown

proc drawPlayerUp1
	pusha
	call setCursorePosition1
	mov [character], 219
	mov [color], 0h
	call drawCharacter
	dec [y_cord1]
	call setCursorePosition1
	call drawCharacter
	dec [y_cord1]
	call setCursorePosition1
	call drawCharacter
	
	inc [y_cord1]
	call setCursorePosition1
	mov [character], 219
	mov [color], 0Fh
	call drawCharacter
	dec [y_cord1]
	call setCursorePosition1
	call drawCharacter
	dec [y_cord1]
	call setCursorePosition1
	call checkScreenChr
	cmp [blocked], 1
	jne @@continue
	add [y_cord1], 3
@@continue:
	call setCursorePosition1
	call drawCharacter
	cmp [blocked], 1
	je @@continue1
	add [y_cord1], 2
@@continue1:
	popa
	ret
endp drawPlayerUp1
	
proc drawPlayerDown1
	pusha
	call setCursorePosition1
	mov [character], 219
	mov [color], 0h
	call drawCharacter
	dec [y_cord1]
	call setCursorePosition1
	call drawCharacter
	dec [y_cord1]
	call setCursorePosition1
	call drawCharacter
	
	inc [y_cord1]
	call setCursorePosition1
	mov [character], 219
	mov [color], 0Fh
	call drawCharacter
	inc [y_cord1]
	call setCursorePosition1
	call drawCharacter
	inc [y_cord1]
	call setCursorePosition
	call checkScreenChr
	cmp [blocked], 1
	jne @@continue
	sub [y_cord1], 3
@@continue:
	call setCursorePosition1
	call drawCharacter
	cmp [blocked], 1
	jne @@continue1
	add [y_cord1], 2
@@continue1:
	popa
	ret
endp drawPlayerDown1

proc calcBallCords
	pusha
	mov al, [x_ball]
	mov [x_temp], al
	mov al, [y_ball]
	mov [y_temp], al
@@start1:
	mov al, [x_temp]
	mov [x_ball], al
	mov al, [y_temp]
	mov [y_ball], al
	cmp [dir1], 'r'
	je @@right
	dec [x_ball]
	jmp @@continue
@@right:
	inc [x_ball]
	jmp @@continue
@@continue:
	cmp [dir2], 'u'
	je @@moveUp
	inc [y_ball]
	jmp @@check
@@moveUp:
	dec [y_ball]
	jmp @@check
@@check:
	call setBallCursorePosition
	call readScreenChr
	cmp [screenChr], 174
	je loserHelp
	cmp [screenChr], 175
	je changeDir1
	cmp [screenChr], 219
	je changeDir1
	cmp [screenChr], 205
	je changeDir2
	cmp [screenChr], 187
	je loserHelp
	cmp [screenChr], 200
	je changeDir3
	cmp [screenChr], 201
	je changeDir3
	cmp [screenChr], 188
	je loserHelp
	jmp @@finish
changeDir1:
	cmp [dir1], 'r'
	je rightToLeft
	mov [dir1], 'r'
	jmp @@start1
rightToLeft:
	mov [dir1], 'l'
	jmp @@start1
loserHelp:
	jmp @@loser
changeDir2:
	cmp [dir2], 'u'
	je upToDown
	mov [dir2], 'u'
	jmp @@start1
upToDown:
	mov [dir2], 'd'
	jmp @@start1
changeDir3:
	cmp [dir2], 'u'
	je upToDown1
	mov [dir2], 'u'
	jmp @@check1
upToDown1:
	mov [dir2], 'd'
	jmp @@check1
@@check1:
	cmp [dir1], 'r'
	je rightToLeft1
	mov [dir1], 'r'
	jmp @@start1
rightToLeft1:
	mov [dir1], 'l'
	jmp @@start1
@@loser:
	mov al, [x_temp]
	mov [x_ball], al
	mov al, [y_temp]
	mov [y_ball], al
	mov [lost], 1
@@finish:
	popa
	ret
endp calcBallCords

proc drawBall
	pusha
	call setBallCursorePosition
	mov [color], 0h
	mov [character], 111
	call drawCharacter
	
	call calcBallCords
	call setBallCursorePosition
	mov [color], 0Fh
	call drawCharacter
	popa
	ret
endp drawBall
start:
	mov ax, @data
	mov ds, ax
; --------------------------
	; clear screen by entering graphic mode 40*25
	mov ax, 13h
	int 10h	
	
	mov dx, offset openScreen ;calling the printString function 
	call printString
	
	call readChr
	
	;back to text mode
	mov ax, 2h
	int 10h
	
	; clear screen by entering graphic mode 40*25
	mov ax, 13h
	int 10h	
	
	mov dx, offset court ;calling the printString function 
	call printString
	
	call drawPlayerDown
	
	call drawPlayerDown1
	
	call drawBall
	
	; check if user asks to quit
	cmp [chr], 'q'
	je end_game
	
mainGameLoop:
	cmp [lost], 1
	je end_game
	
	; check if thre is a charcter to read
	mov [chr], 0
	mov ah, 1h
	int 16h
	
	; read a chararcter
	jz noKey
	
	call readChr
	
	; check if user asks to quit
	cmp [chr], 'q'
	je end_game
	
	cmp [chr], 'w'
	je moveUp2
	
	cmp [chr], 's'
	je moveDown2
	
	cmp ah, UP
	je moveUp1
	
	cmp ah, DOWN
	je moveDown1
	
noKey:
	call drawBall
	call delay
	jmp mainGameLoop
	
moveUp1:
	call drawPlayerUp
	jmp noKey
	
moveDown1:
	call drawPlayerDown
	jmp noKey
	
moveUp2:
	call drawPlayerUp1
	jmp noKey
	
moveDown2:
	call drawPlayerDown1
	jmp noKey
	
end_game:
	;back to text mode
	mov ax, 2h
	int 10h
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
END start


