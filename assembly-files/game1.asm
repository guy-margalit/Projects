
IDEAL
MODEL small
STACK 100h
DATASEG
; --------------------------
x_cord db 11 
y_cord db 6 
color dw 0Eh 
openScreen db' ',10,13
db '      ____   _____/  |_     ' ,10, 13
db '     / ___\_/ __ \   __\      ' ,10, 13
db '    / /_/  >  ___/|  |        ' ,10, 13
db '    \___  / \___  >__|      ' ,10, 13
db '   /_____/      \/       ' ,10,13
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
student db' MADE BY: GUY' ,10,13
db' Press any key to continue' ,10,13,'$'
game  db '             The Bird Game             ',10,13,'$'
continue db'       Press any key to continue     ' ,10,13,'$'
frame  db '  ',201,,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,187,10,13  
db '  ',186,'VVVVVVVVVVVVVVVVVVVVVV',186,10,13
db '  ',186,'                      ',186,10,13
db '  ',186,'                      <',186,10,13
db '  ',186,'                      ',186,10,13
db '  ',186,'                      ',186,10,13
db '  ',186,'>                      ',186,10,13
db '  ',186,'                      ',186,10,13
db '  ',186,'                      ',186,10,13
db '  ',186,'                      <',186,10,13
db '  ',186,'                      ',186,10,13
db '  ',186,'                      ',186,10,13
db '  ',186,'>                      ',186,10,13
db '  ',186,'                      ',186,10,13
db '  ',186,'                      ',186,10,13
db '  ',186,'                      <',186,10,13
db '  ',186,'                      ',186,10,13
db '  ',186,'>                      ',186,10,13
db '  ',186,'                      ',186,10,13
db '  ',186,'                      ',186,10,13
db '  ',186,'^^^^^^^^^^^^^^^^^^^^^^',186,10,13
db '  ',200,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,188,10,13
CODESEG
start:
	mov ax, @data
	mov ds, ax
mov dx, offset openScreen 
mov ah, 9h
int 21h
mov dx, offset student 
mov ah, 9h
int 21h 
mov ah, 0h
int 16h	
mov ax, 13h
int 10h
mov dx, offset game
mov ah, 9h
int 21h
mov dx, offset frame
mov ah, 9h
int 21h
mov dx, offset continue
mov ah, 9h
int 21h
mov ah, 0h
int 16h
mov dh, [y_cord] 
mov dl, [x_cord] 
mov bh, 0 
mov ah, 2
int 10h
mov ah, 9
mov al, 2 
mov bx, [color]  
mov cx, 1 
int 10h
mov ah, 0h
int 16h
mov ax, 2h
int 10h
exit:
	mov ax, 4c00h
	int 21h
END start