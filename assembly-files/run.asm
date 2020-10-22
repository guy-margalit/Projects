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
			 db "good luck and wish you all the best"   ,10,13
			 db "        Liam Hillinger       " ,10,13
			 db'$'

mode  db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~',186, 10,13
	  db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	  db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	  db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'   Ease     Nornal    Hard   ',186, 10,13
	  db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'     E        N         H    ',186, 10,13
	  db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13	 
	  db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'                             ',186, 10,13
	  db ' ',' ',' ',' ', ' ',' ', ' ' , 186,'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~',186, 10,13
	  db '$'

			 
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
x_obstecales db 35,30 dup (?)
x_character db 11
y_character db 17
y_obstecale db 17
delayLength dw 00h
ten db 10
lost db 0
score db 0
jump db 0
rnd db 0
bx_saver dw 0
counter db 0 
obstecaleCount dw 1
max_delay db 06h
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
	mov [delayLength], 02h
	mov [character], 1
	call sound
	mov cx, 3
	
printer:
	mov dl, [y_character]
	mov [y_cord], dl
	mov dl, [x_character]
	mov [x_cord], dl
	call setCursorePosition
	mov [color], 0h
	call drawCharacter
	dec [y_character]
	mov dl, [y_character]
	mov [y_cord], dl
	call setCursorePosition
	mov [color], 0Eh
	call drawCharacter
	call delayObst
	loop printer
	popa 
	ret
	endp jumpUp 
	
	proc jumpDown
	pusha
	mov [delayLength], 02h
	mov [character], 1
	mov cx, 3
	
printer1:
	mov dl, [y_character]
	mov [y_cord], dl
	mov dl, [x_character]
	mov [x_cord], dl
	call setCursorePosition
	mov [color], 0h
	call drawCharacter
	inc [y_character]
	mov dl, [y_character]
	mov [y_cord], dl

continue2:
	call setCursorePosition
	mov [color], 0Eh
	call drawCharacter
	call delayObst
	loop printer1

	mov bx, offset x_obstecales
	mov cx, [obstecaleCount]

checker:
	mov al, [x_character]
	cmp [bx], al
	jne continue3
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
	inc al
	mov [rnd], al
	popa
	ret
endp random

	; increases y_cord by 3 if chr is not ' ' and decreases it by n if it is
	proc calculateCords
	pusha
	
	; change to player place
	mov dl, [x_character]
	mov [x_cord], dl
	call setCursorePosition
	
	mov [color], 0
	mov [character], 1
	call drawCharacter

	call readChr
	
    ; jump
	cmp [chr], ' '
	jne nojump
	cmp [jump], 1
	je go_down
	call jumpUp
	mov [jump], 1
	call delay
	
go_down:
	call jumpDown
	mov [jump], 0
	jmp done
	
nojump:
	;set cursor location
	;draw smiley - ascii 2 at cursor position
	call setCursorePosition
	mov [color], 0Eh
	call drawCharacter
done:
	popa
	ret
endp calculateCords
	
	; mov the obstecale 2 x cords left
proc movObstecale
	pusha 
	mov [delayLength], 00h
	mov [character], 219
	mov bx, offset x_obstecales
	mov cx, [obstecaleCount]
	
drawLoop:
	;go to obstecale place 
	mov dl, [bx]
	mov [x_cord], dl
	mov [y_cord], 17
	call setCursorePosition
	cmp [x_cord], 9
	jne nojump1
	;delete the character
	mov [color], 0 
	call drawCharacter
	mov [bx], 35
	mov al, [bx]
	mov [x_cord], al
	call setCursorePosition
	mov [color], 0Eh
	call drawCharacter
	jmp finish1
	
nojump1:
	mov [color], 0
	call drawCharacter
	dec [bx]
	mov dh, [bx]
	mov [x_cord], dh
	call setCursorePosition
	mov [color], 0Eh
	call drawCharacter
	call delayObst
	
finish1:
	inc bx
	loop drawLoop
	
finish:
	popa
	ret
endp movObstecale
	
proc createObstacle
	pusha 
	cmp [counter], 0
	jne continue5
	call random
	jmp finish2
	
continue5:
	mov al, [counter]
	cmp [rnd], al
	jne addToCounter
	mov bx, offset x_obstecales
	add bx, [obstecaleCount]
	mov [bx], 35
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
	mov dl, [bx]
	cmp [x_character], dl
	jne continue 
	mov al, [y_obstecale]
	cmp [y_character], al
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
	
	;text mode 80 * 25
	mov ax, 2h
	int 10h
	
	mov dx, offset mode
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
	
	; set cursore location
	mov [x_cord], 11
	call setCursorePosition
	
	call drawCharacter
	
	mov [x_cord],35	
	call setCursorePosition
	
	
	mov [character], 219
	
	call drawCharacter
		
	call readChr
	
	mov [score], 0
	
mainGameLoop:	
	call print_score
	
	; change to player place
	mov dl, [x_character]
	mov [x_cord], dl
	mov dl, [y_character]
	mov [y_cord], dl
	call setCursorePosition
	mov [color], 0Eh
	mov [character], 1
	call drawCharacter
	
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
	cmp [chr], ' '
	jne noKey
	cmp [jump], 2
	je go_down2
	call jumpUp
	mov [jump], 1
	jmp continue1
	
noKey:
	cmp [jump], 1
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


