IDEAL
MODEL small
STACK 100h
jumps
p186
DATASEG
; --------------------------
; Your variables here

	
open_screen db '                                                                             ',10,13              
			db '	  _____ _____  ________ ____             _____ _____  ________ ____      ',10,13
			db '	 /     \\__  \ \___   // __ \   ______  /     \\__  \ \___   // __ \     ',10,13
			db '	|  Y Y  \/ __ \_/    /\  ___/  /_____/ |  Y Y  \/ __ \_/    /\  ___/     ',10,13
			db '	|__|_|  (____  /_____ \\___  >         |__|_|  (____  /_____ \\___  >    ',10,13
			db '		  \/     \/      \/    \/                \/     \/      \/    \/     ',10,13
			db '                                                                             ',10,13
			db '      press p to play the best game on the market!                           ',10,13
			db '      press Esc to exit                                                      ',10,13
			db '      instructions: get out of the maze using the up,down,left,right buttons ',10,13
			db '                                                                             ',10,13,'$'
	 
won db '                .__ ',10,13        
	db ' __ __  __  _  _|__| ____ ' ,10,13 
	db '|  |  \ \ \/ \/ /  |/    \  ',10,13 
	db '|  |  /  \     /|  |   |  \ ',10,13 
	db '|____/    \/\_/ |__|___|  / ',10,13 
	db '                        \/  ',10,13,'$'


mumu db '+++++++++++++++++++++++++++++++   +++++',10,13
	 db '+   +   +       +  +                  +',10,13
	 db '+       +   +           +     +   +   +',10,13
	 db '+   +      +++++++++  +++++++++   +   +',10,13
	 db '+   ++++++  +         +       +   +   +',10,13
	 db '+   +   +   ++++++++     ++++++   +   +',10,13
	 db '++++++++++    ++++++++   ++   +++++++++',10,13
	 db '+       ++++  +++++    ++++ + + + +   +',10,13
	 db '++++++   ++++      ++++   ++++++++    +',10,13
	 db '++++++++++++++++ +  +++++     ++++++  +',10,13
	 db '+++++++++++++++    +++++++  +++++  ++++',10,13
	 db '++++++++++++++++++   +    ++     +    +',10,13
	 db '+   ++  +++    +   +  +  ++++    ++   +',10,13
	 db '++   +      +    ++++++     +++    ++++',10,13
	 db '++++   +++    +++++     +++       ++  +',10,13
	 db '+   +++    +        ++++     +++      +',10,13
	 db '+     + + + + + + + + + +   + + + ++ ++',10,13
	 db '+ + ++ + + ++ ++ + + + +   + + +   ++++',10,13
	 db '+       +   +    +++++  + +  +        +',10,13
	 db '+++++++++++++++++++++++++++++xxxx++++++',10,13,'$'
	 
	 
	
;setting the marker on the screen
	y_column db 0
	x_column db 32
	colour db 11 ;light cyan
	lost db 0
	
	
; --------------------------
CODESEG
proc Cursor_Location ;place the cursor on the screen
	mov bh, 0
	mov dh, [y_column] ;in row
	mov dl, [x_column]
	mov ah, 2
	int 10h
	ret
endp Cursor_Location
 
proc DrawPlayer ;draw player in cursor position
	mov ah, 9
	mov al, 2  ;Al=character to display
	mov bh, 0h ;BH=page
	mov bl, [colour] ;BL=foreground
	mov cx, 1 ;number of times to write character
	int 10h ;bois-> show the character
	ret
endp DrawPlayer

proc RightKeyPress
	inc [x_column]
	call Cursor_Location ;move cursor to new place
	;check the character on coordinates
	mov bh, 0h ;page=1
	mov ah, 08h ;read character function
	int 10h ;return the character value to AL
	cmp al, '+'
	jne MovePlayerRight ;jump to draw player
	dec [x_column]
	call Cursor_Location
	jmp EndRightKeyPress
	
MovePlayerRight:
	dec [x_column]
	call Cursor_Location ;return cursor to player position
	mov [colour], 0
	call DrawPlayer
	add [x_column], 1
	mov [colour], 11
	call Cursor_Location
	call DrawPlayer
EndRightKeyPress:
	ret
endp RightKeyPress

proc LeftKeyPress
	dec [x_column]
	call Cursor_Location ;move cursor to new place
	;check the character on coordinates
	mov bh, 0h ;page=1
	mov ah, 08h ;read character function
	int 10h ;return the character value to AL
	cmp al, '+'
	jne MovePlayerLeft ;jump to draw player
	inc [x_column]
	call Cursor_Location
	jmp EndLeftKeyPress
	
MovePlayerLeft:
	inc [x_column]
	call Cursor_Location ;return cursor to player position
	mov [colour], 0
	call DrawPlayer
	dec [x_column]
	mov [colour], 11
	call Cursor_Location
	call DrawPlayer
EndLeftKeyPress:
	ret
endp LeftKeyPress

proc UpKeyPress
;if the player is in the start position
;dont go up
	cmp [x_column], 32
	je continue1
	cmp [x_column], 31
	je continue1
	cmp [x_column], 33
	je continue1
	jmp continue
continue1:
	cmp [y_column], 0
	jne continue
	jmp EndUpKeyPress
	
continue:
	dec [y_column]
	call Cursor_Location ;move cursor to new place
	;check the character on coordinates
	mov bh, 0h ;page=1
	mov ah, 08h ;read character function
	int 10h ;return the character value to AL
	cmp al, '+'
	jne MovePlayerUp ;jump to draw player
	inc [y_column]
	call Cursor_Location
	jmp EndUpKeyPress
	
MovePlayerup:
	inc [y_column]
	call Cursor_Location ;return cursor to player position
	mov [colour], 0
	call DrawPlayer
	sub [y_column], 1 ;can i just write inc y_column?-------------------------
	mov [colour], 11
	call Cursor_Location
	call DrawPlayer
EndUpKeyPress:
	ret
endp UpKeyPress

proc DownKeyPress
	pusha 
	inc [y_column]
	call Cursor_Location ;move cursor to new place
	;check the character on coordinates
	mov bh, 0h ;page=1
	mov ah, 08h ;read character function
	int 10h ;return the character value to AL 
	cmp al, 'x'
	je lostCheck
	cmp al, '+'
	jne MovePlayerDown ;jump to draw player
	dec [y_column]
	call Cursor_Location
	jmp EndDownKeyPress
	
MovePlayerDown:
	dec [y_column]
	call Cursor_Location ;return cursor to player position
	mov [colour], 0
	call DrawPlayer
	add [y_column], 1
	mov [colour], 11
	call Cursor_Location
	call DrawPlayer
	jmp EndDownKeyPress
lostCheck:
	mov [lost], 1
EndDownKeyPress:
	popa
	ret
endp DownKeyPress

proc checkLost
	pusha
	cmp al, 'x'
	je yes
	jmp endCheck
yes:
	mov [lost], 1
endCheck:
	popa
	ret
endp checkLost
start:
	mov ax, @data
	mov ds, ax
;---------------------------
;your code here

;entering text mode for opening screen
	mov al, 03h
	mov ah, 0
	int 10h

; print open screen to screen
	mov dx, offset open_screen
	mov ah, 9h
	int 21h
	
WaitForCharacter:
	mov ah, 0h
	int 16h
	
;was Esc pressed?
	cmp al, 27
	je the_End
	
;was P pressed?
	cmp al, 'p'
	je play
	
	jmp WaitForCharacter
	
play:
	
;enter text mode 40x25 (x,y)
	mov al, 013h
	mov ah, 0
	int 10h
	
;print string to screen
	mov dx, offset mumu
	mov ah, 9h
	int 21h
	

	call Cursor_Location
	call DrawPlayer
	  
	
move:
	cmp [lost],1 
	je the_End
;check type ahead buffer status
	mov ah, 1h
	int 16h
	jz Move
	
;wait for char
	mov ah, 0h
	int 16h
	
;was Esc pressed?
	cmp al, 27
	je the_End
	
;was right key pressed?
	cmp ah, 4dh
	je RightKey
	
;was left key pressed?
	cmp ah, 4bh
	je LeftKey
	
;was up key pressed?
	cmp ah, 48h
	je UpKey
	
;was down key pressed?
	cmp ah, 50h
	je DownKey
	
	jmp Move
	
RightKey:
	call RightKeyPress
	jmp Move
	
LeftKey:
	call LeftKeyPress
	jmp Move
	
UpKey:
	call UpKeyPress
	jmp Move
	
DownKey:
	call DownKeyPress
	jmp Move
	
	
the_End:
	mov ax, 13h
	int 10h
	
	mov dx, offset won
	mov ax, 9h
	int 21h
	
	mov ah, 0h
	int 16h
	
	mov ax, 2h
	int 10h
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
END start


