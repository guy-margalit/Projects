

IDEAL
MODEL small
STACK 100h
DATASEG
CODESEG
start:
	mov ax, @data
	mov ds, ax
mov ax, 9876h
mov [00], ah
mov [01], al	
exit:
	mov ax, 4c00h
	int 21h
END start
