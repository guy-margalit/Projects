;the game starts by entering graphic mode
;then the I print the openning picture
;after the user enters a character I refresh the graphic mode and print the frame
;I initiate the cursor and start the main game loop 
;first I check if anyone won then I check where the player pressed and paint X or O according to the player that's playng
;then I repaint all the X and O [because they might be slightly deleted due to the cursor]
IDEAL
MODEL small
STACK 100h
p186
DATASEG
; --------------------------
chr db 0 
x_coordinate dw 0
y_coordinate dw 0
x_cord db 0
y_cord db 0
topLeftPlayer db 0
topRightPlayer db 0
topMiddlePlayer db 0
middleLeftPlayer db 0
middleMiddlePlayer db 0
middleRightPlayer db 0
bottomLeftPlayer db 0
bottomRightPlayer db 0
bottomMiddlePlayer db 0
repainting db 0
player db 0
winner db 0
color dw 0Fh
picture db 0
instructionsPic db 'instruc.bmp',0
mainMenuPic db 'menu.bmp',0
tiePic db 'tie.bmp',0
xwonPic db 'xwon.bmp',0
owonPic db 'owon.bmp',0
filehandle dw ?
Header db 54 dup (0)
Palette db 256*4 dup (0)
ScrLine db 320 dup (0)
ErrorMsg db 'Error', 13, 10,'$'
; x and y ccordinates of image
x_coord dw 0
y_coord dw 200
image_height dw 200
image_width	dw 320
diff dw ?
openingScreen db'                                             ',10,13
			db'  ____  ____  ___    ____   __    ___    ____  _____  ____ ',10,13
            db' (_  _)(_  _)/ __)  (_  _) /__\  / __)  (_  _)(  _  )( ___)',10,13
            db'   )(   _)(_( (__     )(  /(__)\( (__     )(   )(_)(  )__) ',10,13
            db'  (__) (____)\___)   (__)(__)(__)\___)   (__) (_____)(____)',10,13
			db'                      made by ARI STEIN                    ',10,13
			db'                                              ',10,13,'$'
Frame  db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
       db '            ',186,'             ',186,'            ',10,13
	   db 12 dup (205),206,13 dup (205),206,12 dup (205) ,10,13	
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db 12 dup (205),206,13 dup (205),206,12 dup (205) ,10,13	   
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13
	   db '            ',186,'             ',186,'            ',10,13,'$'
; --------------------------
CODESEG
;proc that 
proc printString
	mov ah, 9h
	int 21h ;interrupt that displays a string
	ret
endp printString
;sets the cursor location
proc setCursorePosition
    pusha
	; print chararcter
	; set cursore location
	mov dh, [y_cord] ; row
	mov dl, [x_cord] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret
endp setCursorePosition
proc OpenFile
	;Open image file file
	mov ah, 3Dh
	xor al, al
	cmp [picture], 0
	je @@main
	mov dx, offset instructionsPic
	jmp @@continue
@@main:
	mov dx, offset mainMenuPic
@@continue:
	int 21h
	jc @@openerror
	mov [filehandle], ax
	ret
@@openerror:
	mov dx, offset ErrorMsg
	mov ah, 9h
	int 21h
	ret
endp OpenFile

proc OpenFileEnd
	;Open image file file
	mov ah, 3Dh
	xor al, al
	cmp [winner], 1
	je @@Owon
	cmp [winner], 2
	je @@Xwon
	mov dx, offset tiePic
	jmp @@continue
@@Owon:
	mov dx, offset owonPic
	jmp @@continue
@@Xwon:
	mov dx, offset xwonPic
	jmp @@continue
@@continue:
	int 21h
	jc @@openerror
	mov [filehandle], ax
	ret
@@openerror:
	mov dx, offset ErrorMsg
	mov ah, 9h
	int 21h
	ret
endp OpenFileEnd

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

proc ReadHeader
; Read BMP file header, 54 bytes
	mov ah,3fh
	mov bx, [filehandle]
	mov cx,54
	mov dx,offset Header
	int 21h
	ret
endp ReadHeader

proc ReadPalette
; Read BMP file color palette, 256 colors * 4 bytes (400h)
	mov ah,3fh
	mov cx,400h
	mov dx,offset Palette
	int 21h
	ret
endp ReadPalette

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
	;(There is a null chr. after every color.)
	loop PalLoop
	ret
endp CopyPal

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

proc openning
	mov [picture], 0
@@print:
	;Process BMP file
	call OpenFile
	call ReadHeader
	call ReadPalette
	call CopyPal
	call CopyBitmap
	call CloseFile
	call readChr
	cmp [chr], 'i'
	je @@instructions
	ret
@@instructions:
	mov [picture], 1
	mov ax, 13h
	int 10h
	jmp @@print
	ret
endp openning
proc printEnd
	mov ax, 13h
	int 10h
	;Process BMP file
	call OpenFileEnd
	call ReadHeader
	call ReadPalette
	call CopyPal
	call CopyBitmap
	call CloseFile
	call readChr
	ret
endp printEnd
;draws the character on the screen
proc drawCharacter
    pusha
	call setCursorePosition
	; draw smiley - ascii 2 at cursor position
	mov ah, 9
	mov al, 219 ; aL = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	cmp [repainting], 1
	je @@finish
	call delayDraw
@@finish:
	popa
	ret
endp drawCharacter
; reads a character into chr
proc readChr
	; waits for character
	mov ah, 0h
	int 16h
	mov [chr], al ; save character to [chr]
	ret
endp readChr
;Proc that draws a Circle
proc drawO
	pusha
	call drawCharacter
	inc [x_cord]
	call drawCharacter
	inc [x_cord]
	call drawCharacter
	inc [x_cord]
	inc [y_cord]
	call drawCharacter
	inc [y_cord]
	call drawCharacter
	inc [y_cord]
	call drawCharacter
	dec [x_cord]
	inc [y_cord]
	call drawCharacter
	dec [x_cord]
	call drawCharacter
	dec [x_cord]
	call drawCharacter
	dec [x_cord]
	dec [y_cord]
	call drawCharacter
	dec [y_cord]
	call drawCharacter
	dec [y_cord]
	call drawCharacter
	popa
	ret
endp drawO
;Proc that draws the X
proc drawX
	pusha
	call drawCharacter
	mov cx, 4
	
@@print1:
	inc [x_cord]
	inc [y_cord]
	call drawCharacter
	loop @@print1
	sub [y_cord], 4
	call drawCharacter
	mov cx, 4
	
@@print2:
	dec [x_cord]
	inc [y_cord]
	call drawCharacter
	loop @@print2
	popa
	ret
endp drawX
proc delayDraw
	pusha
	mov cx, 01h ; High Word
	mov dx, 0h ; Low Word
	mov al, 0
	mov ah, 86h ; Wait
	int 15h
	popa
	ret
endp delayDraw
;Draws in the Top Left tile.
proc topLeft
	pusha
	mov [x_cord], 4
	mov [y_cord], 1
	cmp [topLeftPlayer], 1
	je @@cant1
	cmp [topLeftPlayer], 2
	je @@cant2
	cmp [player], 1
	je @@circle
	call drawX
	mov [topLeftPlayer], 2
	mov [player], 1
	jmp @@finish
	
@@circle:
	call drawO
	mov [topLeftPlayer], 1
	mov [player], 2
	jmp @@finish
	
@@cant1:
	call drawO
	jmp @@finish

@@cant2:
	call drawX
	jmp @@finish
	
@@finish:
	popa
	ret
endp topLeft
;Draws in the Top Middle tile.
proc topMiddle
	pusha
	mov [x_cord], 17
	mov [y_cord], 1
	cmp [topMiddlePlayer], 1
	je @@cant1
	cmp [topMiddlePlayer], 2
	je @@cant2
	cmp [player], 1
	je @@circle
	call drawX
	mov [topMiddlePlayer], 2
	mov [player], 1
	jmp @@finish
	
@@circle:
	call drawO
	mov [topMiddlePlayer], 1
	mov [player], 2
	jmp @@finish
	
@@cant1:
	call drawO
	jmp @@finish

@@cant2:
	call drawX
	jmp @@finish
	
@@finish:
	popa
	ret
endp topMiddle
proc topRight
	pusha
	mov [x_cord], 31
	mov [y_cord], 1
	cmp [topRightPlayer], 1
	je @@cant1
	cmp [topRightPlayer], 2
	je @@cant2
	cmp [player], 1
	je @@circle
	call drawX
	mov [topRightPlayer], 2
	mov [player], 1
	jmp @@finish
	
@@circle:
	call drawO
	mov [topRightPlayer], 1
	mov [player], 2
	jmp @@finish
	
@@cant1:
	call drawO
	jmp @@finish

@@cant2:
	call drawX
	jmp @@finish
	
@@finish:
	popa
	ret
endp topRight
;Draws in the Top Right tile.
proc middleLeft
	pusha
	mov [x_cord], 4
	mov [y_cord], 9
	cmp [middleLeftPlayer], 1
	je @@cant1
	cmp [middleLeftPlayer], 2
	je @@cant2
	cmp [player], 1
	je @@circle
	call drawX
	mov [middleLeftPlayer], 2
	mov [player], 1
	jmp @@finish
	
@@circle:
	call drawO
	mov [player], 2
	mov [middleLeftPlayer], 1
	jmp @@finish
	
@@cant1:
	call drawO
	jmp @@finish

@@cant2:
	call drawX
	jmp @@finish
	
@@finish:
	popa
	ret
endp middleLeft
proc middleMiddle
	pusha
	mov [x_cord], 17
	mov [y_cord], 9
	cmp [middleMiddlePlayer], 1
	je @@cant1
	cmp [middleMiddlePlayer], 2
	je @@cant2
	cmp [player], 1
	je @@circle
	call drawX
	mov [middleMiddlePlayer], 2
	mov [player], 1
	jmp @@finish
	
@@circle:
	call drawO
	mov [middleMiddlePlayer], 1
	mov [player], 2
	jmp @@finish
	
@@cant1:
	call drawO
	jmp @@finish

@@cant2:
	call drawX
	jmp @@finish
	
@@finish:
	popa
	ret
endp middleMiddle
proc middleRight
	pusha
	mov [x_cord], 31
	mov [y_cord], 9	
	cmp [middleRightPlayer], 1
	je @@cant1
	cmp [middleRightPlayer], 2
	je @@cant2
	cmp [player], 1
	je @@circle
	call drawX
	mov [middleRightPlayer], 2
	mov [player], 1
	jmp @@finish
	
@@circle:
	call drawO
	mov [middleRightPlayer], 1
	mov [player], 2
	jmp @@finish
	
@@cant1:
	call drawO
	jmp @@finish

@@cant2:
	call drawX
	jmp @@finish
	
@@finish:
	popa
	ret
endp middleRight
proc bottomLeft
	pusha
	mov [x_cord], 4
	mov [y_cord], 18
	cmp [bottomLeftPlayer], 1
	je @@cant1
	cmp [bottomLeftPlayer], 2
	je @@cant2
	cmp [player], 1
	je @@circle
	call drawX
	mov [bottomLeftPlayer], 2
	mov [player], 1
	jmp @@finish
	
@@circle:
	call drawO
	mov [bottomLeftPlayer], 1
	mov [player], 2
	jmp @@finish
	
@@cant1:
	call drawO
	jmp @@finish

@@cant2:
	call drawX
	jmp @@finish
	
@@finish:
	popa
	ret
endp bottomLeft
proc bottomMiddle
	pusha
	mov [x_cord], 17
	mov [y_cord], 18
	cmp [bottomMiddlePlayer], 1
	je @@cant1
	cmp [bottomMiddlePlayer], 2
	je @@cant2
	cmp [player], 1
	je @@circle
	call drawX
	mov [bottomMiddlePlayer], 2
	mov [player], 1
	jmp @@finish
	
@@circle:
	call drawO
	mov [bottomMiddlePlayer], 1
	mov [player], 2
	jmp @@finish
	
@@cant1:
	call drawO
	jmp @@finish

@@cant2:
	call drawX
	jmp @@finish
	
@@finish:
	popa
	ret
endp bottomMiddle
proc bottomRight
	pusha
	mov [x_cord], 31
	mov [y_cord], 18
	cmp [bottomRightPlayer], 1
	je @@cant1
	cmp [bottomRightPlayer], 2
	je @@cant2
	cmp [player], 1
	je @@circle
	call drawX
	mov [bottomRightPlayer], 2
	mov [player], 1
	jmp @@finish
	
@@circle:
	call drawO
	mov [bottomRightPlayer], 1
	mov [player], 2
	jmp @@finish
	
@@cant1:
	call drawO
	jmp @@finish

@@cant2:
	call drawX
	jmp @@finish
	
@@finish:
	popa
	ret
endp bottomRight
proc checkWhere
	pusha
	; read cursor location
	mov [x_coordinate], cx
	shr [x_coordinate], 1
	mov [y_coordinate], dx
	cmp [x_coordinate], 104
	jle check2
	cmp [x_coordinate], 208
	jle check3
	cmp [y_coordinate], 56
	jle topRightPress
	cmp [y_coordinate], 120
	jle middleRightPress
	call bottomRight
	jmp @@finish
	
check2:
	cmp [y_coordinate], 56
	jle topLeftPress
	cmp [y_coordinate], 120
	jle middleLeftPress
	call bottomLeft
	jmp @@finish
	
check3:
	cmp [y_coordinate], 56
	jle topMiddlePress
	cmp [y_coordinate], 120
	jle middleMiddlePress
	call bottomMiddle
	jmp @@finish
	
topLeftPress:
	call topLeft
	jmp @@finish
	
topRightPress:
	call topRight
	jmp @@finish

middleLeftPress:
	call middleLeft
	jmp @@finish
	
middleMiddlePress:
	call middleMiddle
	jmp @@finish
	
middleRightPress:
	call middleRight
	jmp @@finish
	
topMiddlePress:
	call topMiddle
	jmp @@finish
	
@@finish:
	popa
	ret
endp checkWhere
proc repaint	
	pusha
	mov [repainting], 1
	cmp [topLeftPlayer], 0
	je next1
	call topLeft
	
next1:
	cmp [topMiddlePlayer], 0
	je next2
	call topMiddle
	
next2:
	cmp [topRightPlayer], 0
	je next3
	call topRight
	
next3:
	cmp [middleLeftPlayer], 0
	je next4
	call middleLeft
	
next4:
	cmp [middleMiddlePlayer], 0
	je next5
	call middleMiddle
	
next5:
	cmp [middleRightPlayer], 0
	je next6
	call middleRight
	
next6:
	cmp [middleLeftPlayer], 0
	je next7
	call middleLeft
	
next7:
	cmp [bottomMiddlePlayer], 0
	je next8
	call bottomMiddle
	
next8:
	cmp [bottomLeftPlayer], 0
	je next9
	call bottomLeft
	
next9:
	cmp [bottomRightPlayer], 0
	je @@finish
	call bottomRight
	
@@finish:
	mov [repainting], 0
	popa
	ret
endp repaint
proc checkWin
	pusha
	mov al, [topLeftPlayer]
	cmp al, [topMiddlePlayer]
	jne nextCheck1
	cmp al, [topRightPlayer]
	jne nextCheck1
	cmp al, 0
	je nextCheck1
	mov [color], 0Ah
	call topLeft
	call topMiddle
	call topRight
	mov [winner], al
	jmp @@finish
	
nextCheck1:
	mov al, [middleLeftPlayer]
	cmp al, [middleMiddlePlayer]
	jne nextCheck2
	cmp al, [middleRightPlayer]
	jne nextCheck2
	cmp al, 0
	je nextCheck2
	mov [color], 0Ah
	call middleLeft
	call middleMiddle
	call middleRight
	mov [winner], al
	jmp @@finish
	
nextCheck2:
	mov al, [bottomLeftPlayer]
	cmp al, [bottomMiddlePlayer]
	jne nextCheck3
	cmp al, [bottomRightPlayer]
	jne nextCheck3
	cmp al, 0
	je nextCheck3
	mov [color], 0Ah
	call bottomLeft
	call bottomMiddle
	call bottomRight
	mov [winner], al
	jmp @@finish
	
nextCheck3:
	mov al, [topLeftPlayer]
	cmp al, [middleLeftPlayer]
	jne nextCheck4
	cmp al, [bottomLeftPlayer]
	jne nextCheck4
	cmp al, 0
	je nextCheck4
	mov [color], 0Ah
	call topLeft
	call middleLeft
	call bottomLeft
	mov [winner], al
	jmp @@finish
	
nextCheck4:
	mov al, [topRightPlayer]
	cmp al, [middleRightPlayer]
	jne nextCheck5
	cmp al, [bottomRightPlayer]
	jne nextCheck5
	cmp al, 0
	je nextCheck5
	mov [color], 0Ah
	call bottomRight
	call middleRight
	call topRight
	mov [winner], al
	jmp @@finish
	
nextCheck5:
	mov al, [topMiddlePlayer]
	cmp al, [middleMiddlePlayer]
	jne nextCheck6
	cmp al, [bottomMiddlePlayer]
	jne nextCheck6
	cmp al, 0
	je nextCheck6
	mov [color], 0Ah
	call bottomMiddle
	call middleMiddle
	call topMiddle
	mov [winner], al
	jmp @@finish
	
nextCheck6:
	mov al, [topLeftPlayer]
	cmp al, [middleMiddlePlayer]
	jne nextCheck7
	cmp al, [bottomRightPlayer]
	jne nextCheck7
	cmp al, 0
	je nextCheck7
	mov [color], 0Ah
	call topLeft
	call middleMiddle
	call bottomRight
	mov [winner], al
	jmp @@finish
	
nextCheck7:
	mov al, [topRightPlayer]
	cmp al, [middleMiddlePlayer]
	jne checkTie
	cmp al, [bottomLeftPlayer]
	jne checkTie
	cmp al, 0
	je checkTie
	mov [color], 0Ah
	call topRight
	call middleMiddle
	call bottomLeft
	mov [winner], al
	jmp @@finish
	
checkTie:
	cmp [topLeftPlayer], 0
	je @@finish
	cmp [topMiddlePlayer], 0
	je @@finish
	cmp [topRightPlayer], 0
	je @@finish
	cmp [middleLeftPlayer], 0
	je @@finish
	cmp [middleMiddlePlayer], 0
	je @@finish
	cmp [middleRightPlayer], 0
	je @@finish
	cmp [bottomLeftPlayer], 0
	je @@finish
	cmp [bottomMiddlePlayer], 0
	je @@finish
	cmp [bottomRightPlayer], 0
	je @@finish
	
	mov [winner], 3
	
@@finish:
	popa
	ret
endp checkWin
start:
	mov ax, @data
	mov ds, ax
; --------------------------
	mov ax, 13h
	int 10h
	
	call openning
	
	mov ax, 13h
	int 10h
	
	mov dx, offset frame ;printing the board screen
	call printString
	
	; initiate cursor
	xor ax, ax
	int 33h
	
	;show cursor
	mov ax, 1h
	int 33h
	
mainGameLoop:
	call checkWin
	cmp [winner], 0
	jne won
	
	mov ax, 3h ;read mouse status and position
	int 33h
	
	cmp bx, 01h ;check left mouse click
	je check
	
	cmp bx, 03h ;check right & left mouse click
	je done
	
	jmp mainGameLoop
	
check:
	call checkWhere
	call repaint
	jmp mainGameLoop
	
won:
	call readChr
	
	; hide cursor
	mov ax, 2h
	int 33h

	; back to text mode
	mov ax, 10h
	int 10h
	
	call printEnd
	
done:	
	; hide cursor
	mov ax, 2h
	int 33h

	; back to text mode
	mov ax, 2h
	int 10h
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
END start


