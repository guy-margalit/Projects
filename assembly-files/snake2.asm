IDEAL
MODEL small
STACK 100h
p186
DATASEG
; --------------------------
snakeLen dw 0
x_coordinate dw 0
y_coordinate dw 0
snakeHead db 16
dir db 1
len dw 2
ten db 10
number db 0
turn db 1
x_cord db 10
y_cord db 5
delayLength dw 03h
x_temp db 10
counter db 0
chr db 0
y_temp db 0
snakeBody db 20 dup ('$')
color dw 0 
charac db 0
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
; --------------------------
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
;draw smiley - ascii 2 at cursor position
proc drawCharacter
	pusha
	mov ah, 9
    mov al, [charac]    ;al = character to displays
    mov bx, [color] ;bh = background bl = foreground
    mov cx, 1    ;cx = number of times to write character
    int 10h
	popa
	ret
endp drawCharacter
proc draw_rect
	pusha
	mov cx, [len]
rect:
	call draw_line
	inc [y_coordinate] ;column
	loop rect
	popa
	ret
endp draw_rect
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
proc draw_pix
	pusha
	xor bh, bh ; bh = 0
	mov cx, [x_coordinate]
	mov dx, [y_coordinate]
	mov ax, [color]
	mov ah, 0ch
	int 10h
	popa
	ret
endp draw_pix
; draws a line of pixels
proc draw_line
	pusha
	mov cx, 10
draw2:
	call draw_pix
	inc [x_coordinate]
	loop draw2
	popa
	ret
endp draw_line

proc delete_p
	pusha
	xor bh, bh ; bh = 0
	mov cx, [x_coordinate]
	mov dx, [y_coordinate]
	mov ax, 0
	mov ah, 0ch
	int 10h
	popa
	ret
endp delete_p
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
;builds the snake
proc buildSnake2
	pusha
	mov bx, offset snakeBody
	mov cx, [len]
	dec cx
	cmp cx, 0
	je break
	mov al, [byte ptr bx]
	mov [charac], al
	call drawCharacter
	inc bx
printer:
	mov al, [byte ptr bx]
	mov [charac], al
	inc [x_cord]
	call setCursorePosition
	call drawCharacter
	inc bx
	loop printer
break:
	popa
	ret
endp buildSnake2
proc addToSnake
	pusha
	mov bx, offset snakeBody
	mov cx, [len]
printer1:
	mov [byte ptr bx], 196
	inc bx
	loop printer1
	popa
	ret
endp addToSnake
start:
	mov ax, @data
	mov ds, ax
; --------------------------
	;enter graphic mode
	mov ax, 13h
	int 10h
	
	;prints the frame
	mov dx, offset frame
	call printString
	
	call addToSnake
	
	mov [x_cord], 5
	mov [y_cord], 10
	call setCursorePosition
	mov [color], 0Fh
	call buildSnake2
	
gameLoop:
call readChr
	cmp [dir], 1
	je right
	
	cmp [dir], 2
	je left
	
	cmp [dir], 3
	je downHelp
	
	cmp [dir], 4
	je upHelp

continue:
	; check if thre is a charcter to read
	mov [chr], 0
	mov ah, 1h
	int 16h
	
	jz noKey

	call readChr
	
	cmp [chr], 'd'
	je right
	
	cmp [chr], 'a'
	je left
	
	cmp [chr], 'w'
	je up
	
	cmp [chr], 's'
	je turnDown
	
	cmp [chr], 'q'
	je exitHelp
	
noKey:
	call delay
	jmp gameLoop

downHelp:
	jmp down

upHelp:
	jmp up
	
exitHelp:
	jmp exit

turnDown:
	mov [dir], 3
	jmp down
	
right:
	mov [color], 0h
	call buildSnake2
	mov [color], 0Fh
	call setCursorePosition
	call buildSnake2
	jmp continue
	
left:
	mov [color], 0h
	call setCursorePosition
	call buildSnake2
	dec [x_cord]
	call setCursorePosition
	call buildSnake2
	jmp continue

up:
	mov [color], 0h
	call setCursorePosition
	call buildSnake2
	inc [y_cord]
	call setCursorePosition
	call buildSnake2
	jmp continue
	
down:
	mov [color], 0h
	call setCursorePosition
	call buildSnake2
	call readchr
	inc [y_cord]
	mov [color], 0Fh
	call setCursorePosition
	call buildSnake2
	jmp continue

	
; --------------------------
exit:
	mov ah, 2h
	int 10h
	mov ax, 4c00h
	int 21h
END start

