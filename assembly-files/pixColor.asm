IDEAL
MODEL small
STACK 100h
DATASEG
; --------------------------
	x_coordinate dw 50  	;  in column
	y_coordinate dw 20		; in line
	color dw 4				; pixel color

; --------------------------
CODESEG


start:
	mov ax, @data
	mov ds, ax
; --------------------------
	; enter graphic mode
	mov ax, 13h
	int 10h
		
	;get pixel color - result is in al
	mov bh, 0h
	mov cx, [x_coordinate]
	mov dx, [y_coordinate]
	mov ah, 0dh
	int 10h


; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
END start


