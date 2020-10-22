IDEAL
MODEL small
STACK 100h
jumps
p186
DATASEG
x_cord db 7 ; column
y_cord db 6 ; row
color dw 0Eh ; color
loop_num db 0
chr db 0
screenChr db 0
lost db 0
direction db 'r'
obstacle db '<'
delayLength dw 03h
fence_x_coord db 5
fence_y_coord db 5
tav db '|'
cx_keeper dw 21
rnd db 0
bx_saver dw 0
number db 0
ten db 10
endTime db 0
number2 db 0
timend db 0
press db ' Press space to exit and r to try and loose again',10,13,'$'
student db' MADE BY: Guy Margalit' ,10,13
	db' Press any key to continue' ,10,13,'$'
openScreen db'         __   ',10,13
db '      ____   _____/  |_       ' ,10,13
db '     / ___\_/ __ \   __\      ' ,10,13
db '    / /_/  >  ___/|  |        ' ,10,13
db '    \___  / \___  >__|        ' ,10,13
db '   /_____/      \/            ' ,10,13
db '                               .___      ' ,10,13
db '    _______   ____ _____     __| _/__.__.     ' ,10, 13
db '    \_  __ \_/ __ \\__  \   / __ <   |  |  ' ,10, 13
db '     |  | \/\  ___/ / __ \_/ /_/ |\___  |   ' ,10, 13
db '     |__|    \___  >____  /\____ |/ ____|  ' ,10, 13
db '                 \/     \/      \/\/     ' ,10,13
db '    __    ' ,10, 13
db '  _/  |_  _____       ' ,10, 13
db '  \   __\/  _  \     ' ,10, 13
db '   |  | (  <_>  )     ' ,10, 13
db '   |__|  \_____/      ' ,10,13
db '    _____.__         ' ,10, 13
db '  _/ ____\  | ___.__.        ' ,10, 13
db '  \   __\|  |<   |  |      ' ,10, 13
db '   |  |  |  |_\___  |         ' ,10, 13
db '   |__|  |____/ ____|      ' ,10,13
db '              \/          ',10,13, '$'
frame db '    VVVVVVVVVVVVVVVVVVVVVVVVVV    ',10,13
	db '    |                        |    ',10,13
	db '    |                        |    ',10,13
	db '    |                        |    ',10,13
	db '    >                        <    ',10,13
	db '    |                        |    ',10,13
	db '    |                        |    ',10,13
	db '    |                        |    ',10,13
	db '    |                        |    ',10,13
	db '    >                        |    ',10,13
	db '    |                        |    ',10,13
	db '    |                        <    ',10,13
	db '    |                        |    ',10,13
	db '    |                        |    ',10,13
	db '    >                        |    ',10,13
	db '    |                        |    ',10,13
	db '    |                        |    ',10,13
	db '    |                        |    ',10,13
	db '    |                        |    ',10,13
	db '    |                        |    ',10,13
	db '    |                        |    ',10,13
	db '    |                        |    ',10,13
	db '    ^^^^^^^^^^^^^^^^^^^^^^^^^^    ',10,13,'$'
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
;print a string on the screen assuming the string offset is in dx
proc printString
	pusha
	mov ah, 9h
	int 21h ; interrupt that displays a string
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
	mov al, 2 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	popa
	ret
endp drawCharacter
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
; check the content of screenChr.
; if it is one of <>^v ends game
proc checkScrnChr
	pusha
	cmp [screenChr], '<'
	je youLost
	cmp [screenChr], '>'
	je youLost
	cmp [screenChr], 86 ; V
	je youLost
	cmp [screenChr], 94 ; ^
	je youlost
	cmp [screenChr], '|'
	je changeDirection
	jmp endCheckScrnChr
youLost:
	mov [lost], 1
	jmp endCheckScrnChr
changeDirection:
	call changeDir
endCheckScrnChr:
	popa
	ret
endp checkScrnChr
; change character direction from 'r' to 'l' and from 'l' to 'r'
proc changeDir
	pusha
	cmp [direction], 'r'
	je right
	mov [direction], 'r'
	add [x_cord], 2
	call draw_left_fence
	jmp endChangeDir
right:
	call draw_right_fence
	mov [direction], 'l'
	sub [x_cord], 2
endChangeDir:
	call setCursorePosition ; sets character position in opposite direction
	popa
	ret
endp changeDir
; increases x_cord by one if direction is 'r' and decreases it if it is 'l'
; increases y_cord by 2 if chr is not ' ' and decreases it by 1 if it is
proc calculateCords
	pusha
	cmp [direction], 'r'
	je right2
	dec [x_cord]
	jmp calc_y
right2:
	inc [x_cord] 
calc_y:
	cmp [chr], ' '
	je jmpChr
	add [y_cord], 2
	jmp endCalculateCords
jmpChr:
	sub [y_cord], 2
endCalculateCords:
	popa
	ret
endp calculateCords
;sets the fence cursor location
proc fence_cursor_location
	pusha
	mov dh, [fence_y_coord] ; row
	mov dl, [fence_x_coord] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret
endp fence_cursor_location
;draws a char
proc draw_tav
	pusha
	mov ah, 9
	mov al, [tav] ; al = character to display
	mov bx, 00Fh ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	popa
	ret
endp draw_tav
; draws a line of length 17 starting at fence_x_coord fence_y_coord
proc draw_line
	pusha
	mov cx,21 ; loop 
	mov [tav],"|" ; draw line of 21 → |
	mov cx, 21 ; loop count
draw_fence2:
	mov [cx_keeper], cx
	call fence_cursor_location
	call draw_tav
	add [fence_y_coord], 1
	mov cx, [cx_keeper]
	loop draw_Fence2
	popa
	ret
endp draw_line
;generates a random number and keeps it in rnd
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
	and al,0fh
	mov [rnd], al
	popa
	ret
endp random
; draws a line of length 21 starting at fence_x_coord fence_y_coord 
; the line contains 5 obstacles
proc draw_fence
	pusha
	call draw_line
	mov dl, [obstacle]
	mov [tav], dl
	mov cx, 5
	; loop for drwing random onstacles
draw_obstacles:
	call random
	mov dl, [rnd]
	add dl, 5
	mov [fence_y_coord], dl
	call fence_cursor_location
	call draw_tav
	loop draw_obstacles
	popa 
	ret 
endp draw_fence
; sets parameters for left fence
proc draw_Left_Fence
	pusha
	mov [fence_x_coord] , 4
	mov [fence_y_coord], 1
	mov [obstacle], '>'
	call draw_fence
	popa
	ret
endp draw_Left_Fence
; sets parameters for left fence
proc draw_Right_Fence
	pusha
	mov [fence_x_coord] , 29
	mov [fence_y_coord], 1
	mov [obstacle], '<'
	call draw_fence
	popa
	ret
endp draw_Right_Fence
;prints a number in decimal
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
;calculates the end time of the game
proc calculate_End_Time
	pusha
	mov ah, 2ch
	int 21h
	mov [number2], dh
	mov [endTime], dh
	cmp [endTime], 0
	je reset
	dec [endTime]
	jmp dec_1
reset:
	add [endTime],59
dec_1:
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
timenotend:
	cmp [number2], dh
	jg larger
	jmp smaller
larger:
	add dh, 60
smaller:
	mov [number], dh
	mov ch, [number2]
	sub [number], ch
	call print_Number
	popa
	ret
endp checkEndTime

start:
	mov ax, @data
	mov ds, ax
	mov [delayLength] , 03h
	mov [lost] , 0
	mov [color], 0Eh
	mov [x_cord],7
	mov [y_cord],6
	mov [direction] , 'r'
	mov [obstacle] , '<'
	; printing the opening screen string
	mov dx, offset openScreen 
	call printString
	; printing the student string
	mov dx, offset student 
	call printString
	; waits for character
	call readChr
	; clear screen by entering graphic mode 40*25
	mov ax, 13h
	int 10h
	; printing the frame string
	mov dx, offset frame 
	call printString
	; waits for character
	call readChr
	; set cursore location
	call setCursorePosition
	; draw smiley - ascii 2 at cursor position
	call drawCharacter
	; waits for character
	call readChr
	; check if user asks to quit
	cmp [chr], 'q'
	je end_game
	mov [chr], 0 
	call calculate_End_Time
	
mainGameLoop:
	; delete character
	mov [color], 0 ; black color
	call drawCharacter
	mov [color], 0Eh
	call checkEndTime
	call calculateCords
	; print chararcter
	; set cursore location
	call setCursorePosition
	; check character at cursor location
	call readScreenChr
	call checkScrnChr
	; checks if lost = 1  
	cmp [lost], 1
	je end_game
	; checks if time_is_over = 1
	cmp [timend], 1
	je end_game
	; draw smiley - ascii 2 at cursor position
	mov [color], 0Eh
	call drawCharacter
	; check if thre is a charcter to read
	mov [chr], 0
	mov ah, 1h
	int 16h
	; read a chararcter
	jz noKey
	; waits for character
	call readChr
	; check if user asks to quit
	cmp [chr], 'q'
	je end_game
noKey:
	call delay
	jmp mainGameLoop	
end_game:
	; text mode 80 * 25
	mov ax, 2h
	int 10h
	; checks if the time ran out
	cmp [timend], 1
	je timeend
	; printing lost
	mov dx, offset lostscreen ; printing the lost screen string
	call printString
	;printing press
	mov dx , offset press
	call printString
	; change delay length so the screen waits
	mov [delayLength], 15h
	call delay	
	
	; waits for character
	call readChr
	cmp [chr], 'r'
	je start
	cmp [chr], ' '
	je exit
	jmp end_game
	
timeend:
	; printing won
	mov dx, offset won ; printing the u won string
	call printString
	; change delay length so the screen waits
	mov [delayLength], 15h
	call delay
exit:
	mov ax, 4c00h
	int 21h
END start