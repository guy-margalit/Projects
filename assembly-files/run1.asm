IDEAL
MODEL small
STACK 100h
jumps
p186
DATASEG
; --------------------------
msg db 7 dup (' '),201,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205, 205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,187,    10,13
	db 7 dup (' '),186, 				 '                 ________ ________                            '             ,186,10,13                            
	db 7 dup (' '),186,                  '               /   \  ___  /   |   \                          '             ,186,10,13                            
	db 7 dup (' '),186, 				 '               \    \_\  \/    |    \                         '             ,186,10,13                              
	db 7 dup (' '),186, 		       	 '                \______  /\_______  /                         '             ,186,10,13                       
	db 7 dup (' '),186,					 '                       \/         \/                          '             ,186,10,13                      
	db 7 dup (' '),186,					 '________________    _________________________________________ '             ,186,10,13 
	db 7 dup (' '),186,					 '\_   _____/  _  \  /   _____/\__    ___/\_   _____/\______   /'             ,186,10,13 
	db 7 dup (' '),186, 				 '|    __)/  /_\  \ \_____  \   |    |    |    __)_  |       _/ '             ,186,10,13 
	db 7 dup (' '),186, 				 '|     \/    |    \/        \  |    |    |        \ |    |   \ '             ,186,10,13 
	db 7 dup (' '),186, 				 '\___  /\____|__  /_______  /  |____|   /_______  / |____|_  / '             ,186,10,13 
	db 7 dup (' '),186, 				 '    \/         \/        \/                    \/         \/  '             ,186,10,13 
	db 7 dup (' '),186,					 '                                                              '             ,186,10,13
	db 7 dup (' '),186,					 '                                                              '             ,186,10,13
	db 7 dup (' '),186,					 '                                                              '             ,186,10,13
	db 7 dup (' '),186,					 '                     made by Liam Hillinger                   '             ,186,10,13 
	db 7 dup (' '),200,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,188,   10,13
	db '$' 
	
instructions db "welcome to run faster ,the best runing game on earth." ,10,13
			 db "you will run and jump above obstecales. "  ,10,13
			 db "to jump above press twice on the space botton"     ,10,13
			 db "if you want to quit press 'q'."   ,10,13
			 db "press 'f' to split the fire", 10,13
			 db "good luck and wish you all the best"   ,10,13
			 db "        Liam Hillinger       " ,10,13
			 db'$'

			 
game db ' ',' ',' ',' ', ' ',' ', ' ' , 201,'=============================',187, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13 
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 200,'=============================',188, 10,13
	 db '$'
	 
lose db ' ',' ',' ',' ', ' ',' ', ' ' , 201, 203, 203,203,203,203, 203,203, 203,203,203,203, 203, 203,203, 203, 203,203,203,203, 203, 203,203,203,203, 203, 203,203,203,203, 203, 203,203,203,203, 203, 203,203,203,203,203, 203, 203,203, 203, 203,203,203,203,203, 203,203,203, 203, 203,203,203,203,203, 203,187  , 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 204,'                                                           ' , 185 , 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 204,'                                                           ' , 185 , 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 204,'     ''                        .__                     __   '         , 185 , 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 204,'     '' ___.__.  ____   __ __  |  |    ____    _______/  |_ '         , 185 , 10,13
	db ' ',' ',' ',' ', ' ',' ', ' ' ,  204,'     ''<   |  | /  _ \ |  |  \ |  |   /  _ \  /  ___/\   __\'         , 185 , 10,13
	db ' ',' ',' ',' ', ' ',' ', ' ' ,  204,'      ''/ ____| \____/ |____/  |____/ \____/ /____  > |__|  '           , 185 , 10,13
	db ' ',' ',' ',' ', ' ',' ', ' ' ,  204,'      ''\/                                        \/        '           , 185 , 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 204,'                                                           ', 185 , 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 204,'                                                           ', 185 , 10,13
	 db ' ',' ',' ',' ', ' ',' ', ' ' , 200, 202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202, 202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,202,188  , 10,13
	 db '$'
x_cord db 0; column
y_cord db 17 ; row
color dw 0Eh ; color 
first_turn db 0 
cx_keeper dw 10 ; variable to keep cx in loop
chr db '!' 
obstecale db 219 ; the obstecale
character db 1
counter1 db 0
obstecaleCount1 dw 1
deadOrAlive1 db 31 dup (0)
x_obstecales1 db 30,30 dup (?)
y_obstecales1 db 16
deadOrAlive db 31 dup (0)
x_obstecales db 35,30 dup (?)
x_character db 11
y_character db 17
y_obstecale db 17
delayLength dw 00h
x_coordinate dw 91
y_coordinate dw 130
x_coordinate_start dw 91
y_coordinate_start dw 130
ten db 10
lost db 0
endTime db 0
score db 0
jump db 0
rnd db 0
rnd1 db 0
legUp db 0
bx_saver dw 0
fired db 0
counter db 0 
obstecaleCount dw 1
max_delay db 09h
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

	; set the cursor position
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
	
	;delay the character
	proc delay
	pusha
	mov cx, 05h ;High Word
	mov dx, 0d40h ;Low Word
	mov al, 0
	mov ah, 86h ;Wait
	int 15h
	popa
	ret
	endp delay
	;delay the obstecale
	proc delayObst
	pusha
	mov cx, [delayLength] ;High Word
	mov dx, 0d40h ;Low Word
	mov al, 0
	mov ah, 86h ;Wait
	int 15h
	popa
	ret
	endp delayObst
	
	proc jumpUp
	pusha
	mov [delayLength], 01h
	call sound
	mov cx, 3
	
printer:
	mov [color], 0h
	call drawDinosour
	mov [legUp], 0
	sub [y_coordinate_start], 8
	mov [color], 0Fh
	call drawDinosour
	call delayObst
	loop printer
	popa 
	ret
	endp jumpUp 
	
	proc jumpDown
	pusha
	mov [delayLength], 01h
	call sound
	mov cx, 3
	
printer1:
	mov [color], 0h
	call drawDinosour
	add [y_coordinate_start], 8
	mov [color], 0Fh
	call drawDinosour
	call delayObst
	loop printer1

	mov bx, offset x_obstecales
	mov cx, [obstecaleCount]

checker:
	cmp [byte ptr bx], 11
	jl continue3
	cmp [byte ptr bx], 13
	jg continue3
	mov [lost],1
	
continue3:
	inc bx
	loop checker
	popa 
	ret
	endp jumpDown 
	
;generates a random number and keeps it in rnd
proc random
	pusha
	mov bx, [bx_saver]
	; put segment number in register es
	mov ax, 40h
	mov es, ax
	; move random number to ax
	mov ax, [es:6Ch]
	xor ax, [bx]
	add [bx_saver], ax
	and al, [max_delay]
	add al, 6
	mov [rnd], al
	popa
	ret
endp random
;generates a random number and keeps it in rnd1
proc random1
	pusha
	mov bx, [bx_saver]
	; put segment number in register es
	mov ax, 40h
	mov es, ax
	; move random number to ax
	mov ax, [es:6Ch]
	xor ax, [bx]
	add [bx_saver], ax
	and al, [max_delay]
	add al, 6
	mov [rnd1], al
	popa
	ret
endp random1
proc draw_p
	pusha
	xor bh, bh ; bh = 0
	mov cx, [x_coordinate]
	mov dx, [y_coordinate]
	mov ax, [color]
	mov ah, 0ch
	int 10h
	popa
	ret
endp draw_p
proc drawDinosour
	pusha
	mov ax, [y_coordinate_start]
	mov [y_coordinate], ax
	mov ax, [x_coordinate_start]
	mov [x_coordinate], ax
	call draw_p
	mov cx, 3
loop1:
	inc [y_coordinate]
	call draw_p
	loop loop1
	inc [x_coordinate]
	call draw_p
	mov cx, 3
loop2:
	inc [y_coordinate]
	call draw_p
	loop loop2
	inc [x_coordinate]
	call draw_p
	inc [y_coordinate]
	call draw_p
	inc [x_coordinate]
	add [y_coordinate], 4
	call draw_p
	mov cx, 8
loop4:
	dec [y_coordinate]
	call draw_p
	loop loop4
	inc [x_coordinate]
	sub [y_coordinate], 3
	call draw_p
	mov cx, 11
loop3:
	inc [y_coordinate]
	call draw_p
	loop loop3
	inc [x_coordinate]
	cmp [legUp], 1
	jne continue12
	add [y_coordinate], 2
	jmp continue13
continue12:
	add [y_coordinate], 3
continue13:
	inc [x_coordinate]
	call draw_p
	dec [x_coordinate]
	call draw_p
	cmp [legUp], 1
	jne continue8
	mov cx, 16
	jmp loop5
continue8:
	mov cx, 17
loop5:
	dec [y_coordinate]
	call draw_p
	loop loop5
	inc [x_coordinate]
	call draw_p
	mov cx, 14
loop6:
	inc [y_coordinate]
	call draw_p
	loop loop6
	inc [x_coordinate]
	call draw_p
	mov cx, 12
loop7:
	dec [y_coordinate]
	call draw_p
	loop loop7
	sub [y_coordinate], 2
	call draw_p
	inc [x_coordinate]
	call draw_p
	cmp [legUp], 2
	jne continue6
	mov cx, 16
	jmp loop8
continue6:
	mov cx, 17
loop8:
	inc [y_coordinate]
	call draw_p
	loop loop8
	inc [x_coordinate]
	call draw_p
	cmp [legUp], 2
	jne continue14
	sub [y_coordinate], 2
	jmp continue15
continue14:
	sub [y_coordinate], 3
continue15:
	call draw_p
	mov cx, 14
loop9:
	dec [y_coordinate]
	call draw_p
	loop loop9
	inc [x_coordinate]
	inc [y_coordinate]
	call draw_p
	inc [y_coordinate]
	call draw_p
	inc [y_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	add [y_coordinate], 5
	call draw_p
	dec [x_coordinate]
	call draw_p
	add [y_coordinate], 4
	call draw_p
	inc [x_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	inc [y_coordinate]
	call draw_p
	cmp [fired], 1
	jne continue16
	cmp [color], 0h
	je delete1
	call drawFire
	jmp continue16
	
delete1:
	call deleteFire
	
continue16:
	popa
	ret
endp drawDinosour
	; mov the obstecale 2 x cords left
proc movObstecale1
	pusha 
	mov [delayLength], 00h
	mov [character], 224
	mov [color], 0Eh
	mov si, offset deadOrAlive1
	mov bx, offset x_obstecales1
	mov cx, [obstecaleCount1]
	
drawLoop1:
	cmp [byte ptr si], 0
	jne finish11
	;go to obstecale place 
	mov dl, [bx]
	mov [x_cord], dl
	mov [y_cord], 16
	call setCursorePosition
	cmp [fired], 1
	jne continue19
	cmp [x_cord], 13
	jne continue19
	jmp kill
	
continue19:
	cmp [x_cord], 9
	jne nojump11

kill:
	;delete the character
	mov [color], 0h 
	call drawCharacter
	mov [byte ptr si], 1
	jmp finish11
	
nojump11:
	mov [color], 0h
	call drawCharacter
	dec [byte ptr bx]
	mov dh, [bx]
	cmp [y_coordinate_start], 146
	je continue101
	
	cmp dh, 11
	jl continue101
	cmp dh, 12
	jg continue101
	mov [lost], 1
	jmp finish111
	
continue101:
	mov [x_cord], dh
	call setCursorePosition
	mov [color], 0Eh
	call drawCharacter
	call delayObst
	
finish11:
	inc si
	inc bx
	loop drawLoop1
	
finish111:
	popa
	ret
endp movObstecale1
	; mov the obstecale 2 x cords left
proc movObstecale
	pusha 
	mov [delayLength], 00h
	mov [character], 219
	mov [color], 0Eh
	mov si, offset deadOrAlive
	mov bx, offset x_obstecales
	mov cx, [obstecaleCount]
	
drawLoop:
	cmp [byte ptr si], 0
	jne finish1
	;go to obstecale place 
	mov dl, [bx]
	mov [x_cord], dl
	mov [y_cord], 17
	call setCursorePosition
	cmp [x_cord], 9
	jne nojump1
	;delete the character
	mov [color], 0h 
	call drawCharacter
	mov [byte ptr si], 1
	jmp finish1
	
nojump1:
	mov [color], 0h
	call drawCharacter
	dec [byte ptr bx]
	mov dh, [bx]
	cmp [y_coordinate_start], 130
	jne continue10
	
	cmp dh, 11
	jl continue10
	cmp dh, 12
	jg continue10
	mov [lost], 1
	jmp finish1
	
continue10:
	mov [x_cord], dh
	call setCursorePosition
	mov [color], 0Eh
	call drawCharacter
	call delayObst
	
finish1:
	inc si
	inc bx
	loop drawLoop
	
finish:
	popa
	ret
endp movObstecale
;calculates the end time of the game
proc calculate_End_Time
	pusha
	mov [fired], 1
	mov ah, 2ch
	int 21h
	cmp dh, 57
	jge moveMinute
	add dh, 3
	mov [endTime], dh
	jmp finish112
	
moveMinute:
	sub dh, 56
	mov [endTime], dh
	
finish112:
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
	call deleteFire
	mov [fired], 0
timenotend:
	popa
	ret
endp checkEndTime
proc drawFire
	pusha
	mov ax, [y_coordinate_start]
	mov [y_coordinate], ax
	mov ax, [x_coordinate_start]
	mov [x_coordinate], ax
	inc [y_coordinate]
	add [x_coordinate], 10
	mov [color], 0Eh
	call draw_p
	inc [y_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	inc [y_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	mov [color], 0Ch
	dec [x_coordinate]
	dec [y_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	add [y_coordinate], 7
	call draw_p
	dec [y_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	inc [x_coordinate]
	add [y_coordinate], 2
	call draw_p
	dec [y_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	sub [y_coordinate], 3
	call draw_p
	dec [y_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	mov cx, 7
	
printer2:
	inc [y_coordinate]
	call draw_p
	loop printer2
	inc [x_coordinate]
	call draw_p
	mov cx, 7
	
printer3:
	dec [y_coordinate]
	call draw_p
	loop printer3
	inc [x_coordinate]
	call draw_p
	mov cx, 7
	
printer4:
	inc [y_coordinate]
	call draw_p
	loop printer4
	inc [x_coordinate]
	dec [y_coordinate]
	call draw_p
	mov cx, 5
	
printer5:
	dec [y_coordinate]
	call draw_p
	loop printer5
	inc [x_coordinate]
	inc [y_coordinate]
	call draw_p
	mov cx, 3
	
printer6:
	inc [y_coordinate]
	call draw_p
	loop printer6
	inc [x_coordinate]
	dec [y_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	mov [color], 0Eh
	sub [x_coordinate], 5
	call draw_p
	inc [y_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	popa
	ret
endp drawFire
proc deleteFire
	pusha
	mov ax, [y_coordinate_start]
	mov [y_coordinate], ax
	mov ax, [x_coordinate_start]
	mov [x_coordinate], ax
	inc [y_coordinate]
	add [x_coordinate], 10
	mov [color], 0h
	call draw_p
	inc [y_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	inc [y_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	mov [color], 0h
	dec [x_coordinate]
	dec [y_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	add [y_coordinate], 7
	call draw_p
	dec [y_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	inc [x_coordinate]
	add [y_coordinate], 2
	call draw_p
	dec [y_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	sub [y_coordinate], 3
	call draw_p
	dec [y_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	mov cx, 7
	
printer21:
	inc [y_coordinate]
	call draw_p
	loop printer21
	inc [x_coordinate]
	call draw_p
	mov cx, 7
	
printer31:
	dec [y_coordinate]
	call draw_p
	loop printer31
	inc [x_coordinate]
	call draw_p
	mov cx, 7
	
printer41:
	inc [y_coordinate]
	call draw_p
	loop printer41
	inc [x_coordinate]
	dec [y_coordinate]
	call draw_p
	mov cx, 5
	
printer51:
	dec [y_coordinate]
	call draw_p
	loop printer51
	inc [x_coordinate]
	inc [y_coordinate]
	call draw_p
	mov cx, 3
	
printer61:
	inc [y_coordinate]
	call draw_p
	loop printer61
	inc [x_coordinate]
	dec [y_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	mov [color], 0h
	sub [x_coordinate], 5
	call draw_p
	inc [y_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	popa
	ret
endp deleteFire
proc createObstacle1
	pusha 
	cmp [counter1], 0
	jne continue51
	call random1
	jmp addToCounter1
	
continue51:
	mov al, [counter1]
	cmp [rnd1], al
	jne addToCounter1
	mov bx, offset x_obstecales1
	add bx, [obstecaleCount1]
	mov [byte ptr bx], 35
	inc [obstecaleCount1]
	mov [counter1], 0
	jmp finish21
	
addToCounter1:
	inc [counter1]
	
finish21:
	popa
	ret
endp createObstacle1
proc createObstacle
	pusha 
	cmp [counter], 0
	jne continue5
	call random
	jmp addToCounter
	
continue5:
	mov al, [counter]
	cmp [rnd], al
	jne addToCounter
	mov bx, offset x_obstecales
	add bx, [obstecaleCount]
	mov [byte ptr bx], 35
	inc [obstecaleCount]
	mov [counter], 0
	jmp finish2
	
addToCounter:
	inc [counter]
	
finish2:
	popa
	ret
endp createObstacle
	
	;sound while jump
	proc sound
	pusha
	mov     al, 182         ; Prepare the speaker for the
        out     43h, al         ;  note.
        mov     ax, 1207        ; Frequency number (in decimal)
                                ;  for middle C.
        out     42h, al         ; Output low byte.
        mov     al, ah          ; Output high byte.
        out     42h, al 
        in      al, 61h         ; Turn on note (get value from
                                ;  port 61h).
        or      al, 00000011b   ; Set bits 1 and 0.
        out     61h, al         ; Send new value.
        mov     bx, 25          ; Pause for duration of note.
pause1:
        mov     cx, 65535
pause2:
        dec     cx
        jne     pause2
        dec     bx
        jne     pause1
		
		
        in      al, 61h         ; Turn off note (get value from
                                ;  port 61h).
        and     al, 11111100b   ; Reset bits 1 and 0.
        out     61h, al         ; Send new value.
	popa
	ret
	endp sound

	proc checkScrnChr
	pusha
	mov bx, offset x_obstecales
	mov cx, [obstecaleCount]
	
checkLoop:
	cmp [byte ptr bx], 13
	jne continue 
	cmp [y_coordinate], 130 
	jne continue
	mov [lost], 1
	
continue:
	inc bx 
	loop checkLoop
	popa
	ret
	endp checkScrnChr

;prints a number in decimal
proc print_score
	pusha
	;sets cursor on the corner
	mov dh, 19 ; row
	mov dl, 35 ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	mov al, [score]
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
endp print_score
	
start:
	mov ax, @data
	mov ds, ax
; --------------------------

	;text mode 80 * 25
	mov ax, 2h
	int 10h
	
	mov dx, offset msg
	
	call printString

	call readChr
	
	;text mode 80 * 25
	mov ax, 2h
	int 10h
	
	mov dx, offset instructions
	call printString
	
	call readChr
	
	; clear screen by entering graphic mode 40*25
	mov ax, 13h
	int 10h 
	
	mov dx, offset game
	call printString
	
	call readChr
	
	; check if user asks to quit
	cmp [chr], 'q'
	je end_game
	
	mov [color], 0Fh
	call drawDinosour
	mov [legUp], 2
	
	call readChr
	
	mov [score], 0
	
mainGameLoop:	
	cmp [fired], 0
	je continue18
	call checkEndTime
	
continue18:
	call createObstacle1
	call createObstacle
	call print_score
	
	;check if there is a charcter to read
	mov [chr], 0
	mov ah, 1h
	int 16h
	
	jz noKey
	
	call readChr
	
	;jump
	;check if user asks to quit
	cmp [chr], 'q'
	je end_game 
	cmp [chr], 'f'
	jne continue17
	cmp [fired], 1
	je continue17
	call calculate_End_Time
	
continue17:
	cmp [chr], ' '
	jne noKey
	cmp [jump], 3
	je go_down2
	cmp [jump], 0
	jne noKey
	call jumpUp
	mov [jump], 1
	jmp continue1
	
noKey:
	cmp [jump], 1
	je nextJump
	cmp [jump], 2
	je nextJump
	cmp [jump], 0
	je continue1
	
go_down2:
	call jumpDown
	cmp [lost], 1
	je end_game
	mov [jump], 0
	jmp continue1
	
nextJump:
	inc [jump]
	
continue1:
	mov [color], 0h
	call drawDinosour
	cmp [y_coordinate_start], 130
	jne continue11
	cmp [legUp], 1
	jne leg1
	mov [legUp], 2
	jmp continue11
	
leg1:
	mov [legUp], 1
	
continue11:
	mov [color], 0Fh
	call drawDinosour
	
	call movObstecale1
	
	call movObstecale
	
	call delay
	
	call checkScrnChr
	
	cmp [lost], 1
	je end_game
	
	inc [score]
	
	jmp mainGameLoop
	
	
	
end_game: 
	
	 ;text mode 80 * 25
	mov ax, 2h
	int 10h
	mov dx, offset lose
	
	call printString
	
	call readChr
	
	 ;text mode 80 * 25
	mov ax, 2h
	int 10h
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
END start


