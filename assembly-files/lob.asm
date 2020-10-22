;התכנית מתחילה בהדפסה של ההוראות ואז עוברים ללולאה הראשית
;אם השחקן לא לחץ בשום מקום הקוביות זזות אבל אם הוא לחץ זה יבדוק איפה ורק אז יזיז אותם 
IDEAL
MODEL small
STACK 100h
jumps
p186

DATASEG
ten db 10
score db 0
chr db 0
lost db 0
color dw 0
rnd db 0
max db 0
turn db 0
waiter db 7
x_cord db 0
y_cord db 0
endTime db 0
counter dw 0
bx_saver dw 0
x_Rects db 100 dup (0)
y_Rects db 100 dup (0)
rectsCount dw 0
delayLength dw 03h
x_coordinate dw 0
y_coordinate dw 0
x_coord dw 0
y_coord dw 0
instructions db '                                The Piano Game            ',10,13
		     db '                  do not toouch the white or you will lose',10,13
		     db '                       press on the tiles to gain point   ',10,13
		     db '                          reach 30 to win the game        ',10,13,'$'
lostscreen db '          _   _         _   _  ',10,13                         
db '         | | | |       | | | |  ',10,13                          
db '         | |_| | __ _  | |_| | __ _ 	',10,13   
db '	 |  _  |/ _` | |  _  |/ _` |	',10,13   
db '	 | | | | (_| | | | | | (_| |	',10,13   
db '	 \_| |_/\__,_| \_| |_/\__,_|	',10,13 
db '          	 _     ',10,13
db '         	| |        ',10,13
db '		| | ___  ___  ___ _ __ ',10,13
db '		| |/ _ \/ __|/ _ \  __|',10,13
db '		| | (_) \__ \  __/ |   ',10,13
db '		|_|\___/|___/\___|_|   ',10,13,'$'
won db '.----------------.    .----------------.  .----------------.  .-----------------. ',10,13 
db '| .--------------. |  | .--------------. || .--------------. || .--------------. | ',10,13
db '| | _____  _____ | |  | | _____  _____ | || |     ____     | || | ____  _____  | | ',10,13
db '| ||_   _||_   _|| |  | ||_   _||_   _|| || |   .     `.   | || ||_   \|_   _| | | ',10,13
db '| |  | |    | |  | |  | |  | | /\ | |  | || |  /  .--.  \  | || |  |   \ | |   | | ',10,13
db '| |  | |    | |  | |  | |  | |/  \| |  | || |  | |    | |  | || |  | |\ \| |   | | ',10,13
db '| |   \ `--  /   | |  | |  |   /\   |  | || |  \  `--  /  | || | _| |_\   |_  | | ',10,13
db '| |    `.__.     | |  | |  |__/  \__|  | || |   `.____.    | || ||_____|\____| | | ',10,13
db '| |              | |  | |              | || |              | || |              | | ',10,13
db '| -------------- | |   --------------  ||  --------------  ||  --------------  | ',10,13
db ' ----------------      ----------------    ----------------    ----------------  ',10,13,'$'
CODESEG
;generates a random number and keeps it in rnd
proc random
	pusha
	mov bx, [bx_saver]
	;put segment number in register es
	mov ax, 40h
	mov es, ax
	;move random number to ax
	mov ax, [es:6Ch]
	xor ax, [bx]
	add [bx_saver], ax
	and al, [max]
	inc al
	mov [rnd], al
	popa
	ret
endp random

proc printString
	pusha
	mov ah, 9h
	int 21h ;interrupt that displays a string
	popa
	ret
endp printString

;calculates the end time of the boost
proc calculate_End_Time
	pusha
	mov ah, 2ch
	int 21h
	mov al, 60
	sub al, [waiter]
	cmp dh, al
	jge moveMinute
	add dh, [waiter]
	mov [endTime], dh
	jmp finish11
	
moveMinute:
	dec al
	sub dh, al
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
	call createObst
	mov [endTime], 0
timenotend:
	popa
	ret
endp checkEndTime

proc draw_pixel
	pusha
	xor bh, bh ; bh = 0
	mov cx, [x_coord]
	mov dx, [y_coord]
	mov ax, 0fh
	mov ah, 0ch
	int 10h
	popa
	ret
endp draw_pixel

proc paintRow
	pusha
	mov cx, 320
	mov [x_coord], 0
@@draw:
	call draw_pixel
	inc [x_coord]
	loop @@draw
	popa
	ret
endp paintRow

proc paintScreen
	pusha
	mov cx, 200
	mov [y_coord], 0
@@draw:
	call paintRow
	inc [y_coord]
	loop @@draw
	popa
	ret
endp paintScreen
; reads a character into chr
proc readChr
	pusha
	;waits for character
	mov ah, 0h
	int 16h
	mov [chr], al ;save character to [chr]
	popa
	ret
endp readChr

;sets the cursor location
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

;draws the character on the screen
proc drawCharacter
    pusha
	; draw smiley - ascii 2 at cursor position
	mov ah, 9
	mov al, 219 ;aL = character to display
	mov bx, [color] ;bh = Background bl = Foreground
	mov cx, 1 ;cx = number of times to write character
	int 10h
	popa
	ret
endp drawCharacter

;proc that plays a sound from notes
proc playSound
	pusha
	;open speaker
	in al,61h
	or al,00000011b
	out 61h, al
	;play sound
	mov ax, 4560
	out 42h,al
	mov al,ah
	out 42h,al
	;delay by 1 second
	mov bx,18
	again:
    mov cx,-1
    loop $    
	dec bx      
    jnz again 
	;close speaker
	in al,61h
	and al,11111100b
	out 61h,al
	popa
	ret
endp playSound

proc checkPress
	pusha
	;get pixel color - result is in al
	mov bh, 0h
	mov cx, [x_coordinate]
	mov dx, [y_coordinate]
	mov ah, 0dh
	int 10h
	cmp al, 0fh
	je @@lost
	inc [score]
	call playSound
	jmp @@finish
	
@@lost:
	mov [lost], 1
	
@@finish:
	popa
	ret
endp checkPress

proc printScore
	pusha
	;sets cursor on the corner
	mov dh, 23 ; row
	mov dl, 37 ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	mov ah, 0 
	mov al, [score]
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
endp printScore

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

proc drawRect
	pusha
	call setCursorePosition
	call drawCharacter
	mov cx, 2
@@draw1:
	inc [x_cord]
	call setCursorePosition
	call drawCharacter
	loop @@draw1
	inc [y_cord]
	call setCursorePosition
	call drawCharacter
	mov cx, 2
@@draw2:
	dec [x_cord]
	call setCursorePosition
	call drawCharacter
	loop @@draw2
	inc [y_cord]
	call setCursorePosition
	call drawCharacter
	mov cx, 2
@@draw3:
	inc [x_cord]
	call setCursorePosition
	call drawCharacter
	loop @@draw3
	sub [x_cord], 2
	popa
	ret
endp drawRect

proc createObst
	pusha
	mov [max], 35
	call random
	mov al, [rnd]
	mov bx, offset x_Rects
	add bx, [RectsCount]
	dec bx
	mov [byte ptr bx], al
	mov bx, offset y_Rects
	add bx, [RectsCount]
	dec bx
	mov [byte ptr bx], 1
	inc [RectsCount]
	popa
	ret
endp createObst

proc moveObst
	pusha
	mov [counter], 0
	mov bx, offset x_Rects
	mov cx, 100
	
@@printer:
	cmp [byte ptr bx], 0
	je @@done
	mov al, [byte ptr bx]
	mov [x_cord], al
	push bx
	mov bx, offset y_Rects
	add bx, [counter]
	mov al, [byte ptr bx]
	mov [y_cord], al
	call setCursorePosition
	mov [color], 0fh
	call drawRect
	inc [byte ptr bx]
	inc [y_cord]
	cmp [y_cord], 3
	jne @@normal
	mov [byte ptr bx], 0
	pop bx
	jmp @@done
@@normal:
	call setCursorePosition
	mov [color], 0h
	call drawRect
	pop bx
@@done:
	inc bx
	inc [counter]
	loop @@printer
	popa
	ret
endp moveObst

start:
	mov ax, @data
	mov ds, ax 
	
	mov ax, 10h
	int 10h
	
	mov dx, offset instructions
	call printString
	
	call readChr
	
	mov ax, 13h
	int 10h
	
	call paintScreen
	
	;initiate cursor
	xor ax, ax
	int 33h
	
	;show cursor
	mov ax, 1h
	int 33h
	
mainGameLoop:	
	mov ax, 3h ;read mouse status and position
	int 33h
	
	cmp bx, 01h ;check left mouse click
	je check
	
	cmp bx, 03h ;check right & left mouse click
	je exit
	
noKey:
	cmp [score], 30
	je winner
	cmp [score], 15
	jne @@continue1
	mov [waiter], 3
@@continue1:
	cmp [endTime], 0
	jne @@continue
	call calculate_End_Time
@@continue:
	call checkEndTime
	call moveObst
	inc [turn]
	call printScore
	call delay
	jmp mainGameLoop
	
check:
	;read cursor location
	mov [x_coordinate], cx
	shr [x_coordinate], 1
	sub [x_coordinate], 2
	mov [y_coordinate], dx
	call checkPress
	cmp [lost], 1
	je loser
	jmp noKey
	
loser:
	;hide cursor
	mov ax, 2h
	int 33h

	;back to text mode
	mov ax, 2h
	int 10h
	
	mov dx, offset lostscreen
	call printString
	
	call readChr
	jmp exit
	
winner:
	;hide cursor
	mov ax, 2h
	int 33h

	;back to text mode
	mov ax, 2h
	int 10h
	
	mov dx, offset won
	call printString
	
	call readChr
	jmp exit
	
exit:
	mov ax, 4c00h
	int 21h
END start