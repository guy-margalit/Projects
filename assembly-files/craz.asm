IDEAL
MODEL small
STACK 100h
p186
DATASEG
; --------------------------
openscreen db 10,13
db'    ___ _ __ __ _ ____   __ _  __ _ _ __ ___   ___   ',10,13
db'   / __  __/ _  |_  /  / _` |/ _` |  _ ` _ \ / _ \  ',10,13
db'   | (__| | | (_| |/ /  | (_| | (_| | | | | | |  __/ ',10,13
db'    \___|_|  \__,_/___|  \__, |\__,_|_| |_| |_|\___| ',10,13
db'                         __/ |                       ',10,13
db'                         |___/                       ',10,13
db'   THE CRAZ GAME ',10,13
db' ',10,13,'$'
student db 10,13	
db'MADE BY: Raz Zantkeren',10,13 
db'press any key to start the game, i to see the instruction and if u want to leave during the game press q',10,13,'$'
road db 10,13
	 db 40 dup (175),10,13
	 db 10,13
	 db 40 dup (175),10,13
	 db 10,13
	 db 40 dup (175),10,13
	 db 10,13
	 db 40 dup (175),10,13
	 db 10,13
	 db 40 dup (175),10,13
	 db 10,13
	 db 40 dup (175),10,13
	 db 10,13
	 db 40 dup (175),10,13
	 db 10,13
	 db 40 dup (175),10,13,'$'
x_cord db 0 ; column
y_cord db 0 ; row
x_cord1 db 0 ; column
y_cord1 db 0 ; row
color dw 0Eh ; color
bx_saver dw 0
count db 0
obstecaleCount dw 14 dup (1)
obstecale_x1 db 50 dup (0)
obstecale_x2 db 50 dup (0)
obstecale_x3 db 50 dup (0)
obstecale_x4 db 50 dup (0)
obstecale_x5 db 50 dup (0)
obstecale_x6 db 50 dup (0)
obstecale_x7 db 50 dup (0)
obstecale_x8 db 50 dup (0)
obstecale_x9 db 50 dup (0)
obstecale_x10 db 50 dup (0)
obstecale_x11 db 50 dup (0)
obstecale_x12 db 50 dup (0)
obstecale_x13 db 50 dup (0)
obstecale_x14 db 50 dup (0)
counter db 14 dup (0)
rnd db 14 dup (0)
chr db 0
new db 0
rand db 0
max_delay db 04h
ranOver db 175
lose db 10,13
db '___  _____ _       _    ____ ____ _____' ,10, 13 
db '\  \//  _ Y \ /\  / \  /  _ Y ___Y__ __\' ,10, 13 
db ' \  /| / \| | ||  | |  | / \|    \ / \ '  ,10, 13 
db ' / / | \_/| \_/|  | |_/\ \_/|___ | | | '  ,10, 13
db '/_/  \____|____/  \____|____|____/ \_/ '   ,10, 13,'$'				
; --------------------------

; consts
LEFT equ 75
UP equ 72
RIGHT equ 77
DOWN equ 80


CODESEG
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
	add al, 2
	mov [rand], al
	popa
	ret
endp random
proc movObstecale1
	pusha 
	lea bx, [obstecale_x1]
	mov [y_cord1], 2
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale1
proc movObstecale2
	pusha 
	lea bx, [obstecale_x2]
	mov [y_cord1], 3
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale2
proc movObstecale3
	pusha 
	lea bx, [obstecale_x3]
	mov [y_cord1], 5
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale3
proc movObstecale4
	pusha 
	lea bx, [obstecale_x4]
	mov [y_cord1], 6
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale4
proc movObstecale5
	pusha 
	lea bx, [obstecale_x5]
	mov [y_cord1], 8
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale5
proc movObstecale6
	pusha 
	lea bx, [obstecale_x6]
	mov [y_cord1], 9
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale6
proc movObstecale7
	pusha 
	lea bx, [obstecale_x7]
	mov [y_cord1], 11
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale7
proc movObstecale8
	pusha 
	lea bx, [obstecale_x8]
	mov [y_cord1], 12
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale8
proc movObstecale9
	pusha 
	lea bx, [obstecale_x9]
	mov [y_cord1], 14
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale9
proc movObstecale10
	pusha 
	lea bx, [obstecale_x10]
	mov [y_cord1], 15
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale10
proc movObstecale11
	pusha 
	lea bx, [obstecale_x11]
	mov [y_cord1], 17
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale11
proc movObstecale12
	pusha 
	lea bx, [obstecale_x12]
	mov [y_cord1], 18
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale12
proc movObstecale13
	pusha 
	lea bx, [obstecale_x13]
	mov [y_cord1], 20
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale13
proc movObstecale14
	pusha 
	lea bx, [obstecale_x14]
	mov [y_cord1], 21
	mov cx, 50
	
@@drawLoop:
	cmp [byte ptr bx], 0
	je @@finish1
	;go to obstecale place 
	mov al, [bx]
	mov [x_cord1], al
	call setCursorePosition1
	cmp [x_cord1], 39
	jne @@nojump
	;delete the character
	mov [color], 0h 
	mov al, 254
	call drawCharacter
	mov [byte ptr bx], 0
	jmp @@finish1
	
@@nojump:
	mov [color], 0h
	mov al, 254
	call drawCharacter
	inc [byte ptr bx]
	inc [x_cord1]
	call setCursorePosition1
	mov [color], 0Eh
	mov al, 254
	call drawCharacter
	
@@finish1:
	inc bx
	loop @@drawLoop
	
@@finish:
	popa
	ret
endp movObstecale14
proc createObstacle1
	pusha 
	lea si, [obstecale_x1]
	lea di, [counter]
	lea bx, [rnd]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount]
	add si, [word ptr bx]
	inc [word ptr bx]
	mov [byte ptr si], 1
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle1
proc createObstacle2
	pusha 
	lea si, [obstecale_x2]
	lea di, [counter+1]
	lea bx, [rnd+1]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount+1]
	add si, [word ptr bx]
	mov [byte ptr si], 1
	inc [word ptr bx]
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle2
proc createObstacle3
	pusha 
	lea si, [obstecale_x3]
	lea di, [counter+2]
	lea bx, [rnd+2]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount+2]
	add si, [word ptr bx]
	mov [byte ptr si], 1
	inc [word ptr bx]
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle3
proc createObstacle4
	pusha 
	lea si, [obstecale_x4]
	lea di, [counter+3]
	lea bx, [rnd+3]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount+3]
	add si, [word ptr bx]
	mov [byte ptr si], 1
	inc [word ptr bx]
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle4
proc createObstacle5
	pusha 
	lea si, [obstecale_x5]
	lea di, [counter+4]
	lea bx, [rnd+4]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount+4]
	add si, [word ptr bx]
	mov [byte ptr si], 1
	inc [word ptr bx]
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle5
proc createObstacle6
	pusha 
	lea si, [obstecale_x6]
	lea di, [counter+5]
	lea bx, [rnd+5]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount+5]
	add si, [word ptr bx]
	mov [byte ptr si], 1
	inc [word ptr bx]
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle6
proc createObstacle7
	pusha 
	lea si, [obstecale_x7]
	lea di, [counter+6]
	lea bx, [rnd+6]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount+6]
	add si, [word ptr bx]
	mov [byte ptr si], 1
	inc [word ptr bx]
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle7
proc createObstacle8
	pusha 
	lea si, [obstecale_x8]
	lea di, [counter+7]
	lea bx, [rnd+7]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount+7]
	add si, [word ptr bx]
	mov [byte ptr si], 1
	inc [word ptr bx]
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle8
proc createObstacle9
	pusha 
	lea si, [obstecale_x9]
	lea di, [counter+8]
	lea bx, [rnd+8]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount+8]
	add si, [word ptr bx]
	mov [byte ptr si], 1
	inc [word ptr bx]
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle9
proc createObstacle10
	pusha 
	lea si, [obstecale_x10]
	lea di, [counter+9]
	lea bx, [rnd+9]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount+9]
	add si, [word ptr bx]
	mov [byte ptr si], 1
	inc [word ptr bx]
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle10
proc createObstacle11
	pusha 
	lea si, [obstecale_x11]
	lea di, [counter+10]
	lea bx, [rnd+10]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount+10]
	add si, [word ptr bx]
	mov [byte ptr si], 1
	inc [word ptr bx]
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle11
proc createObstacle12
	pusha 
	lea si, [obstecale_x12]
	lea di, [counter+11]
	lea bx, [rnd+11]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount+11]
	add si, [word ptr bx]
	mov [byte ptr si], 1
	inc [word ptr bx]
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle12
proc createObstacle13
	pusha 
	lea si, [obstecale_x13]
	lea di, [counter+12]
	lea bx, [rnd+12]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount+12]
	add si, [word ptr bx]
	mov [byte ptr si], 1
	inc [word ptr bx]
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle13
proc createObstacle14
	pusha 
	lea si, [obstecale_x14]
	lea di, [counter+13]
	lea bx, [rnd+13]
	cmp [byte ptr di], 0
	jne @@continue
	call random
	mov al, [rand]
	mov [byte ptr bx], al
	jmp @@addToCounter
	
@@continue:
	mov al, [byte ptr di]
	cmp [byte ptr bx], al
	jne @@addToCounter
	lea bx, [obstecaleCount+13]
	add si, [word ptr bx]
	mov [byte ptr si], 1
	inc [word ptr bx]
	mov [byte ptr di], 0
	jmp @@finish
	
@@addToCounter:
	inc [byte ptr di]
	
@@finish:
	popa
	ret
endp createObstacle14
;print a string on the screen
proc printString
	pusha
	mov ah, 9h
	int 21h 
	popa
	ret
endp printString

	;read a character
proc readChr
	pusha
	mov ah, 0h
	int 16h
	
	cmp al, 'i'
	je @@char_key_pressed
	cmp al, 'q'
	je @@char_key_pressed
	
	; arrow key pressed
	mov [chr], ah
	jmp @@finish
	
	@@char_key_pressed:
		mov [chr], al
	
	@@finish:
		popa
		ret
endp readChr
; if key not pressed, [chr] = 0
proc readCharIfPressed
	pusha
	mov ah, 1
	int 16h
	jz @@no_key
	
@@key_available:
	call readChr
	jmp @@finish
	
@@no_key:
	mov [chr], 0
	
@@finish:
	popa
	ret
endp readCharIfPressed

;set Cursore Position
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
;set Cursore Position
proc setCursorePosition1
	pusha
	mov dh, [y_cord1] ; row
	mov dl, [x_cord1] ; column
	mov bh, 0 ; page number
	mov ah, 2
	int 10h
	popa
	ret
endp setCursorePosition1
;draw character
proc drawPlayer
	pusha
	mov [color], 0Eh
	mov al, 12
	call drawCharacter
	popa
	ret
endp drawPlayer

;delete the character
proc deleteCharacter
	pusha
	cmp [ranOver], 175
	je continue
	mov [color], 0h
	mov al, 12
	jmp continue1
	
continue:
	mov [color], 0Fh
	mov al, 175
	
continue1:
	call drawCharacter
	mov [ranOver], 12
	popa
	ret
endp deleteCharacter

;reads the char that is on the screen
proc readScreenChr 
	pusha
	mov bh, 0h ; Page=1
	mov ah, 08h ; Read character function
	int 10h ; return the character to al
	mov [ranOver], al ;move the character from al to screenChr
	popa
	ret
endp readScreenChr 

; arguments
; chracter to draw in al
proc drawCharacter
	pusha
	mov ah, 9
	;al = character to display
	mov bx, [color] ; bh = Background bl = Foreground
	mov cx, 1 ; cx = number of times to write character
	int 10h
	popa
	ret
endp drawCharacter

proc movecharacter 
	pusha	
	
	cmp [chr], LEFT
	je @@move_left
	cmp [chr], RIGHT
	je @@move_right
	cmp [chr], UP
	je @@move_up
	cmp [chr], DOWN
	je @@move_down
	
	jmp @@finish
	
	@@move_left:
		dec [x_cord]
		jmp @@finish
	@@move_right:
		inc [x_cord]
		jmp @@finish
	@@move_up:
		dec [y_cord]
		jmp @@finish	
	@@move_down:
		inc [y_cord]
		jmp @@finish
	
	@@finish:
		popa
		ret
endp movecharacter
proc moveAllObstecales
	pusha
	call createObstacle1
	call createObstacle2
	call createObstacle3
	call createObstacle4
	call createObstacle5
	call createObstacle6
	call createObstacle7
	call createObstacle8
	call createObstacle9
	call createObstacle10
	call createObstacle11
	call createObstacle12
	call createObstacle13
	call createObstacle14
	
	call movObstecale1
	call movObstecale2
	call movObstecale3
	call movObstecale4
	call movObstecale5
	call movObstecale6
	call movObstecale7
	call movObstecale8
	call movObstecale9
	call movObstecale10
	call movObstecale11
	call movObstecale12
	call movObstecale13
	call movObstecale14
	popa
	ret
endp moveAllObstecales
;doing delay
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
start:
	mov ax, @data
	mov ds, ax
; --------------------------
	
	;print the openning screen
	mov dx, offset openscreen
	call printString
	
	;prints the name of the creator: me
	mov dx, offset student
	call printString
	
	;waits for character
	call readChr
	
	;clear the screen by entering graphic mode 40*25
	mov ax, 13h
	int 10h
	
	;prints the road of the game
	mov dx, offset road
	call printString
	
	;check if user asks to quit
    cmp al, 'q'
    je end_game
	
	;draws the player at his start position
	mov [x_cord], 20
	mov [y_cord], 22
	call setCursorePosition
	call drawPlayer
	
	call moveAllObstecales
	
	call readChr
	
mainGameLoop:
	;check if there is a chracter to read and reads a character
	call readCharIfPressed
	
	;check if user asks to quit
	cmp [chr], 'q'
	je end_game
	
	;moves the player by:
	call setCursorePosition ;setting the cursore to the player
	call deleteCharacter ;deleting
	call movecharacter ;finding the next location
	call setCursorePosition ;puting the cursore on the next location
	call readScreenChr ;reading the back character
	call drawPlayer	;and drawing the player
	
	call moveAllObstecales
	
;calls delay and moves to the next turn
main_game_loop_iteration_end:
	call delay
	jmp maingameloop
	
end_game:
	;text  mode
	mov ax, 2h
	int 10h
	mov dx, offset lose
	;print a string on the screen
	call printString
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
END start