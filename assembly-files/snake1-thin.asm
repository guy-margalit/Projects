IDEAL
MODEL small
STACK 100h
p186
DATASEG
lost db 0
ate db 0
ate1 db 0
ate2 db 0
ate3 db 0
secondPortalBuilt db 0
turned db 0
portal1_x db 0
portal1_y db 0
portal2_x db 0
portal2_y db 0
portal3_x db 0
portal3_y db 0
portal4_x db 0
portal4_y db 0
reprint db 0
reprint1 db 0
head dw 0
charac db 0 
quit db 0 
mode db 'e'
cant db 0
counter dw 0
snakeLen dw 2 
screenChr db 0
bx_saver dw 0
dir db 'r'
ten db 10
number db 0
x_cord db 5
y_cord db 10
x_temp db 0
y_temp db 0
delayLength dw 03h
chr db 0
parts_chars db 196, 196, 196, 25 dup (?)
parts_x db 6, 6, 5, 25 dup (?)
parts_y db 10, 10, 10, 25 dup (?)
color dw 0 
tryAgainStr db 'Invalid, Try Again',10,13,'$'
lostStr db 'You Lost!',10,13
db 186,'         Loser  ',10,13,'$'
lostScreen3 db 'You lost',10,13
		    db 'Try again',10,13
		    db 'Press 1 for',10,13
		    db 'Easy: normal snake game + normal speed',10,13
			db 'Press 2 for',10,13
			db 'Medium: easy + increased speed + powerups',10,13
			db 'Press 3 for',10,13
			db 'Hard: medium + increased speed + portals',10,13
			db 'Press Q to quit',10,13,'$'	  
notLostScreen3 db 'You did not lose',10,13
		    db 'Try again or try a more difficult mode',10,13
		    db 'Press 1 for',10,13
		    db 'Easy: normal snake game + normal speed',10,13
			db 'Press 2 for',10,13
			db 'Medium: easy + increased speed + powerups',10,13
			db 'Press 3 for',10,13
			db 'Hard: medium + increased speed + portals',10,13
			db 'Press Q to quit',10,13,'$'
instructions db 'The Snake Game',10,13
			 db 'Use the arrows to move',10,13
			 db 'Do not touch yourself or the borders',10,13
			 db 'You have 4 modes:',10,13
			 db 'Press 1 for',10,13
			 db 'Easy: normal snake game + normal speed',10,13
			 db 'Press 2 for',10,13
			 db 'Medium: easy + increased speed + powerups',10,13
			 db 'Press 3 for',10,13
			 db 'Hard: medium + increased speed + portals',10,13
			 db 'Press anything to continue',10,13,'$'
easyInst db 'Easy Mode',10,13
		 db 186,23 dup (' '),186,'Use the arrows',10,13
		 db 186,23 dup (' '),186,10,13
		 db 186,23 dup (' '),186,'Do not touch',10,13
		 db 186,23 dup (' '),186,'yourself or',10,13 
		 db 186,23 dup (' '),186,'the borders',10,13
		 db 186,23 dup (' '),186,10,13
		 db 186,23 dup (' '),186,162,' =',10,13
		 db 186,23 dup (' '),186,'increase length',10,13,'$'
medInst db 'Medium Mode',10,13
		 db 186,23 dup (' '),186,'Use the arrows',10,13
		 db 186,23 dup (' '),186,10,13
		 db 186,23 dup (' '),186,'Do not touch',10,13
		 db 186,23 dup (' '),186,'yourself or',10,13 
		 db 186,23 dup (' '),186,'the borders',10,13
		 db 186,23 dup (' '),186,10,13
		 db 186,23 dup (' '),186,162,' =',10,13
		 db 186,23 dup (' '),186,'increase length',10,13
		 db 186,23 dup (' '),186,10,13
		 db 186,23 dup (' '),186,232,' =',10,13 
		 db 186,23 dup (' '),186,'decrease length',10,13
		 db 186,23 dup (' '),186,10,13
		 db 186,23 dup (' '),186,042,' =',10,13 
		 db 186,23 dup (' '),186,'increase speed',10,13
		 db 186,23 dup (' '),186,10,13
		 db 186,23 dup (' '),186,015,' =',10,13 
		 db 186,23 dup (' '),186,'decrease speed',10,13,'$'
hardInst db 'Hard Mode',10,13
		 db 186,23 dup (' '),186,'Use the arrows',10,13
		 db 186,23 dup (' '),186,10,13
		 db 186,23 dup (' '),186,'Do not touch',10,13
		 db 186,23 dup (' '),186,'yourself or',10,13 
		 db 186,23 dup (' '),186,'the borders',10,13
		 db 186,23 dup (' '),186,10,13
		 db 186,23 dup (' '),186,162,' =',10,13
		 db 186,23 dup (' '),186,'increase length',10,13
		 db 186,23 dup (' '),186,10,13
		 db 186,23 dup (' '),186,232,' =',10,13 
		 db 186,23 dup (' '),186,'decrease length',10,13
		 db 186,23 dup (' '),186,10,13
		 db 186,23 dup (' '),186,042,' =',10,13 
		 db 186,23 dup (' '),186,'increase speed',10,13
		 db 186,23 dup (' '),186,10,13
		 db 186,23 dup (' '),186,015,' =',10,13 
		 db 186,23 dup (' '),186,'decrease speed',10,13
		 db 186,23 dup (' '),186,10,13
		 db 186,23 dup (' '),186,048,' =',10,13
		 db 186,23 dup (' '),186,'portal',10,13,'$'
frame db 201,23 dup (205),187,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 186,23 dup (' '),186,10,13
	  db 200,23 dup (205),188,10,13,'$'	  
CODESEG
proc printString
	pusha 
	mov ah, 9h
	int 21h
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
;set cursor location
proc setCursorePosition
	pusha
	mov dh, [y_cord]  ;  row  
    mov dl, [x_cord]  ; column 
    mov bh, 0         ; page number 
    mov ah, 2 
    int 10h
	popa
	ret
endp setCursorePosition
;set temp cursor location
proc setTempCursorePosition
	pusha
	mov dh, [y_temp]  ;  row  
    mov dl, [x_temp]  ; column 
    mov bh, 0         ; page number 
    mov ah, 2 
    int 10h
	popa
	ret
endp setTempCursorePosition
proc moveTheSnake
	pusha
	lea si, [parts_y]
	mov bx, offset parts_x
	mov cx, [snakeLen]
	
printer:
	inc si
	inc bx
	mov al, [si]
	mov [y_cord], al
	mov  al, [bx]
	mov [x_cord], al
	call setCursorePosition
	mov [color], 0h	
	call drawCharacter
	loop printer

	lea si, [parts_y]
	lea bx, [parts_x]
	lea di, [parts_chars]
	
	mov al, [parts_y]
	mov [y_cord], al
	mov [y_temp], al
	mov  al, [parts_x]
	mov [x_cord], al
	mov [x_temp], al 
	call checkOnPortal
	call checkNotOnSnake
	cmp [cant], 1
	je loserHelp
	call setCursorePosition
	call readScreenChr
	cmp [screenChr], 186
	je loserHelp
	cmp [screenChr], 205
	je loserHelp
	cmp [screenChr], 162
	je eat
	cmp [screenChr], 042
	je eat1
	cmp [screenChr], 015
	je eat2
	cmp [screenChr], 232
	je eat3Help
	mov cx, [snakeLen]
	add bx, [snakeLen]
	add di, [snakeLen]
	add si, [snakeLen]
	mov [color], 02h
	jmp printer1
	
eat:
	inc [snakeLen]
	mov cx, [snakeLen]
	add bx, [snakeLen]
	add si, [snakeLen]
	add di, [snakeLen]
	mov [ate], 1
	mov [color], 02h
	jmp printer1 
	
loserHelp:
	jmp loser
	
eat3Help:
	jmp eat3
	
eat1:
	mov [delayLength], 02h
	mov cx, [snakeLen]
	add bx, [snakeLen]
	add si, [snakeLen]
	add di, [snakeLen]
	mov [ate1], 1
	mov [color], 02h
	jmp printer1 
	
eat2:
	mov [delayLength], 07h
	mov cx, [snakeLen]
	add bx, [snakeLen]
	add si, [snakeLen]
	add di, [snakeLen]
	mov [ate2], 1
	mov [color], 02h
	jmp printer1 
	
eat3:
	cmp [snakeLen], 2
	je notLongEnough
	dec [snakeLen]

notLongEnough:
	mov cx, [snakeLen]
	add bx, [snakeLen]
	add si, [snakeLen]
	add di, [snakeLen]
	mov [ate3], 1
	mov [color], 02h
	jmp printer1 
	
loser:
	mov [lost], 1
	mov cx, [snakeLen]
	add bx, [snakeLen]
	add si, [snakeLen]
	add di, [snakeLen]
	mov [color], 04h
	
printer1:
	mov al, [si-1]
	mov [si], al
	mov al, [si]
	mov [y_cord], al
	mov  al, [bx]
	mov al, [bx-1]
	mov [bx], al
	mov [x_cord], al
	call setCursorePosition	
	mov al, [di]
	mov [charac], al
	call drawApple
	dec si
	dec bx
	dec di
	loop printer1
	jmp finish3
	
printer2:
	mov al, [si]
	mov [y_cord], al
	mov  al, [bx]
	mov [x_cord], al
	call setCursorePosition
	mov al, [di]
	mov [charac], al
	call drawApple
	dec si
	dec bx
	dec di
	loop printer2
	
finish3:
	popa
	ret
endp moveTheSnake
proc chooseMode
	pusha
start1:
	call readChr
	cmp [chr], '1'
	je easyMode
	cmp [chr], '2'
	je medMode
	cmp [chr], '3'
	je hardMode
	cmp [chr], '4'
	je revMode
	cmp [chr], 'q'
	je quit1
	jmp tryAgain

easyMode:
	mov [mode], 'e'
	jmp finish1
	
medMode:
	mov [mode], 'm'
	jmp finish1
	
hardMode:
	mov [mode], 'h'
	jmp finish1
	
revMode:
	mov [mode], 'r'
	jmp finish1
	
tryAgain:
	mov dx, offset tryAgainStr
	call printString
	jmp start1

quit1:
	mov [quit], 1
	jmp finish
	
finish1:
	popa
	ret
endp chooseMode
;generates a random number and keeps it in y_temp
proc random
	pusha
	mov bx, [bx_saver]
	; put segment number in register es
	mov ax, 40h
	mov es, ax
	; move random number to ax
	mov ax, [es:6Ch]
	xor ax,[bx]
	add [bx_saver],ax
	and al, 13h
	inc al
	mov [y_temp], al
	popa
	ret
endp random
;generates a random number and keeps it in x_temp
proc random1
	pusha
	mov bx, [bx_saver]
	; put segment number in register es
	mov ax, 40h
	mov es, ax
	; move random number to ax
	mov ax, [es:6Ch]
	xor ax,[bx]
	add [bx_saver],ax
	and al, 16h
	inc al
	mov [x_temp], al
	popa
	ret
endp random1
;draw the apple at cursor position
proc drawApple
	pusha
	mov ah, 9
    mov al, [charac]    ;al = character to displays
    mov bx, [color] ;bh = background bl = foreground
    mov cx, 1    ;cx = number of times to write character
    int 10h
	popa
	ret
endp drawApple
;draw snake part at cursor position
proc drawCharacter
	pusha
	mov ah, 9
    mov al, 219    ;al = character to displays
    mov bx, [color] ;bh = background bl = foreground
    mov cx, 1    ;cx = number of times to write character
    int 10h
	popa
	ret
endp drawCharacter
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
;delays
proc delay
	pusha
	mov cx, [delayLength] ; High Word
	mov dx, 0d40h ; Low Word
	mov al, 0
	mov ah, 86h ; Wait
	int 15h
	popa
	ret
endp delay
proc calcCords
	pusha
	cmp [turned], 1 
	je finish6
	cmp [dir], 'r'
	je moveRight
	cmp [dir], 'l'
	je moveLeft
	cmp [dir], 'u'
	je moveUp
	mov [parts_chars], 179
	inc [parts_y]
	jmp finish
	
moveRight:
	mov [parts_chars], 196
	inc [parts_x]
	jmp finish
	
moveLeft:
	mov [parts_chars], 196
	dec [parts_x]
	jmp finish
	
moveUp:
	mov [parts_chars], 179
	dec [parts_y]
	jmp finish
	
finish6:
	mov [turned], 0
	
finish:
	popa
	ret
endp calcCords
proc checkNotOnSnake
	pusha
	mov [cant], 0
	lea si, [parts_x]
	mov bx, offset parts_y
	mov [counter], 0

checker:
	mov ax, [snakeLen]
	cmp [counter], ax
	je done2
	inc si
	inc bx
	mov al, [x_temp]
	cmp [si], al
	je blocked1
	inc [counter]
	jmp checker
	
blocked1:
	mov al, [y_temp]
	cmp [bx], al
	je cannot
	inc [counter]
	jmp checker
	
cannot:
	mov [cant], 1
	
done2:
	popa
	ret
endp checkNotOnSnake
proc checkOnPortal
	pusha
	mov al, [portal1_x]
	mov ah, [portal1_y]
	cmp [parts_x], al
	je check2
	jmp check3

check2:
	cmp [parts_y], ah
	jne check3
	mov al, [portal2_x]
	mov ah, [portal2_y]
	mov [parts_x], al
	mov [parts_y], ah
	jmp finish4
	
check3:
	mov al, [portal2_x]
	mov ah, [portal2_y]
	cmp [parts_x], al
	je check4
	jmp finish4
	
check4:
	cmp [parts_y], ah
	jne finish4
	mov al, [portal1_x]
	mov ah, [portal1_y]
	mov [parts_x], al
	mov [parts_y], ah
	
finish4:
	popa
	ret
endp checkOnPortal
proc checkOnPortal1
	pusha
	mov al, [portal3_x]
	mov ah, [portal3_y]
	cmp [parts_x], al
	je check7
	jmp check6

check7:
	cmp [parts_y], ah
	jne check6
	mov al, [portal4_x]
	mov ah, [portal4_y]
	mov [parts_x], al
	mov [parts_y], ah
	jmp finish5
	
check6:
	mov al, [portal4_x]
	mov ah, [portal4_y]
	cmp [parts_x], al
	je check5
	jmp finish5
	
check5:
	cmp [parts_y], ah
	jne finish5
	mov al, [portal3_x]
	mov ah, [portal3_y]
	mov [parts_x], al
	mov [parts_y], ah
	
finish5:
	popa
	ret
endp checkOnPortal1
proc print_score
	pusha
	;sets cursor on the corner
	mov dh, 23 ; row
	mov dl, 35 ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	mov ax, [snakeLen]
	sub ax, 2
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
endp print_score
start:
	mov ax, @data
	mov ds, ax
	
	mov dx, offset instructions
	call printString
	
	call chooseMode
	
doOver:
	mov [secondPortalBuilt], 0
	mov [lost], 0
	mov [quit], 0
	mov [snakeLen], 2
	mov [dir], 'r'
	mov [parts_y], 10
	mov [parts_y+1], 10
	mov [parts_y+2], 10
	mov [parts_x], 6
	mov [parts_x+1], 6
	mov [parts_x+2], 5
	
	;enter graphic mode
	mov ax, 13h
	int 10h
	
	mov [x_cord], 26
	mov [y_cord], 0
	call setCursorePosition
	
	cmp [mode], 'e'
	je easyInstPrint
	cmp [mode], 'm'
	je medInstPrint
	cmp [mode], 'h'
	je hardInstPrint
	

easyInstPrint:
	mov [delayLength], 05h
	mov dx, offset easyInst
	call printString
	jmp continue1
	
medInstPrint:
	mov [delayLength], 04h
	mov dx, offset medInst
	call printString
	jmp continue1

hardInstPrint:
	mov [delayLength], 03h
	mov dx, offset hardInst
	call printString
	jmp continue1
	
continue1:
	mov [x_cord], 0
	mov [y_cord], 0
	call setCursorePosition
	
	;prints the frame
	mov dx, offset frame
	call printString
	
	lea si, [parts_y]
	mov bx, offset parts_x
	
	inc si
	inc bx
	mov al, [si]
	mov [y_cord], al
	mov  al, [bx]
	mov [x_cord], al
	call setCursorePosition
	mov [color], 02h	
	call drawCharacter
	
	inc si 
	inc bx
	mov al, [si]
	mov [y_cord], al
	mov  al, [bx]
	mov [x_cord], al
	call setCursorePosition
	call drawCharacter

printFood1:
	call random
	call random1
	call checkNotOnSnake
	cmp [cant], 1
	je printFood1
	call setTempCursorePosition
	call readScreenChr
	cmp [screenChr], 162
	je printFood1
	mov [color], 0Ch
	mov [charac], 162
	call drawApple
	
	cmp [mode], 'm'
	je powerups1
	cmp [mode], 'h'
	je looper
	
	call readChr
	jmp gameLoop
	
looper:
	mov cx, 3
	
powerups1:
	call random
	call random1
	call setTempCursorePosition
	call readScreenChr
	cmp [screenChr], 042
	je powerups1
	cmp [screenChr], 162
	je powerups1
	call checkNotOnSnake
	cmp [cant], 1
	je powerups1
	mov [charac], 042
	mov [color], 09h
	call drawApple
	cmp [mode], 'm'
	je powerups2
	loop powerups1
	
	mov cx, 3
	
powerups2:
	call random
	call random1
	call setTempCursorePosition
	call readScreenChr
	cmp [screenChr], 042
	je powerups2
	cmp [screenChr], 162
	je powerups2
	cmp [screenChr], 015
	je powerups2
	call checkNotOnSnake
	cmp [cant], 1
	je powerups2
	mov [charac], 015
	mov [color], 0Dh
	call drawApple
	cmp [mode], 'm'
	je powerups
	loop powerups2
	
	mov cx, 3 
	
powerups:
	call random
	call random1
	call setTempCursorePosition
	call readScreenChr
	cmp [screenChr], 042
	je powerups
	cmp [screenChr], 015
	je powerups
	cmp [screenChr], 162
	je powerups
	cmp [screenChr], 232
	je powerups
	call checkNotOnSnake
	cmp [cant], 1
	je powerups
	mov [charac], 232
	mov [color], 0Eh
	call drawApple
	cmp [mode], 'm'
	je continueJump
	loop powerups

portals:
	call random
	call random1
	mov al, [x_temp]
	mov [portal1_x], al
	mov al, [y_temp]
	mov [portal1_y], al
	call setTempCursorePosition
	call readScreenChr
	cmp [screenChr], 042
	je portals
	cmp [screenChr], 232
	je portals
	cmp [screenChr], 015
	je portals
	cmp [screenChr], 162
	je portals
	call checkNotOnSnake
	cmp [cant], 1
	je portals
	mov [charac], 048
	mov [color], 0Bh
	call drawApple
	
helpJump:
	jmp jump 
	
continueJump:
	jmp continue2

jump:
	call random
	call random1
	mov al, [x_temp]
	mov [portal2_x], al
	mov al, [y_temp]
	mov [portal2_y], al
	call setTempCursorePosition
	call readScreenChr
	cmp [screenChr], 042
	je jump
	cmp [screenChr], 232
	je jump
	cmp [screenChr], 015
	je jump
	cmp [screenChr], 162
	je jump
	cmp [screenChr], 048
	je jump
	call checkNotOnSnake
	cmp [cant], 1
	je jump
	mov [charac], 048
	mov [color], 0Bh
	call drawApple
	
continue2:
	call readChr
	
gameLoop:
	cmp [snakeLen], 27
	je wonHelp1
	
	cmp [lost], 1
	je endHelp1
	
	cmp [mode], 'h'
	jne nextJump
	
	mov al, [portal1_x]
	mov [x_temp], al
	mov al, [portal1_y]
	mov [y_temp], al
	call setTempCursorePosition
	mov [color], 0Bh
	mov [charac], 048
	call drawApple
	
	mov al, [portal2_x]
	mov [x_temp], al
	mov al, [portal2_y]
	mov [y_temp], al
	call setTempCursorePosition
	mov [color], 0Bh
	mov [charac], 048
	call drawApple
	
	cmp [secondPortalBuilt], 0
	jne nextJump
	
	cmp [snakeLen], 12
	je portals1
	
	jmp nextJump
	
endHelp1:
	jmp endHelp

wonHelp1:
	jmp wonHelp
	
nextJump:
	jmp next

portals1:
	call random
	call random1
	mov al, [x_temp]
	mov [portal3_x], al
	mov al, [y_temp]
	mov [portal3_y], al
	call setTempCursorePosition
	call readScreenChr
	cmp [screenChr], 042
	je portals1
	cmp [screenChr], 232
	je portals1
	cmp [screenChr], 015
	je portals1
	cmp [screenChr], 162
	je portals1
	cmp [screenChr], 048
	je portals1
	call checkNotOnSnake
	cmp [cant], 1
	je portals1
	mov [charac], 048
	mov [color], 0Bh
	call drawApple

jump1:
	call random
	call random1
	mov al, [x_temp]
	mov [portal4_x], al
	mov al, [y_temp]
	mov [portal4_y], al
	call setTempCursorePosition
	call readScreenChr
	cmp [screenChr], 042
	je jump1
	cmp [screenChr], 232
	je jump1
	cmp [screenChr], 015
	je jump1
	cmp [screenChr], 162
	je jump1
	cmp [screenChr], 048
	je jump1
	call checkNotOnSnake
	cmp [cant], 1
	je jump1
	mov [charac], 048
	mov [color], 0Bh
	call drawApple
	mov [secondPortalBuilt], 1
	
next:
	cmp [snakeLen], 12
	jl next1
	
	mov al, [portal3_x]
	mov [x_temp], al
	mov al, [portal3_y]
	mov [y_temp], al
	call setTempCursorePosition
	mov [color], 0Bh
	mov [charac], 048
	call drawApple
	
	mov al, [portal4_x]
	mov [x_temp], al
	mov al, [portal4_y]
	mov [y_temp], al
	call setTempCursorePosition
	mov [color], 0Bh
	mov [charac], 048
	call drawApple

next1:
	call print_score
	
	; check if there is a character to read
	mov [chr], 0 
	mov ah, 1h
	int 16h
	
	jz noKeyHelp1

	call readChr
	
	cmp ah, 77
	je turnRight
	
	cmp ah, 75
	je turnLeft
	
	cmp ah, 72
	je turnUp
	
	cmp ah, 80
	je turnDownHelp
	
	cmp [chr], 'q'
	je endHelp
	
	jmp noKeyHelp
	
noKeyHelp1:
	jmp noKeyHelp
	
endHelp:
	jmp end_game

wonHelp:
	jmp won

turnRight:
	cmp [dir], 'l'
	je noKeyHelp
	cmp [dir], 'r'
	je noKeyHelp
	cmp [dir], 'u'
	je continue3
	mov [parts_chars], 192
	jmp continue4
	
continue3:
	mov [parts_chars], 218

continue4:
	mov [turned], 1
	mov [dir], 'r'
	jmp noKeyHelp
	
turnDownHelp:
	jmp turnDown
	
turnLeft:
	cmp [dir], 'r'
	je noKeyHelp
	cmp [dir], 'l'
	je noKeyHelp
	cmp [dir], 'd'
	je continue5
	mov [parts_chars], 191
	jmp continue6
	
continue5:
	mov [parts_chars], 217

continue6:
	mov [turned], 1
	mov [dir], 'l'
	jmp noKeyHelp
	
exitHelp:
	jmp exit

noKeyHelp:
	jmp noKey
	
turnUp:
	cmp [dir], 'd'
	je noKey
	cmp [dir], 'u'
	je noKey
	cmp [dir], 'l'
	je continue7
	mov [parts_chars], 217
	jmp continue8
	
continue7:
	mov [parts_chars], 192

continue8:
	mov [turned], 1
	mov [dir], 'u'
	jmp noKey

turnDown:
	cmp [dir], 'u'
	je noKey
	cmp [dir], 'd'
	je noKey
	cmp [dir], 'l'
	je continue9
	mov [parts_chars], 218
	jmp continue10
	
continue9:
	mov [parts_chars], 192

continue10:
	mov [turned], 1
	mov [dir], 'd'
	jmp noKey
	
noKey:
	call calcCords
	call moveTheSnake
	cmp [ate], 1
	je printFood
	cmp [ate1], 1
	je printFood2
	cmp [ate2], 1
	je printFood3Help
	cmp [ate3], 1
	je printFood4Help
	call delay
	jmp gameLoop
	
printFood:
	call random
	call random1
	call checkNotOnSnake
	cmp [cant], 1
	je printFood
	call setTempCursorePosition
	call readScreenChr
	cmp [screenChr], 232
	je printFood
	cmp [screenChr], 042
	je printFood
	cmp [screenChr], 015
	je printFood
	cmp [screenChr], 048
	je printFood
	cmp [screenChr], 162
	je printFood
	mov [color], 0Ch
	mov [charac], 162
	call drawApple
	mov [ate], 0
	call delay
	jmp gameLoop
	
printFood3Help:
	jmp printFood3
	
printFood4Help:
	jmp printFood4
	
printFood2:
	call random
	call random1
	call setTempCursorePosition
	call readScreenChr
	cmp [screenChr], 232
	je printFood2
	cmp [screenChr], 015
	je printFood2
	cmp [screenChr], 162
	je printFood2
	cmp [screenChr], 048
	je printFood2
	cmp [screenChr], 042
	je printFood2
	call checkNotOnSnake
	cmp [cant], 1
	je printFood2
	mov [charac], 042
	mov [color], 09h
	call drawApple
	mov [ate1], 0
	call delay
	jmp gameLoop

printFood3:
	call random
	call random1
	call setTempCursorePosition
	call readScreenChr
	cmp [screenChr], 232
	je printFood3
	cmp [screenChr], 042
	je printFood3
	cmp [screenChr], 162
	je printFood3
	cmp [screenChr], 048
	je printFood3
	cmp [screenChr], 015
	je printFood3
	call checkNotOnSnake
	cmp [cant], 1
	je printFood3
	mov [charac], 015
	mov [color], 0Dh
	call drawApple
	mov [ate2], 0
	call delay
	jmp gameLoop
	
printFood4:
	call random
	call random1
	call setTempCursorePosition
	call readScreenChr
	cmp [screenChr], 042
	je printFood4
	cmp [screenChr], 015
	je printFood4
	cmp [screenChr], 162
	je printFood4
	cmp [screenChr], 048
	je printFood4
	cmp [screenChr], 232
	je printFood4
	call checkNotOnSnake
	cmp [cant], 1
	je printFood4
	mov [charac], 232
	mov [color], 0Eh
	call drawApple
	mov [ate3], 0
	call delay
	jmp gameLoop
	
end_game:
	mov [x_cord], 8
	mov [y_cord], 10
	call setCursorePosition
	mov dx, offset lostStr
	call printString
	
	call readChr
	
	; text mode 80 * 25
	mov ax, 2h
	int 10h
	mov dx, offset lostScreen3
	call printString
	call chooseMode
	cmp [quit], 1
	je exit
	jmp doOver

won:
	; text mode 80 * 25
	mov ax, 2h
	int 10h
	mov dx, offset notLostScreen3
	call printString
	call chooseMode
	cmp [quit], 1
	je exit
	jmp doOver
	
exit:
	mov ax, 4c00h
	int 21h
END start

