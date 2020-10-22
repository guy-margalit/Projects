IDEAL
MODEL small
STACK 100h
p186
DATASEG
; --------------------------
openingScreen db '                 ',10,13 
 db ' _   _                             _ ',10,13          
 db '| | | |                           | | ',10,13 
 db '| |_| |__   ___    ___ _ __   __ _| | ',10,13
 db '| __| "_ \ / _ \  / __| "_ \ / _` | |/ / _ \ ',10,13  
 db '| |_| | | |  __/  \__ \ | | | (_| |   <  __/ ',10,13
 db ' \__|_| |_|\___|  |___/_| |_|\__,_|_|\_\___| ',10,13,'$'
student db '                                       ',10,13
 db ' by ariel gal ',10,13,'$'
 explan db '                                      ',10,13 
 db ' press s to start the game,i to read the instructions',10,13
 db ' and q to leave the game ',10,13,'$' 
 frame db '                                                   ',10,13
  db 201,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,187,10,13 
  db 186,'                                 ',186,10,13                                                                                             
  db 186,'                                 ',186,10,13
  db 186,'                                 ',186,10,13
  db 186,'                                 ',186,10,13
  db 186,'                                 ',186,10,13
  db 186,'                                 ',186,10,13 
  db 186,'                                 ',186,10,13
  db 186,'                                 ',186,10,13
  db 186,'                                 ',186,10,13 
  db 186,'                                 ',186,10,13                                                                                             
  db 186,'                                 ',186,10,13
  db 186,'                                 ',186,10,13
  db 186,'                                 ',186,10,13
  db 186,'                                 ',186,10,13
  db 186,'                                 ',186,10,13 
  db 186,'                                 ',186,10,13
  db 186,'                                 ',186,10,13
  db 186,'                                 ',186,10,13 
  db 200,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,188,10,13,'$' 
color dw 15;white color 
char db ' '  
x_cord db 0;colum
y_cord db 0;row 
direction db 'r'
lost db 0
cant db 0
bx_saver dw 0
counter dw 0
screenChr db 0
x_temp db 0
y_temp db 0
ate db 0
ten db 10
snake_x db 7,6,5,30 dup (?)
snake_y db 10,10,10,30 dup (?)
snake_lengh dw 2
; --------------------------
CODESEG
;proc that print string 
proc printString 
	pusha 
	mov ah, 9h
	int 21h ;interrupt that displays a string
	popa
	ret
endp printString
; reads a character into chr
proc readChar
	pusha
	; waits for character
	mov ah, 0h
	int 16h
	mov [char], al ; save character to [char]
	popa
	ret
endp readChar
proc setCursorelocation 
	pusha
; set cursore location
	mov dh, [y_cord]; row
	mov dl, [x_cord] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret
endp setCursorelocation
proc setTempCursorelocation 
	pusha
; set cursore location
	mov dh, [y_temp]; row
	mov dl, [x_temp] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret
endp setTempCursorelocation
proc drawCharacter
	pusha
	; draw snake - ascii 219 at cursor position
	mov ah, 9
	mov al, 219 ; al = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
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
	mov [screenChr], al
	popa
	ret
endp readScreenChr 
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
proc move_snake 
	pusha 
	mov al, [snake_x]
	mov [x_cord], al
	mov al, [snake_y]
	mov [y_cord], al
	call setCursorelocation
	call readScreenChr
	cmp [screenChr], 186
	je finish2
	cmp [screenChr], 219
	je finish2
	cmp [screenChr], 205
	je finish2
	cmp [screenChr], 235
	jne continue
	inc [snake_lengh]
	mov [ate], 1
	
continue:
	mov si,offset snake_x
	mov bx, offset snake_y
	mov cx, [snake_lengh]
	inc bx 
	inc si
	
delete:
	mov al, [si]
	mov [x_cord] ,al 
	mov al, [bx]
	mov [y_cord],al
	call setCursorelocation
	mov [color],0h 
	call drawCharacter
	inc bx 
	inc si
	loop delete	
	
	mov si, offset snake_x
	mov bx, offset snake_y
	mov cx, [snake_lengh]
	add si, [snake_lengh]
	add bx, [snake_lengh]

printer:
	mov al, [si-1]
	mov [x_cord], al
	mov [byte ptr si], al
	mov al, [bx-1]
	mov [y_cord], al
	mov [byte ptr bx], al
	call setCursorelocation
	call readScreenChr
	mov [color], 0fh
	call drawCharacter
	dec si
	dec bx
	loop printer
	jmp finish1
	
finish2:
	mov [lost], 1
	
finish1:
	popa 
	ret 
endp move_snake
proc calcCords
	pusha
	cmp [direction], 'r'
	je moveRight
	cmp [direction], 'l'
	je moveLeft
	cmp [direction], 'u'
	je moveUp
	lea si, [snake_y]
	inc [byte ptr si]
	jmp finish
	
moveRight:
	lea si, [snake_x]
	inc [byte ptr si]
	jmp finish
	
moveLeft:
	lea si, [snake_x]
	dec [byte ptr si]
	jmp finish
	
moveUp:
	lea si, [snake_y]
	dec [byte ptr si]
	jmp finish
	
finish:
	popa
	ret
endp calcCords
;generates a random number and keeps it in y_temp
proc random_y
	pusha
	mov bx, [bx_saver]
	; put segment number in register es 
	mov ax, 40h
	mov es, ax
	; move random number to ax
	mov ax, [es:6Ch]
	xor ax,[bx]
	add [bx_saver],ax
	and al, 11h
	add al, 3
	mov [y_temp], al
	popa
	ret
endp random_y
;generates a random number and keeps it in x_temp
proc random_x
	pusha
	mov bx, [bx_saver]
	; put segment number in register es
	mov ax, 40h
	mov es, ax
	; move random number to ax
	mov ax, [es:6Ch]
	xor ax,[bx]
	add [bx_saver],ax
	and al, 1Eh
	add al, 2
	mov [x_temp], al
	popa
	ret
endp random_x
proc checkNotOnSnake
	pusha
	mov [cant], 0
	mov si, offset snake_x
	mov bx, offset snake_y
	mov [counter], 0

checker:
	mov ax, [snake_lengh]
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
proc drawApple
	pusha
print:
	call random_x
	call random_y
	call setTempCursorelocation
	mov ah, 9
	mov al, 235 ; al = character to display
	mov bx, 04h ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	call checkNotOnSnake
	cmp [cant], 1
	je print
	popa
	ret
endp drawApple
proc print_score
	pusha
	;sets cursor on the corner
	mov dh, 24 ; row
	mov dl, 35 ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	mov ax, [snake_lengh]
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
; --------------------------
	mov dx, offset openingScreen ;printing the opening screen string
	call printString
;printing the name 
	mov dx, offset student
	call printString 
;printing the explan
	mov dx, offset explan 
	call printString 
; waits for charcter 
	call readChar
; clear screen by entering graphic mode 40*25
	mov ax, 13h
	int 10h
;print the game screen
	mov dx, offset frame 
	call printString
	call move_snake
	call drawApple
	call readChar
	
maingameloop:
	call print_score
	
	cmp [lost], 1
	je end1Help
	
	; check if there is a character to read
	mov [char], 0 
	mov ah, 1h
	int 16h
	
	jz noKey

	call readChar
	
	cmp ah, 77
	je turnRight
	
	cmp ah, 75
	je turnLeft
	
	cmp ah, 72
	je turnUp
	
	cmp ah, 80
	je turnDown
	
	cmp [char], 'q'
	je end1
	
	jmp noKey
	
end1Help:
	jmp end1
	
turnRight:
	cmp [direction], 'l'
	je noKey
	cmp [direction], 'r'
	je noKey
	mov [direction], 'r'
	jmp noKey
	
turnLeft:
	cmp [direction], 'r'
	je noKey
	cmp [direction], 'l'
	je noKey
	mov [direction], 'l'
	jmp noKey
	
turnUp:
	cmp [direction], 'd'
	je noKey
	cmp [direction], 'u'
	je noKey
	mov [direction], 'u'
	jmp noKey

turnDown:
	cmp [direction], 'u'
	je noKey
	cmp [direction], 'd'
	je noKey
	mov [direction], 'd'
	jmp noKey
	
noKey:
	call calcCords
	call move_snake
	cmp [ate], 1
	jne continue1
	call drawApple
	mov [ate], 0
	
continue1:
	call delay
	jmp maingameloop
	
end1:
; text mode
	mov ax , 2h
	int 10h 
	
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
END start


