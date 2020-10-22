IDEAL
MODEL small
STACK 100h
p186
DATASEG
; --------------------------
x_coordinate dw 0
y_coordinate dw 0
x_cord db 0
y_cord db 0
pixelCount db 0
backColor dw 0
len dw 10
color dw 0Fh
chr db 0
screenChr db 0
frame db 201,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,187,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 186,'                              ',186,10,13
	  db 200,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,188,10,13,'$'
; --------------------------
CODESEG

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

proc checkIfChosen
	pusha
	;read cursor location
	mov [x_coordinate], cx
	shr [x_coordinate], 1
	mov [y_coordinate], dx
	
	cmp [x_coordinate], 275
	jg check12
	jmp finish2
	
check12:
	cmp [x_coordinate], 285
	jl check22
	jmp checkBack
	
check22:
	cmp [y_coordinate],	15
	jg check32
	jmp checkYellow
	
check32:
	cmp [y_coordinate],	25
	jl colorRed
	jmp checkYellow

colorRed:
	mov [color], 4h
	jmp colorF
	
checkYellow:
	cmp [y_coordinate],	45
	jg check33
	jmp checkWhite
	
check33:
	cmp [y_coordinate],	55
	jl colorYellow
	jmp checkWhite

colorYellow:
	mov [color], 0Eh
	jmp colorF

checkWhite:
	cmp [y_coordinate],	75
	jg check34
	jmp checkGreen
	
check34:
	cmp [y_coordinate],	85
	jl colorWhite
	jmp checkGreen

colorWhite:
	mov [color], 0Fh
	jmp colorF

checkGreen:
	cmp [y_coordinate],	105
	jg check35
	jmp checkBlue
	
check35:
	cmp [y_coordinate],	115
	jl colorGreen
	jmp checkBlue

colorGreen:
	mov [color], 2h
	jmp colorF
	
checkBlue:
	cmp [y_coordinate],	135
	jg check36
	jmp checkPink
	
check36:
	cmp [y_coordinate],	145
	jl colorBlue
	jmp checkPink

colorBlue:
	mov [color], 1h
	jmp colorF

checkPink:
	cmp [y_coordinate],	165
	jg check37
	jmp finish2
	
check37:
	cmp [y_coordinate],	175
	jl colorPink
	jmp finish2

colorPink:
	mov [color], 0Dh
	jmp colorF

checkBack:
	cmp [x_coordinate], 300
	jg check15
	jmp finish2
	
check15:
	cmp [x_coordinate], 310
	jl check39
	jmp finish2

check39:
	cmp [y_coordinate],	90
	jg check38
	jmp finish2
	
check38:
	cmp [y_coordinate], 100	
	jl colorScr
	jmp finish2

colorScr:
	mov ax, [color]
	mov [backColor], ax
	call clearScr
	jmp finish2
	
colorF:
	mov [y_coordinate], 90
	mov [len], 10
	mov cx, [len]
	
rect1:
	mov [x_coordinate], 300
	call draw_line
	inc [y_coordinate] ;column
	loop rect1
	
finish2:
	popa 
	ret
endp checkIfChosen

proc delete_p
	pusha
	xor bh, bh ; bh = 0
	mov cx, [x_coordinate]
	mov dx, [y_coordinate]
	mov ax, [backColor]
	mov ah, 0ch
	int 10h
	popa
	ret
endp delete_p

proc readScreenChr 
	pusha
	mov bh, 0h ; Page=1
	mov ah, 08h ; Read character function
	int 10h ; return the character to al
	mov [screenChr], al
	popa
	ret
endp readScreenChr

; deletes
proc delete_pixel
	pusha
	; read cursor location
	mov [x_coordinate], cx
	shr [x_coordinate], 1
	mov [y_coordinate], dx
	
	cmp [x_coordinate], 10
	jg check11
	jmp finish1
	
check11:
	cmp [x_coordinate], 250
	jl check21
	jmp finish1
	
check21:
	cmp [y_coordinate],	5
	jg check31
	jmp finish1
	
check31:
	cmp [y_coordinate],175
	jl paint1
	jmp finish1
	
paint1:
	call delete_p
	inc [y_coordinate]
	call delete_p
	inc [y_coordinate]
	call delete_p
	dec [x_coordinate]
	call delete_p
	dec [x_coordinate]
	call delete_p
	dec [x_coordinate]
	call delete_p
	dec [y_coordinate]
	call delete_p
	inc [x_coordinate]
	call delete_p
	inc [x_coordinate]
	call delete_p
	dec [y_coordinate]
	call delete_p
	dec [x_coordinate]
	call delete_p
	dec [x_coordinate]
	call delete_p
finish1:
	popa
	ret
endp delete_pixel

; draws 
proc draw_pixel
	pusha
	; read cursor location
	mov [x_coordinate], cx
	shr [x_coordinate], 1
	mov [y_coordinate], dx
	
	cmp [x_coordinate], 10
	jg check1
	jmp finish
	
check1:
	cmp [x_coordinate], 250
	jl check2
	jmp finish
	
check2:
	cmp [y_coordinate],	5
	jg check3
	jmp finish
	
check3:
	cmp [y_coordinate],175
	jl paint
	jmp finish
	
paint:
	call draw_p
	inc [y_coordinate]
	call draw_p
	inc [y_coordinate]
	call draw_p
	dec [x_coordinate]
	call draw_p
	dec [x_coordinate]
	call draw_p
	dec [x_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	inc [x_coordinate]
	call draw_p
	dec [y_coordinate]
	call draw_p
	dec [x_coordinate]
	call draw_p
	dec [x_coordinate]
	call draw_p
finish:
	call checkIfChosen
	popa
	ret
endp draw_pixel

proc clearScr
	pusha
	mov [y_coordinate], 5
	mov cx, 173
	
clearLine:
	mov [len], 243
	mov [x_coordinate], 7
	call draw_line
	inc [y_coordinate]
	loop clearLine
	popa
	ret
endp clearScr

; print a string on the screen assuming the string offset is in dx
proc printString
	pusha
	mov ah, 9h
	int 21h ; interrupt that displays a string
	popa
	ret
endp printString

proc draw_rect
	pusha
	mov cx, [len]
rect:
	mov [x_coordinate], 275
	call draw_line
	inc [y_coordinate] ;column
	loop rect
	popa
	ret
endp draw_rect

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
	mov cx, [len]
draw2:
	call draw_pix
	inc [x_coordinate]
	loop draw2
	popa
	ret
endp draw_line

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

start:
	mov ax, @data
	mov ds, ax
; --------------------------
	;enter graphic mode
	mov ax, 13h
	int 10h

	call setCursorePosition
	
	;prints the frame 
	mov dx, offset frame
	call printString
	
	add [y_coordinate], 15	
	mov [color], 4h
	call draw_rect
	
	add [y_coordinate], 20
	mov [color], 0Eh
	call draw_rect
	
	add [y_coordinate], 20
	mov [color], 0Fh
	call draw_rect
	
	add [y_coordinate], 20
	mov [color], 2h
	call draw_rect
	
	add [y_coordinate], 20
	mov [color], 1h
	call draw_rect
	
	add [y_coordinate], 20
	mov [color], 0Dh
	call draw_rect
	
	mov [color], 0h
	
	; initiate cursor
	xor ax, ax
	int 33h
	
	;show cursor
	mov ax, 1h
	int 33h
	
MouseLoop:
	mov ax,3h ;read mouse status and position
	int 33h
	cmp bx, 01h ;check left mouse click
	je draw
	cmp bx, 02h ;check right mouse click
	je delete
	cmp bx, 03h ;check right & left mouse click
	je done
	
	jmp MouseLoop
	
draw:
	call draw_pixel
	jmp MouseLoop
	
delete:
	call delete_pixel
	jmp MouseLoop
	
done:	
	; hide cursor
	mov ax, 2h
	int 33h

	; back to text mode
	mov ax, 2
	int 10h
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
END start


