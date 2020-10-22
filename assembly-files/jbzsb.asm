IDEAL
MODEL small
STACK 100h
p186
DATASEG
; --------------------------
; Your variables here
chr db ?
gameTitle db '  ______                          ______             _', 10, 13     
db ' / _____) _                      (____  \           | |', 10, 13    
db '( (____ _| |_ ___  ____  _____    ____)  )_____  ___| |__', 10, 13  
db ' \____ (_   _) _ \|  _ \| ___ |  |  __  ((____ |/___)  _ \', 10, 13 
db ' _____) )| || |_| | | | | ____|  | |__)  ) ___ |___ | | | |', 10, 13
db '(______/  \__)___/|_| |_|_____)  |______/\_____(___/|_| |_|', 10, 13, '$'

by db '  ____', 10, 13          
db ' |  _ \       _', 10, 13 
db ' | |_) |_   _(_)', 10, 13
db ' |  _ <| | | |', 10, 13  
db ' | |_) | |_| |_', 10, 13 
db ' |____/ \__, (_)', 10, 13
db '         __/ |', 10, 13  
db '        |___/', 10, 13, '$'   


maker db '   __   __   __ _   __  ____  _  _   __   __ _', 10, 13 
db ' _(  ) /  \ (  ( \ / _\(_  _)/ )( \ / _\ (  ( \', 10, 13
db '/ \) \(  O )/    //    \ )(  ) __ (/    \/    /', 10, 13
db '\____/ \__/ \_)__)\_/\_/(__) \_)(_/\_/\_/\_)__)', 10, 13, '$'

makerlast db ' ____  ____  ____   __   __    ____  __', 10, 13   
db '(  _ \(  __)(__  ) / _\ (  )  (  __)(  )', 10, 13  
db ' ) _ ( ) _)  / _/ /    \/ (_/\ ) _) / (_/\', 10, 13
db '(____/(____)(____)\_/\_/\____/(____)\____/', 10, 13, '$'

             
deadRocks db 8 dup (0)   
rocks_x db 4,8,12,16,20,24,28,32
current_rock dw 0
x_rock db ?
y_rock db 4
rocks_y db 5
x_coordinate dw 60
y_coordinate dw 10
shot_x db ?
shot_y db ?
color dw 4
len dw 40
len1 dw 0
x_temp dw 0
y_temp dw 0
x_cord db 20
y_cord db 23
there_is_a_shot db 0
                                               
                                                                                
                                                                                
                                                           
; --------------------------
CODESEG
; delays
proc delay
	pusha
	mov cx, 04h ;High Word
	mov dx, 0d40h ;Low Word
	mov al, 0
	mov ah, 86h ;Wait
	int 15h
	popa
	ret
endp delay
proc readChr
	pusha
	; waits for character
	mov ah, 0h
	int 16h
	mov [chr], al ; save character to [chr]
	popa
	ret
endp readChr
proc right
	pusha
	call deleteCursore
	cmp [x_cord], 39
	je stop1
	add	[x_cord], 1
	call drawCursore
	stop1:
	
	popa
	ret
endp right
proc left
	pusha
	call deleteCursore
	cmp [x_cord], 0
	je stop
	sub [x_cord], 1
	stop:
	
	call drawCursore
	popa
	ret
endp left

	
proc setCursorePosition
	pusha
	mov dh, [y_cord] ; row
	mov dl, [x_cord] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret
endp setCursorePosition

proc set_rock_position
	pusha
	mov dh, [y_rock] ; row
	mov dl, [x_rock] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret
endp set_rock_position

proc set_shot_position
	pusha
	mov dh, [shot_y] ; row
	mov dl, [shot_x] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret
endp set_shot_position

; draws the cursore in the new position
proc drawCursore
	pusha
	call setCursorePosition
	mov [color], 04h
	mov ah, 9
	mov al, 5 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	popa
	ret
endp drawCursore

proc draw_rock
	pusha
	mov si, offset rocks_x
	add si, [current_rock]
	mov al, [byte ptr si]
	mov [x_rock], al
	call set_rock_position
	mov [color], 04h
	mov ah, 9
	mov al, 219 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	inc [x_rock]
	call set_rock_position
	mov [color], 04h
	mov ah, 9
	mov al, 219 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	inc [y_rock]
	call set_rock_position
	mov [color], 04h
	mov ah, 9
	mov al, 219 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	dec [x_rock]
	call set_rock_position
	mov [color], 04h
	mov ah, 9
	mov al, 219 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	popa
	ret
endp draw_rock

proc delete_rock
	pusha
	mov si, offset rocks_x
	add si, [current_rock]
	mov al, [byte ptr si]
	mov [x_rock], al
	call set_rock_position
	mov [color], 0h
	mov ah, 9
	mov al, 219 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	inc [x_rock]
	call set_rock_position
	mov ah, 9
	mov al, 219 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	inc [y_rock]
	call set_rock_position
	mov ah, 9
	mov al, 219 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	dec [x_rock]
	call set_rock_position
	mov ah, 9
	mov al, 219 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	popa
	ret
endp delete_rock

proc draw_shot
	pusha
	call set_shot_position
	mov [color], 04h
	mov ah, 9
	mov al, 179 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	mov [there_is_a_shot], 1
	popa
	ret
endp draw_shot

proc delete_shot
	pusha
	call set_shot_position
	mov [color], 0h
	mov ah, 9
	mov al, 179 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	popa
	ret
endp delete_shot

proc deleteCursore
	pusha
	call setCursorePosition
	mov [color], 0h
	mov ah, 9
	mov al, 5 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	popa
	ret
endp deleteCursore
proc printString
	pusha
	mov ah, 9h
	int 21h ;interrupt that displays a string
	popa
	ret
endp printString
proc drawPixel
	pusha
	; Drawing a red pixel in (100, 10)
	xor bh, bh ; bh = 0
	mov cx, [x_temp]
	mov dx, [y_temp]
	mov ax, [color]
	mov ah, 0ch
	int 10h
	popa
	ret
endp drawPixel

; draws a line of pixels
proc draw_line
	pusha
	; move x_coordinate to x_temp
	mov ax, [x_coordinate]
	mov [x_temp], ax
	mov cx, [len]
	draw:
		call drawPixel
		inc [x_temp]
		loop draw
	popa
	ret
endp draw_line

proc draw_rect
	pusha
	mov cx, [len]
	mov ax, [y_coordinate]
	mov [y_temp], ax
rect:
	call draw_line
	inc [y_temp] ;column
	loop rect
	popa
	ret
endp draw_rect
proc drawRocks
	pusha 
	mov di, offset deadRocks
	mov [current_rock], 0
	mov cx, 8
printer:
	mov al, [rocks_y]
	mov [y_rock], al 
	cmp [byte ptr di], 1
	je end1
	call draw_rock
end1:
	inc [current_rock]
	inc di
	loop printer
	popa
	ret
endp drawRocks

proc deleteRocks
	pusha 
	mov [current_rock], 0
	mov cx, 8
printer2:
	mov al, [rocks_y]
	mov [y_rock], al 
	call delete_rock
	inc [current_rock]
	loop printer2
	popa
	ret
endp deleteRocks
start:
	mov ax, @data
	mov ds, ax
; --------------------------
; Your code here

	mov dx, offset gameTitle
	call printString
	mov dx, offset by
	call printString
	mov dx, offset maker
	call printString
	mov dx, offset makerlast
	call printString

	; Wait for character
	mov ah, 0h
	int 16h
	; Graphic mode
	mov ax, 13h
	int 10h
	
	call drawRocks
	
gameLoop:
	call drawCursore
	mov ah, 1h
	int 16h
	jz cont1
	call readChr
	
	
	; Checking what button was pressed
	cmp [chr], 'd'
	je help
	cmp [chr], 'a'
	je help1
	cmp [chr], 'q'
	je exitHelp
	cmp [chr], ' '
	je checking
	jmp gameLoop

help:
	call right
	jmp cont1

help1:
	call left
	jmp cont1

checking:
	cmp [there_is_a_shot], 0
	jne cont1
	mov bl, [x_cord]
	mov [shot_x], bl
	mov bl, [y_cord]
	sub bl, 2
	mov [shot_y], bl
	call draw_shot
	
cont1:
	cmp [there_is_a_shot], 1
	jne cont
	call delete_shot
	sub [shot_y], 1
	cmp [shot_y], 0
	jne checking2
	jmp delete
	
exitHelp:
	jmp exit
	
checking2:
	mov bl, [shot_y]
	cmp bl, [rocks_y]
	je cheking3
	call draw_shot
	jmp cont

cheking3:
	mov bh, [shot_x]
	mov cx, 8
	mov [current_rock], 0
	mov di, offset deadRocks
	mov si, offset rocks_x
	
checker:
	mov ax, [current_rock]
	cmp [di], ax
	je cont2
	cmp [si], bh
	jne checker1
	jmp delete1
	
checker1:
	inc bh
	cmp [si], bh
	jne cont2
	jmp delete1
	
cont2:
	inc [current_rock]
	dec bh
	inc si
	inc di
	loop checker
	
delete1: 
	mov [there_is_a_shot], 0
	mov [byte ptr di], 1
	jmp cont
	
delete: 
	mov [there_is_a_shot], 0
	jmp cont
	
cont:
	call deleteRocks
	cmp [rocks_y], 20
	jne cont4
	mov [rocks_y], 4
	
cont4:
	inc [rocks_y]
	call drawRocks
	call delay
	jmp gameLoop
	

mov ax, 2h
int 10h
; --------------------------
	
exit:
	mov ax, 2h
	int 10h
	mov ax, 4c00h
	int 21h
END start


