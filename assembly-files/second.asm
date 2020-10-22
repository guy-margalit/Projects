IDEAL
MODEL small
STACK 100h
DATASEG
CODESEG
start:
	mov ax, @data
	mov ds, ax
mov bx, 0
mov cx, 0
mov ax, 1234h
mov bl, ah
mov ch, al	
exit:
	mov ax, 4c00h
	int 21h
END start
