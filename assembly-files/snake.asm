IDEAL
MODEL small
STACK 100h
p186

DATASEG

;constants
RIGHT equ 77
LEFT equ 75
UP equ 72 
DOWN equ 80

lost db 0
ate db 0
ate1 db 0
ate2 db 0
ate3 db 0
ate4 db 0
temp db 0
endTime db 0
number2 db 0
timend db 0
canKillBoss db 0
bossDead db 0
portal1_x db 0
portal1_y db 0
portal2_x db 0
portal2_y db 0
portal3_x db 0
portal3_y db 0
portal4_x db 0
portal4_y db 0
head dw 0
charac db 0 
maxNum db 0
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
bossCreated db 0
boss_x db 1
boss_y db 10
check_x db 0
check_y db 0
parts_x db 6, 6, 5, 25 dup (?)
parts_y db 10, 10, 10, 25 dup (?)
color dw 0 
currentNote dw 0
notes dw 3619, 4063, 4560, 3619, 4063, 4560, 3416, 3619, 4063, 4063, 3416, 3619, 4063, 3619, 3416, 3043, 3416, 3619, 4063, 4560, 4560
title1 	dw 0342, 0341, 0340, 0339, 0338, 0337, 0336, 0335, 0415, 0495
		dw 0575, 0655, 0656, 0657, 0658, 0659, 0660, 0661, 0662, 0742
		dw 0822, 0902, 0982, 0981, 0980, 0979, 0978, 0977, 0976, 0975
		dw 0985, 0905, 0825, 0745, 0665, 0585, 0505, 0425, 0345, 0426
		dw 0507, 0587, 0668, 0669, 0750, 0830, 0911, 0992, 0912, 0832
		dw 0752, 0672, 0592, 0512, 0432, 0352, 0995, 0915, 0835, 0755
		dw 0675, 0595, 0515, 0435, 0355, 0356, 0357, 0358, 0359, 0360
		dw 0361, 0362, 0442, 0522, 0602, 0682, 0762, 0842, 0922, 1002
		dw 0676, 0677, 0678, 0679, 0680, 0681, 0365, 0445, 0525, 0605
		dw 0685, 0765, 0845, 0925, 1005, 0372, 0451, 0530, 0609, 0608
		dw 0687, 0686, 0768, 0769, 0850, 0931, 1012, 0382, 0381, 0380
		dw 0379, 0378, 0377, 0376, 0375, 0455, 0535, 0615, 0695, 0775
		dw 0855, 0935, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022
		dw 0696, 0697, 0698, 0699, 0700, 0701, 0702
		
creator db 'M','a','d','e',' ','b','y',' ','G','u','y',' ','M','a','r','g','a','l','i','t'

tryAgainStr db 'Invalid, Try Again',10,13,'$'

lostStr db 'You Lost!',10,13
db 186,'         Loser  ',10,13,'$'

wonStr db 'You Did Not Lost!',10,13
db 186,'         Nice  ',10,13,'$'

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
		 db 25 dup (' '),'portal',10,13
		 db 25 dup (' '),21,' =',10,13
		 db 10,13
		 db 'can eat the boss for 10 seconds',10,13,'$'
		 
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

macro buildObject x, y, character, color
build:
	randomNumber x, 13h
	randomNumber y, 16h
	setCords x, y
	call readScreenChr
	cmp [screenChr], 042
	je build
	cmp [screenChr], 232
	je build
	cmp [screenChr], 015
	je build
	cmp [screenChr], 162
	je build
	cmp [screenChr], 001
	je build
	cmp [screenChr], 002
	je build
	cmp [screenChr], 048
	je build
	cmp [screenChr], 021
	je build
	checkNotOnSnake x, y
	cmp [cant], 1
	je build
	draw character, color
endm buildObject

macro draw character, color1
	movByte charac, character
	movByte color, color1
	call drawCharacter
endm draw

macro onSnake x, y
	movByte check_x, x
	movByte check_y, y
	cmp call checkNotOnSnake, 0
endm onSnake

macro cmpByte memory1, memory2
	mov al, [memory2]
	cmp [memory1], al
endm cmpByte

macro cmpWord memory11, memory21
	mov ax, [memory21]
	cmp [memory11], ax
endm cmpWord

macro randomNumber result, max
	movByte maxNum, max
	call random
	movByte result, temp
endm randomNumber

macro setCords x, y
	mov dh, [y]
	mov dl, [x]
	call setCursorePosition
endm setCords

macro movByte byte1, byte2
	push [word ptr byte2]
	pop [word ptr byte1]
endm movByte

macro movWord word1, word2
	push [word2]
	pop [word1]
endm movWord

macro print string
	mov dx, offset string
	call printString
endm print

;set cursor location
proc setCursorePosition
	pusha
    mov bh, 0       
    mov ah, 2 
    int 10h
	popa
	ret
endp setCursorePosition

proc checkNotOnSnake
	mov [cant], 0
	lea si, [parts_x]
	lea bx, [parts_y]
	mov [counter], 0

checker:
	mov ax, [snakeLen]
	cmp [counter], ax
	je done2
	inc si
	inc bx
	mov al, [x]
	cmp [si], al
	je blocked1
	inc [counter]
	jmp checker
	
blocked1:
	mov al, [y]
	cmp [bx], al
	je cannot
	inc [counter]
	jmp checker
	
cannot:
	mov [cant], 1
	
done2:
	ret 
endp checkNotOnSnake
proc printOpenningScreen
	pusha
	mov di, offset title1 ; sets si to the memory location of title1
	mov [color], 02h
	mov cx, 137 ; number of times to loop
	
titleLoop:
	mov ax, [di] 
	mov bl, 80d
	div bl
	mov [x_cord], ah
	mov [y_cord], al
	setCords x_cord, y_cord
	call drawCharacter
	add di, 2
	call delayString
	loop titleLoop
	mov [x_cord], 27
	mov [y_cord], 17
	lea si, [creator]
	mov cx, 20 
	
creatorLoop:	
	setCords x_cord, y_cord
	;print char
	mov dl, [si]
	mov ah, 2
	int 21h
	inc [x_cord]
	inc si
	call delayString
	loop creatorLoop
	popa
	ret
endp printOpenningScreen

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
	cmp al, 'q'
	je key
	cmp al, '1'
	je key
	cmp al, '2'
	je key
	cmp al, '3'
	je key
	mov [chr], ah
	jmp @@finish
	
key:
	mov [chr], al
	
@@finish:
	popa
	ret 1
endp readChr

;calculates the end time of the game
proc calculate_End_Time
	pusha
	mov [canKillBoss], 1
	mov ah, 2ch
	int 21h
	cmp dh, 50
	jge moveMinute
	add dh, 10
	mov [endTime], dh
	jmp finish11
	
moveMinute:
	sub dh, 49
	mov [endTime], dh
	
finish11:
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
	mov [canKillBoss], 0
timenotend:
	popa
	ret
endp checkEndTime

proc createPortals
	pusha
	buildObject portal1_x, portal1_y, 048, 0Bh
	buildObject portal2_x, portal2_y, 048, 0Bh
	buildObject portal3_x, portal3_y, 048, 0Bh
	buildObject portal4_x, portal4_y, 048, 0Bh
	popa
	ret
endp createPortals

start:
	mov ax, @data
	mov ds, ax 
	

exit:
	mov ax, 4c00h
	int 21h
END start

