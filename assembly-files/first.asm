
IDEAL
MODEL small
STACK 100h
DATASEG
CODESEG
start:
	mov ax, @data
	mov ds, ax
mov [00], 3
mov [01], 4
mov al, [01]
mov ah, [00]
exit:
	mov ax, 4c00h
	int 21h
END start
