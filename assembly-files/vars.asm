;all my variables in a seperate file 
;directions scan codes
RIGHT equ 77
LEFT equ 75
UP equ 72 
DOWN equ 80

;colors in hex
YELLOW equ 0Eh
BLACK equ 0h
WHITE equ 0Fh
GREEN equ 02h
RED equ 04h
LIGHT_RED equ 0Ch
LIGHT_BLUE equ 0Bh

;picture printing variables
pic db 0
picDir db 1
wonPic db 'winner.bmp',0
lostPic db 'loser.bmp',0
pic1 db 'picture1.bmp',0
pic2 db 'picture2.bmp',0
pic3 db 'picture3.bmp',0
pic4 db 'snakepic.bmp',0
pic5 db 'picture.bmp',0
blackpic db 'black.bmp',0
snakeFrame db 'inst.bmp',0
filehandle dw ?
Header db 54 dup (0)
Palette db 256*4 dup (0)
ScrLine db 320 dup (0)
ErrorMsg db 'Error', 13, 10,'$'
; x and y ccordinates of image
x_coord dw 200
y_coord dw 200
image_height dw 75
image_width	dw 120
diff dw ?
	
;general variables
lost db 0 ;keep 1 if you've lost or 0 if you haven't 
temp db 0 ;keeps the random number
endTime db 0 ;keeps the end time of eat the boss
canKillBoss db 0 ;keep 1 if you can kill the boss or 0 if you can't
bossDead db 0 ;keep 1 if the boss lost or 0 if he hasn't 
portal1_x db 0 ;keeps the portal's (1) x_cord 
portal1_y db 0 ;keeps the portal's (1) y_cord 
portal2_x db 0 ;keeps the portal's (2) x_cord 
portal2_y db 0 ;keeps the portal's (2) y_cord 
portal3_x db 0 ;keeps the portal's (3) x_cord 
portal3_y db 0 ;keeps the portal's (3) y_cord 
portal4_x db 0 ;keeps the portal's (4) x_cord 
portal4_y db 0 ;keeps the portal's (4) y_cord 
head dw 0 ;keeps the locaation of the snake's head in the array
charac db 0 ;keeps the ascii code of the character that will be printed
quit db 0 ;keep 1 if you've asked to quit or 0 if you haven't 
mode db 'e' ;keeps the first letter of the selected mode
cant db 0 ;keep 1 if the snake is blocked  or 0 if you aren't  
counter dw 0 ;keeps an index when going through a loop
snakeLen dw 2 ;keeps the length of the snake
screenChr db 0 ;keeps the char the was read from the screen
bx_saver dw 0 ;keeps bx in the random macro 
dir db 'r' ;kepps the direction of the snake
ten db 10 ;keeps the number 10 to be used in the print number macro 
x_cord db 5 ;keeps the x_cord to set the cursore postion
y_cord db 10 ;keeps the y_cord to set the cursore postion
x_temp db 15 ;keeps the x_temp to be used in checking 
y_temp db 10 ;keeps the y_temp to be used in checking 
delayLength dw 03h ;keeps the length of the delay
chr db 0 ;keeps the char that the user enters
bossCreated db 0 ;keeps 1 if the boss was created or 0 if he wasn't
boss_x db 1 ;keeps the boss's x_cord
boss_y db 10 ;keeps the boss's y_cord
parts_x db 6, 6, 5, 25 dup (?) ;keeps the x_cord of all the snake's parts
parts_y db 10, 10, 10, 25 dup (?) ;keeps the y_cord of all the snake's parts
color dw 0 ;keeps the color before drawing a character
currentNote dw 0 ;the index of the current note in the notes array
notes dw 3619, 4063, 4560, 3619, 4063, 4560, 3416, 3619, 4063, 4063
	  dw 3416, 3619, 4063, 3619, 3416, 3043, 3416, 3619, 4063, 4560, 4560 ;keeps all the notes 
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
		dw 0696, 0697, 0698, 0699, 0700, 0701, 0702 ;keeps all the locations for the title 'SNAKE'
		
;strings
creator db 'M','a','d','e',' ','b','y',' ','G','u','y',' ','M','a','r','g','a','l','i','t' ;the made by string cut to chars in order to print it with delay

lostStr db 'You Lost!',10,13
db 186,'               Loser  ',10,13,'$' ;the lose string

wonStr db 'You Did Not Lose!',10,13
db 186,'             Nice  ',10,13,'$' ;the win string
			 
easyInst db 'Easy Mode',10,13
		 db 10,13
		 db 'Use the arrows',10,13
		 db 10,13
		 db 'Do not touch yourself or the borders',10,13
		 db 10,13
		 db 'Reach 25 points to win',10,13
		 db 10,13
		 db 162,' = ','increase length',10,13,'$' ;the easy mode instructions
		 
medInst db 'Medium Mode',10,13
		 db 10,13
		 db 'Use the arrows',10,13
		 db 10,13
		 db 'Do not touch yourself or the borders',10,13
		 db 10,13
		 db 'Reach 25 points to win',10,13
		 db 10,13
		 db 162,' = ','increase length',10,13
		 db 10,13
		 db 232,' = ','decrease length',10,13
		 db 10,13
		 db 042,' = ','increase speed',10,13
		 db 10,13
		 db 015,' = ','decrease speed',10,13,'$' ;the medium mode instructions
		 
hardInst db 'Hard Mode',10,13
		 db 10,13
		 db 'Use the arrows',10,13
		 db 10,13
		 db 'Do not touch yourself or the borders',10,13
		 db 10,13
		 db 'Reach 25 points to win',10,13
		 db 10,13
		 db 162,' = ','increase length',10,13
		 db 10,13
		 db 232,' = ','decrease length',10,13
		 db 10,13
		 db 042,' = ','increase speed',10,13
		 db 10,13
		 db 015,' = ','decrease speed',10,13
		 db 10,13
		 db 048,' = ','portal',10,13
		 db 10,13
		 db 21,' = ','can eat the boss',10,13 
		 db 4 dup (' '),'for 10 seconds',10,13,'$' ;the hard mode instructions
		 
frame db 201,37 dup (205),187,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 186,37 dup (' '),186,10,13
	  db 200,37 dup (205),188,10,13,'$' ;the frame string