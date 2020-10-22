;all my procs in a seperate file
;proc that opens the bmp file according to the pic variable
proc OpenFile
	;Open image file 
	mov ah, 3Dh
	xor al, al
	cmp [pic], 1
	je @@first ;if pic = 1 open the first image
	cmp [pic], 2 
	je @@second ;if pic = 2 open the second image
	cmp [pic], 3 
	je @@third ;if pic = 3 open the third image
	cmp [pic], 4
	je @@fourth ;if pic = 4 open the fourth image
	mov dx, offset pic5 ;open pic5
	mov [picDir], 1 ;move the picture direction to 1
	mov bl, [picDir] 
	add [pic], bl ;add picDir to the pic to get to the next picture
	jmp @@continue
@@first:
	mov dx, offset pic1 ;open pic1 
	mov bl, [picDir]
	add [pic], bl ;add picDir to the pic to get to the next picture
	jmp @@continue
@@second:
	mov dx, offset pic2 ;open pic2
	mov bl, [picDir]
	add [pic], bl ;add picDir to the pic to get to the next picture
	jmp @@continue
@@third:
	mov dx, offset pic3 ;open pic3
	mov bl, [picDir]
	add [pic], bl ;add picDir to the pic to get to the next picture
	jmp @@continue
@@fourth:
	mov dx, offset pic4 ;open pic4
	mov [picDir], -1
	mov bl, [picDir]
	add [pic], bl ;add picDir to the pic to get to the next picture
	jmp @@continue
@@continue:
	int 21h
	jc @@openerror
	mov [filehandle], ax
	ret
@@openerror:
	;print the error message
	mov dx, offset ErrorMsg
	mov ah, 9h
	int 21h
	ret
endp OpenFile

;proc that opens the picture file of the closing screen 
;according to whether the player won or lost
proc OpenFile3
; Open image file file
	mov ah, 3Dh
	xor al, al
	cmp [lost], 1
	jne @@won ;if the player didn't lose open the winPic file
	mov dx, offset lostPic ;open the lostPic
	jmp @@continue
@@won:
	mov dx, offset wonPic ;open the winPic
@@continue:
	int 21h
	jc @@openerror
	mov [filehandle], ax
	ret
@@openerror:
	;print the error message
	mov dx, offset ErrorMsg
	mov ah, 9h
	int 21h
	ret
endp OpenFile3

;proc tht opens the black pic 
proc OpenFile1
; Open image file file
	mov ah, 3Dh
	xor al, al
	mov dx, offset blackpic ;open the blackpic
	int 21h
	jc @@openerror
	mov [filehandle], ax
	ret
@@openerror:
	;print the error message
	mov dx, offset ErrorMsg
	mov ah, 9h
	int 21h
	ret
endp OpenFile1

;proc that opens the snake frame bmp file
proc OpenFile2
	;Open image file file
	mov ah, 3Dh
	xor al, al
	mov dx, offset snakeFrame ;open the snakeFrame
	int 21h
	jc @@openerror
	mov [filehandle], ax
	ret
@@openerror:
	;print the error messgae
	mov dx, offset ErrorMsg
	mov ah, 9h
	int 21h
	ret
endp OpenFile2

; close file at end of use
proc CloseFile
	push bx
	push ax
	mov bx, [filehandle]
	mov ah, 3Eh
	int 21h
	pop ax
	pop bx
	ret
endp CloseFile

;read the header of the file
proc ReadHeader
; Read BMP file header, 54 bytes
	mov ah,3fh
	mov bx, [filehandle]
	mov cx,54
	mov dx,offset Header
	int 21h
	ret
endp ReadHeader

;read the file's palette
proc ReadPalette
; Read BMP file color palette, 256 colors * 4 bytes (400h)
	mov ah,3fh
	mov cx,400h
	mov dx,offset Palette
	int 21h
	ret
endp ReadPalette

;copy the file's palette to the VGA memory
proc CopyPal
; Copy the colors palette to the video memory
; The number of the first color should be sent to port 3C8h
; The palette is sent to port 3C9h
	mov si, offset Palette
	mov cx, 256
	mov dx, 3C8h
	mov al, 0
	;Copy starting color to port 3C8h
	out dx, al
	;Copy palette itself to port 3C9h
	inc dx
PalLoop:
	; Note: Colors in a BMP file are saved as BGR values 
	; rather than RGB.
	mov al, [si+2] ; Get red value.
	shr al, 2 ; Max. is 255, but video palette maximal
	; value is 63. Therefore dividing by 4.
	out dx, al ; Send it.
	mov al, [si+1] ; Get green value.
	shr al, 2
	out dx, al ; Send it.
	mov al, [si] ; Get blue value.
	shr al, 2
	out dx, al ; Send it.
	add si, 4 ; Point to next color.
	; (There is a null chr. after every color.)
	loop PalLoop
	ret
endp CopyPal

;copy the bitmap of the opened bmp file
proc CopyBitmap
	;BMP graphics are saved upside-down.
	;Read the graphic line by line (200 lines in VGA format),
	;displaying the lines from bottom to top.
	mov ax, 0A000h
	mov es, ax
	; calculate gap between screen buttom and down corner
	mov ax, [y_coord]
	sub ax, [image_height]
	mov [diff], ax
	;number of lines - loop iterations 
	mov cx,[image_height]  
PrintBMPLoop:
	push cx ; keep cx - because it is used in loop
	; di = cx*320, point to the correct screen line
	add cx, [diff]
	mov di,cx
	shl cx,6
	shl di,8
	add di,cx
	add di, [x_coord]
	; Read one line
	mov ah,3fh
	mov cx,[image_width]
	mov dx,offset ScrLine
	int 21h
	; Copy one line into video memory
	cld ; Clear direction flag, for movsb
	mov cx,[image_width]
	mov si,offset ScrLine
	rep movsb ; Copy line to the screen
	 ;rep movsb is same as the following code:
	 ;mov es:di, ds:si
	 ;inc si
	 ;inc di
	 ;dec cx
	 ;loop until cx=0
	pop cx
	loop PrintBMPLoop
	ret
endp CopyBitmap

;proc that prints the picture of the snake
proc printPicture	
	;set the variables for the picture size and location
	mov [image_height], 75
	mov [image_width], 120
	mov [x_coord], 200
	mov [y_coord], 200
	;Process BMP file
	call OpenFile
	call ReadHeader
	call ReadPalette
	call CopyPal
	call CopyBitmap
	call CloseFile
	ret
endp printPicture

;proc that prints the end screen 
proc printEnd
	;set the variables for the picture size and location
	mov [image_height], 200
	mov [image_width], 320
	mov [x_coord], 0
	mov [y_coord], 200
	;Process BMP file
	call OpenFile3
	call ReadHeader
	call ReadPalette
	call CopyPal
	call CopyBitmap
	call CloseFile
	ret
endp printEnd

;proc that prints the frame picture
proc printFrame
	mov [image_height], 200
	mov [image_width], 320
	mov [x_coord], 0
	mov [y_coord], 200
	;Process BMP file
	call OpenFile2
	call ReadHeader
	call ReadPalette
	call CopyPal
	call CopyBitmap
	call CloseFile
	ret
endp printFrame

;proc that prints a black picture
proc deletePicture
	;Process BMP file
	call OpenFile1
	call ReadHeader
	call ReadPalette
	call CopyPal
	call CopyBitmap
	call CloseFile
	ret
endp deletePicture

;proc that pints the openning screen
proc printOpenningScreen
	pusha
	mov di, offset title1 ; sets si to the memory location of title1
	mov [color], GREEN
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

;proc that print a string
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
	mov [chr], ah ;if the char recieved isn't q, 1, 2, 3 then its an arrow so move the scan code to chr
	jmp @@finish
	
key:
	mov [chr], al
	
@@finish:
	popa
	ret
endp readChr

;calculates the end time of the boost
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

;checks whether the end time is met and depowers the snake
proc checkEndTime
	pusha
	mov ah, 2ch
	int 21h
	cmp dh, [endTime]
	je timend11
	jmp timenotend
timend11:
	mov [canKillBoss], 0
timenotend:
	popa
	ret
endp checkEndTime

;set cursor location on dl and dh
proc setCursorePosition
	pusha
    mov bh, 0         
    mov ah, 2 
    int 10h
	popa
	ret
endp setCursorePosition

;proc that creates the portals
proc createPortals
	pusha
	drawObject portal1_x, portal1_y, LIGHT_BLUE, 48 
	drawObject portal2_x, portal2_y, LIGHT_BLUE, 48 
	drawObject portal3_x, portal3_y, LIGHT_BLUE, 48 
	drawObject portal4_x, portal4_y, LIGHT_BLUE, 48 
	popa
	ret
endp createPortals

;proc that moves the snake
proc moveTheSnake
	pusha
	;delete the snake one piece at a time
	lea si, [parts_y]
	lea bx, [parts_x]
	mov cx, [snakeLen]
	
printer:
	inc si
	inc bx
	setCords bx, si
	mov [color], BLACK	
	call drawCharacter
	loop printer
	
	;put si and bx on the x cord and y cord
	lea si, [parts_y]
	lea bx, [parts_x]
	
	;put the head location in head
	mov [head], si
	inc [head]
	
	;check if on portals, ate a boost or lost
	movByte x_temp, bx
	movByte y_temp, si
	;check if n portals if the mode is hard
	cmp [mode], 'h'
	jne noPortals
	call checkOnPortal1
	call checkOnPortal
noPortals:
	call checkNotOnSnake
	;jump to lost if touched itself
	cmp [cant], 1
	je loser
	setCords x_temp, y_temp
	call readScreenChr
	cmp [screenChr], 186
	je loser
	cmp [screenChr], 205
	je loser
	cmp [screenChr], 162
	je eat
	cmp [screenChr], 042
	je eat1
	cmp [screenChr], 015
	je eat2
	cmp [screenChr], 232
	je eat3
	cmp [screenChr], 21
	je eat4
	cmp [screenChr], 2
	je loser
	cmp [screenChr], 1
	je killer
	;move the end of the array
	mov cx, [snakeLen]
	add bx, [snakeLen]
	add si, [snakeLen]
	mov [color], GREEN
	jmp printer1

eat:
	;increase the length
	inc [snakeLen]
	;move the end of the array
	mov cx, [snakeLen]
	add bx, [snakeLen]
	add si, [snakeLen]
	drawObject x_temp, y_temp, LIGHT_RED, 162
	mov [color], LIGHT_RED
	jmp printer1 
	
eat1:
	;lower the delay
	mov [delayLength], 02h
	;move the end of the array
	mov cx, [snakeLen]
	add bx, [snakeLen]
	add si, [snakeLen]
	drawObject x_temp, y_temp, 09h, 42
	mov [color], 09h
	jmp printer1 
	
eat2:
	;increase the delay
	mov [delayLength], 07h
	;move the end of the array
	mov cx, [snakeLen]
	add bx, [snakeLen]
	add si, [snakeLen]
	drawObject x_temp, y_temp, 0Dh, 15
	mov [color], 0Dh
	jmp printer1 
	
eat3:
	cmp [snakeLen], 2
	je notLongEnough
	;decrease the delay
	dec [snakeLen]

notLongEnough:
	;move the end of the array
	mov cx, [snakeLen]
	add bx, [snakeLen]
	add si, [snakeLen]
	drawObject x_temp, y_temp, YELLOW, 232
	mov [color], YELLOW
	jmp printer1 

eat4:
	call calculate_End_Time
	;move the end of the array
	mov cx, [snakeLen]
	add bx, [snakeLen]
	add si, [snakeLen]
	cmp [bossDead], 1
	je cont2
	drawObject x_temp, y_temp, WHITE, 21
	mov [color], WHITE
	jmp printer1
cont2:
	mov [color], GREEN
	jmp printer1
	
killer:
	mov [bossDead], 1
	;move the end of the array
	mov cx, [snakeLen]
	add bx, [snakeLen]
	add si, [snakeLen]
	mov [color], YELLOW
	jmp printer1
	
loser:
	cmp [bossCreated], 1
	jne cont5
	setCords boss_x, boss_y
	mov [color], YELLOW
	mov [charac], 2
	call drawApple
	
cont5:
	mov [lost], 1
	call snakeLost
	jmp done6

printer1: ;print the snake, each part gets the location of the part that is in front of it
	movByte si, si-1
	movByte bx, bx-1
	setCords bx, si	
	cmp si, [head]
	jne normal1
	cmp [dir], 'r'
	je rightHead
	cmp [dir], 'l'
	je leftHead
	cmp [dir], 'd'
	je downHead
	
	mov [charac], 030
	call drawApple
	jmp finish3
	
rightHead:
	mov [charac], 016
	call drawApple
	jmp finish3
	
leftHead:
	mov [charac], 017
	call drawApple
	jmp finish3
	
downHead:
	mov [charac], 031
	call drawApple
	jmp finish3
	
normal1:
	call drawCharacter

finish3:
	dec si
	dec bx
	loop printer1
	jmp done6
	
done6:
	popa
	ret
endp moveTheSnake

;proc that gets the users choise of mode and moves the delay accordingly
proc chooseMode
	pusha
start1:
	call readChr
	cmp [chr], '1'
	je easyMode
	cmp [chr], '2'
	je medMode
	cmp [chr], '3'
	je hardMode
	cmp [chr], 'q'
	je quit1
	jmp start1

easyMode:
	mov [mode], 'e'
	mov [delayLength], 5h
	popa
	ret
	
medMode:
	mov [mode], 'm'
	mov [delayLength], 4h
	popa
	ret
	
hardMode:
	mov [mode], 'h'
	mov [delayLength], 3h
	popa
	ret

quit1:
	mov [quit], 1
	popa
	ret
endp chooseMode

;proc that moves the boss
proc moveTheBoss
	pusha
	cmp [bossDead], 1
	je finish7 ;dont mve the boss if he died
	setCords boss_x, boss_y
	mov [color], BLACK
	mov [charac], 2
	call drawApple
	
	call calcBossCords
	movByte x_temp, boss_x
	movByte y_temp, boss_y
	call checkNotOnSnake
	cmp [cant], 1
	je dead
	setCords boss_x, boss_y
	call readScreenChr
	cmp [screenChr], 042
	je ranOver1
	cmp [screenChr], 015
	je ranOver2
	cmp [screenChr], 162
	je ranOver
	cmp [screenChr], 232
	je ranOver3
	cmp [screenChr], 21
	je ranOver4
	jmp printer2
	
dead:
	cmp [canKillBoss], 1
	jne cont
	mov [bossDead], 1
	jmp finish7 
	
cont:
	mov [color], YELLOW
	mov [charac], 2
	call drawApple
	call snakeLost
	jmp finish7
	
ranOver:
	drawObject x_temp, y_temp, 0Ch, 162
	jmp printer2
	
ranOver1:
	drawObject x_temp, y_temp, 09h, 42
	jmp printer2
	
ranOver2:
	drawObject x_temp, y_temp, 0Dh, 15
	jmp printer2
	
ranOver3:
	drawObject x_temp, y_temp, YELLOW, 232
	jmp printer2
	
ranOver4:
	drawObject x_temp, y_temp, WHITE, 21
	jmp printer2
	
printer2:
	setCords boss_x, boss_y
	mov [color], RED
	cmp [canKillBoss], 1
	jne continue6
	mov [charac], 1
	jmp continue10
	
continue6:
	mov [charac], 2

continue10:
	call drawApple

finish7:
	popa
	ret
endp moveTheBoss

;proc that paint the snake in his place in red
proc snakeLost
	pusha
	mov [lost], 1
	mov cx, [snakeLen]
	lea si, [parts_y]
	lea di, [parts_x]
	mov [color], RED
	mov [head], si
	inc [head]
	
printer11:
	inc si
	inc di
	mov al, [si]
	mov [y_cord], al
	mov al, [di]
	mov [x_cord], al
	setCords x_cord, y_cord	
	cmp si, [head]
	jne normal11
	cmp [dir], 'r'
	je rightHead1
	cmp [dir], 'l'
	je leftHead1
	cmp [dir], 'd'
	je downHead1
	
	mov [charac], 030
	call drawApple
	jmp finish31
	
rightHead1:
	mov [charac], 016
	call drawApple
	jmp finish31
	
leftHead1:
	mov [charac], 017
	call drawApple
	jmp finish31
	
downHead1:
	mov [charac], 031
	call drawApple
	jmp finish31
	
normal11:
	call drawCharacter

finish31:
	loop printer11
	popa
	ret
endp snakeLost

;proc that plays a sound from notes
proc playSound
	pusha
	mov si, offset notes
	add si, [currentNote]
	;open speaker
	in al,61h
	or al,00000011b
	out 61h, al
	;play sound
	mov ax, [si]
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

;draw the apple at cursor position
proc drawApple
	pusha
	mov ah, 9
    mov al, [charac]    ;al = character to displays
    mov bx, [color] ;bh = background bl = foreground
    mov cx, 1    ;cx = number of times to write character
    int 10h
	popa
	ret
endp drawApple

;draw snake part at cursor position
proc drawCharacter
	pusha
	mov ah, 9
    mov al, 219    ;al = character to displays
    mov bx, [color] ;bh = background bl = foreground
    mov cx, 1    ;cx = number of times to write character
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
	mov [screenChr], al ;move the character from al to screenChr
	popa
	ret
endp readScreenChr 

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

;delays
proc delayString
	pusha
	mov cx, 01h ; High Word
	mov dx, 0d40h ; Low Word
	mov al, 0
	mov ah, 86h ; Wait
	int 15h
	popa
	ret
endp delayString

;proc that calculates the snakes cords and puts them in the snake's future position:
;right = inc x cord
;left = dec x cord
;down = inc y cord
;up = dec y cord
proc calcCords
	pusha
	cmp [dir], 'r'
	je moveRight
	cmp [dir], 'l'
	je moveLeft
	cmp [dir], 'u'
	je moveUp
	inc [parts_y]
	jmp finish
	
moveRight:
	inc [parts_x]
	jmp finish
	
moveLeft:
	dec [parts_x]
	jmp finish
	
moveUp:
	dec [parts_y]
	jmp finish
	
finish:
	popa
	ret
endp calcCords

;proc that draws food in a random location 
proc drawFood
	pusha
@@draw:
	randomNumber x_temp, 36
	randomNumber y_temp, 20
	setCords x_temp, y_temp
	call readScreenChr
	cmp [screenChr], 042
	je @@draw
	cmp [screenChr], 015
	je @@draw
	cmp [screenChr], 162
	je @@draw
	cmp [screenChr], 048
	je @@draw
	cmp [screenChr], 232
	je @@draw
	cmp [screenChr], 21
	je @@draw
	cmp [screenChr], 1
	je @@draw
	cmp [screenChr], 2
	je @@draw
	call checkNotOnSnake
	cmp [cant], 1
	je @@draw
	call drawApple
	popa
	ret
endp drawFood

;proc that calculates the boss's cords 
proc calcBossCords
	pusha
	mov [cant], 0
	movByte x_temp, boss_x
	movByte y_temp, boss_y
	
checker1:
	mov al, [boss_x]
	cmp [parts_x], al
	jg blocked11
	cmp [parts_x], al
	jl blocked12
	cmp [parts_x], al
	je blocked13
	inc [counter]
	jmp checker1
	
blocked11:
	mov al, [boss_y]
	cmp [parts_y], al
	jg cannot3
	cmp [parts_y], al
	jl cannot2
	cmp [parts_y], al
	je cannot5
	
blocked12:
	mov al, [boss_y]
	cmp [parts_y], al
	jg cannot1
	cmp [parts_y], al
	jl cannot8
	cmp [parts_y], al
	je cannot9
	
blocked13:
	mov al, [boss_y]
	cmp [parts_y], al
	jg cannot6
	cmp [parts_y], al
	jl cannot7
	
cannot1:
	movByte boss_x, x_temp
	movByte boss_y, y_temp
	cmp [cant], 0
	jne cannot1Cont
	cmp [canKillBoss], 1
	je cannot2Cont

cannot1Cont:
	dec [boss_x]
	inc [boss_y]
	call checkNotOnFrame
	cmp [cant], 1
	je cannot6
	cmp [cant], 2
	je cannot9
	cmp [cant], 3
	je cannot7
	jmp done4
	
cannot2:
	movByte boss_x, x_temp
	movByte boss_y, y_temp
	cmp [cant], 0
	jne cannot2Cont
	cmp [canKillBoss], 1
	je cannot1Cont
	jmp cannot2Cont
	
cannot2Cont:
	inc [boss_x]
	dec [boss_y]
	call checkNotOnFrame
	cmp [cant], 1
	je cannot7
	cmp [cant], 2
	je cannot5
	cmp [cant], 3
	je cannot6
	jmp done4
	
cannot3:
	movByte boss_x, x_temp
	movByte boss_y, y_temp
	cmp [cant], 0
	jne cannot3Cont
	cmp [canKillBoss], 1
	je cannot8Cont
	jmp cannot3Cont
	
cannot3Cont:
	inc [boss_x]
	inc [boss_y]
	call checkNotOnFrame
	cmp [cant], 1
	je cannot6
	cmp [cant], 2
	je cannot5
	cmp [cant], 3
	je cannot7
	jmp done4
	
cannot5:
	movByte boss_x, x_temp
	movByte boss_y, y_temp
	cmp [cant], 0
	jne cannot5Cont
	cmp [canKillBoss], 1
	je cannot9Cont

cannot5Cont:
	inc [boss_x]
	call checkNotOnFrame
	cmp [cant], 1
	je cannot6
	cmp [cant], 3
	je cannot6
	jmp done4
	
cannot6:
	movByte boss_x, x_temp
	movByte boss_y, y_temp
	cmp [cant], 0
	jne cannot6Cont
	cmp [canKillBoss], 1
	je cannot7Cont
	jmp cannot6Cont
	
cannot3contHelp:
	jmp cannot3Cont
	
cannot5Help11:
	jmp cannot5
	
cannot6Cont:
	inc [boss_y]
	call checkNotOnFrame
	cmp [cant], 2
	je cannot9
	cmp [cant], 3
	je cannot9
	jmp done4

cannot7:
	movByte boss_x, x_temp
	movByte boss_y, y_temp
	cmp [cant], 0
	jne cannot7Cont
	cmp [canKillBoss], 1
	je cannot6Cont
	jmp cannot7Cont
	
cannot7Cont:
	dec [boss_y]
	call checkNotOnFrame
	cmp [cant], 2
	je cannot5
	cmp [cant], 3
	je cannot5
	jmp done4
	
cannot5ContHelp:
	jmp cannot5Cont
	
cannot7Help1:
	jmp cannot7
	
cannot6Help1:
	jmp cannot6
	
cannot8:
	movByte boss_x, x_temp
	movByte boss_y, y_temp
	cmp [cant], 0
	jne cannot8Cont
	cmp [canKillBoss], 1
	je cannot3Cont

cannot8Cont:
	dec [boss_x]
	dec [boss_y]
	call checkNotOnFrame
	cmp [cant], 1
	je cannot7
	cmp [cant], 2
	je cannot9
	cmp [cant], 3
	je cannot6
	jmp done4
	
cannot9:
	movByte boss_x, x_temp
	movByte boss_y, y_temp
	cmp [cant], 0
	jne cannot9Cont
	cmp [canKillBoss], 1
	je cannot5Cont

cannot9Cont:
	dec [boss_x]
	call checkNotOnFrame
	cmp [cant], 1
	je cannot7
	cmp [cant], 3
	je cannot7
	jmp done4
	
done4:
	popa
	ret
endp calcBossCords

;checks if the boss is on the frame and in which part of it
proc checkNotOnFrame
	pusha
	mov [cant], 0
	setCords boss_x, boss_y
	call readScreenChr
	cmp [screenChr], 186
	je blocked15
	cmp [screenChr], 205
	je blocked16
	cmp [screenChr], 201
	je blocked14
	cmp [screenChr], 200
	je blocked14
	cmp [screenChr], 187
	je blocked14
	cmp [screenChr], 188
	je blocked14
	jmp end1
	
blocked14:
	mov [cant], 3
	jmp end1
	
blocked15:
	mov [cant], 1
	jmp end1
	
blocked16:
	mov [cant], 2
	jmp end1
	
end1:
	popa
	ret
endp checkNotOnFrame

;prc that check if the temp cords are on the snake
proc checkNotOnSnake
	pusha
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

;proc that checks if the snake is on the portal1 and portal2 then moves the snake to the other portal's position
proc checkOnPortal
	pusha
	cmpByte parts_x, portal1_x
	je check2
	jmp check3

check2:
	cmpByte parts_y, portal1_y
	jne check3
	movByte parts_x, portal2_x
	movByte parts_y, portal2_y
	jmp @@finish
	
check3:
	cmpByte parts_x, portal2_x
	je check4
	jmp @@finish
	
check4:
	cmpByte parts_y, portal2_y
	jne @@finish
	movByte parts_x, portal1_x
	movByte parts_y, portal1_y
	
@@finish:
	popa
	ret
endp checkOnPortal

;proc that checks if the snake is on the portal3 and portal4 then moves the snake to the other portal's position
proc checkOnPortal1
	pusha
	;check if the x cord equals
	cmpByte parts_x, portal3_x
	je check7
	jmp check6

check7:
	;check if the y cord equals
	cmpByte parts_y, portal3_y
	jne check6
	movByte parts_x, portal4_x
	movByte parts_y, portal4_y
	jmp @@finish
	
check6:
	;check if the x cord equals
	cmpByte parts_x, portal4_x
	je check5
	jmp finish
	
check5:
	;check if the x cord equals
	cmpByte parts_y, portal4_y
	jne finish
	movByte parts_x, portal3_x
	movByte parts_y, portal3_y
	
@@finish:
	popa
	ret
endp checkOnPortal1

;proc that prints the score
proc print_score
	pusha
	cmp [lost], 1
	jne @@normal
	;sets cursor on the corner
	mov dh, 5 ; row
	mov dl, 25 ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	jmp @@continue
@@normal:
	;sets cursor on the corner
	mov dh, 23 ; row
	mov dl, 35 ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
@@continue:
	mov ax, [snakeLen]
	sub ax, 2
	div [ten]
	add ax, '00'
	mov dx, ax
	;print char
	mov ah, 2h
	int 21h
	mov dl, dh
	;print char
	mov ah, 2h
	int 21h
	popa
	ret
endp print_score

;proc that resets all the imprtant variables to their starting position
proc resetVariables
	mov [currentNote], 0
	mov [bossCreated], 0 
	mov [canKillBoss], 0
	mov [bossDead], 0
	mov [boss_x], 1
	mov [boss_y], 10
	mov [lost], 0
	mov [quit], 0
	mov [snakeLen], 2
	mov [dir], 'r'
	mov [parts_y], 10
	mov [parts_y+1], 10
	mov [parts_y+2], 10
	mov [parts_x], 6
	mov [parts_x+1], 6
	mov [parts_x+2], 5
	ret
endp resetVariables

;proc that draws the boss and the portals
proc drawBossAndPorals
	pusha
	setCords portal1_x, portal1_y
	mov [color], LIGHT_BLUE
	mov [charac], 048
	call drawApple
	
	setCords portal2_x, portal2_y
	mov [color], LIGHT_BLUE
	mov [charac], 048
	call drawApple
	
	setCords portal3_x, portal3_y
	mov [color], LIGHT_BLUE
	mov [charac], 048
	call drawApple
	
	setCords portal4_x, portal4_y
	mov [color], LIGHT_BLUE
	mov [charac], 048
	call drawApple
	
	cmp [snakeLen], 12
	jne continue9Help
	cmp [bossCreated], 1
	je continue9Help
	
	setCords boss_x, boss_y
	mov [color], RED
	mov [charac], 2
	call drawApple
	mov [bossCreated], 1
	
continue9Help:
	jmp continue9
	
printFood55:
	drawObject x_temp, y_temp, WHITE, 21
	call drawApple
	
continue9:
	popa
	ret
endp drawBossAndPorals