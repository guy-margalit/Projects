IDEAL
MODEL small
STACK 100h
DATASEG
; --------------------------
; Your variables here
logo db 'Welcome to ' 
db 10,13
db	'>>>>>>>>     >>>>>>>>>>     >>>>>>>>    >>>>>>>>>>>>>     '
db 10,13
db	'>>           >>     >>      >>    >>    >>                ' 
db 10,13
db	'>>>>>>>>     >>   >>        >>    >>    >>     >>>>>>>>>> '
db 10,13
db	'>>           >> >>          >>    >>    >>           >>>  '
db 10,13
db	'>>           >>     >>      >>>>>>>>    >>>>>>>>>>>>>>>>> $'

instructionsmsg db 10,13
db 10,13
db 'For instructions press I$'

gameovermsg db 10,13
db ' To start over press R'
db 10,13
db ' To quit, press Q$'

quitgameatbeginning db 10,13
db 10,13
db 'To quit press Q$'

startmsg db 10,13
db 10,13
db 'Choose level:'
db 10,13
db 10,13
db '1- Easy'
db 10,13
db '2- Medium'
db 10,13
db '3- Hard$'

instructions db 10,13
db '                                        MENU'
db 10,13
db 10,13
db 10,13
db 'Use the arrows to move the Frog'
db 10,13
db 'Up Arrow- Move Forward'
db 10,13
db 'Left Arrow- Move Left'
db 10,13
db 'Down Arrow- Move Backwards'
db 10,13
db 'Right Arrow- Move Right '
db 10,13
db 10,13
db 'Your goal is to get through the roads without being hit by the cars'
db 10,13
db 10,13
db 'Tip: Dont rush, take your time and wait for the right moment'
db 10,13
db 10,13
db 'Quick Note: If you want to quit in the middle of the game, press Q'
db 10,13
db 10,13
db 'To Start Play Choose a level:'
db 10,13
db 10,13
db '1- Easy'
db 10,13
db '2- Medium'
db 10,13
db '3- Hard$'

road db 10,13
db	'================================================================================'
db 10,13
db	'================================================================================'
db 10,13
db	'================================================================================'
db 10,13
db	'================================================================================'
db 10,13
db	'================================================================================$'

gameOver db 'sorry...'
db 10,13
db '>>>>>>>>>>       >>>>>>>>>>>     >>           >>     >>>>>>>>>> '                                                     
db 10,13
db '>>               >>>     >>>     >> >>     >>  >>     >>>       '          
db 10,13
db '>>   >>>>>>      >>>>>>>>>>>     >>    >>      >>     >>>>>>>>> '                  
db 10,13
db '>>        >>>    >>>     >>>     >>            >>     >>>       '  
db 10,13
db '>>>>>>>>>>>>>    >>>     >>>     >>            >>     >>>>>>>>> '                   
db 10,13
db 10,13
db 10,13
db '>>>>>>>>   >>              >>    >>>>>>>>>>    >>>>>>>>>'                                            
db 10,13
db '>>    >>     >>          >>      >>>           >>    >>'          
db 10,13
db '>>    >>       >>      >>        >>>>>>>>>>    >>  >>    '                          
db 10,13
db '>>    >>         >>  >>          >>>           >>    >>         '           
db 10,13
db '>>>>>>>>           >>             >>>>>>>>>>    >>      >>   $'                       

youWin db 'congratulations!'
db 10,13
db '>>          >>    >>>>>>>>>>>         >>            >>     '                                                
db 10,13
db '  >>      >>      >>       >>         >>            >>     '                            
db 10,13
db '      >,>          >>       >>         >>            >>     '                               
db 10,13
db '      >>          >>       >>         >>            >>     '                                
db 10,13
db '      >>          >>>>>>>>>>>         >>>>>>>>>>>>>>>>     '
db 10,13
db 10,13
db 10,13
db '>>                  >>    >>>>>>>>>>    >>               >> '                                           
db 10,13
db '>>                  >>        >         >>   >>          >> '                                   
db 10,13
db '>>        >>        >>        >         >>       >>      >> '                                 
db 10,13
db '>>   >>        >>   >>        >         >>           >>  >> '                                  
db 10,13
db '>>                  >>    >>>>>>>>>>    >>               >> '                          
db 10,13 
db '$'

columnFrog db 40
rowFrog db 9

columncar db 0
rowcar db 8

milsec db 0d
mstemp db 0d

colRow2 db 1,7,16,25,38,53,60,74
colRow4 db 5,12,20,34,50,56,65,78
colRow6 db 7,14,27,37,46,57,70,72
colRow8 db 9,17,25,30,42,51,59,63

interval db 1

note dw 3000h
; --------------------------
CODESEG
proc instructionss
	;clears screen and shows instructions message
	mov ah,0
	int 10h
	;call instructions message
	mov dx,offset instructions
	mov ah,9h
	int 21h
	ret
endp instructionss

proc gameSound
	;open speaker
	in al,61h
	or al,00000011b
	out 61h,al
	;play sound
	mov ax,[note]
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
	ret
endp gameSound


proc manageCars8							;this procedure moves every car on row number 8
	mov [rowCar],8		;Handling row no.8
	mov cl,[colRow8]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow8],cl	;move data back to variable

	
	mov [rowCar],8		;Handling row no.8
	mov cl,[colRow8+1]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow8+1],cl	;move data back to variable

	
	mov [rowCar],8		;Handling row no.8
	mov cl,[colRow8+2]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow8+2],cl	;move data back to variable
	
	
	mov [rowCar],8		;Handling row no.8
	mov cl,[colRow8+3]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow8+3],cl	;move data back to variable
	

	mov [rowCar],8		;Handling row no.8
	mov cl,[colRow8+4]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow8+4],cl	;move data back to variable


	mov [rowCar],8		;Handling row no.8
	mov cl,[colRow8+5]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow8+5],cl	;move data back to variable


	mov [rowCar],8		;Handling row no.8
	mov cl,[colRow8+6]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow8+6],cl	;move data back to variable


	mov [rowCar],8		;Handling row no.8
	mov cl,[colRow8+7]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow8+7],cl	;move data back to variable
	
ret
endp manageCars8


proc manageCars6							;this procedure moves every car on row number 6
	mov [rowCar],6		;Handling row no.6
	mov cl,[colRow6]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow6],cl	;move data back to variable

	
	mov [rowCar],6		;Handling row no.6
	mov cl,[colRow6+1]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow6+1],cl	;move data back to variable

	
	mov [rowCar],6		;Handling row no.6
	mov cl,[colRow6+2]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow6+2],cl	;move data back to variable
	
	
	mov [rowCar],6		;Handling row no.6
	mov cl,[colRow6+3]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow6+3],cl	;move data back to variable
	

	mov [rowCar],6		;Handling row no.6
	mov cl,[colRow6+4]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow6+4],cl	;move data back to variable


	mov [rowCar],6		;Handling row no.6
	mov cl,[colRow6+5]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow6+5],cl	;move data back to variable


	mov [rowCar],6		;Handling row no.6
	mov cl,[colRow6+6]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow6+6],cl	;move data back to variable


	mov [rowCar],6		;Handling row no.6
	mov cl,[colRow6+7]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow6+7],cl	;move data back to variable
	
ret
endp manageCars6

proc manageCars4							;this procedure moves every car on row number 4
	mov [rowCar],4		;Handling row no.4
	mov cl,[colRow4]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow4],cl	;move data back to variable

	
	mov [rowCar],4		;Handling row no.4
	mov cl,[colRow4+1]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow4+1],cl	;move data back to variable

	
	mov [rowCar],4		;Handling row no.4
	mov cl,[colRow4+2]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow4+2],cl	;move data back to variable
	
	
	mov [rowCar],4		;Handling row no.4
	mov cl,[colRow4+3]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow4+3],cl	;move data back to variable
	

	mov [rowCar],4		;Handling row no.4
	mov cl,[colRow4+4]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow4+4],cl	;move data back to variable


	mov [rowCar],4		;Handling row no.4
	mov cl,[colRow4+5]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow4+5],cl	;move data back to variable


	mov [rowCar],4		;Handling row no.4
	mov cl,[colRow4+6]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow4+6],cl	;move data back to variable


	mov [rowCar],4		;Handling row no.4
	mov cl,[colRow4+7]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow4+7],cl	;move data back to variable
	
ret
endp manageCars4

proc manageCars2							;this procedure moves every car on row number 2
	mov [rowCar],2		;Handling row no.2 
	mov cl,[colRow2]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow2],cl	;move data back to variable

	
	mov [rowCar],2		;Handling row no.2
	mov cl,[colRow2+1]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow2+1],cl	;move data back to variable

	
	mov [rowCar],2		;Handling row no.2
	mov cl,[colRow2+2]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow2+2],cl	;move data back to variable
	
	
	mov [rowCar],2		;Handling row no.2
	mov cl,[colRow2+3]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow2+3],cl	;move data back to variable
	

	mov [rowCar],2		;Handling row no.2
	mov cl,[colRow2+4]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow2+4],cl	;move data back to variable


	mov [rowCar],2		;Handling row no.2
	mov cl,[colRow2+5]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow2+5],cl	;move data back to variable


	mov [rowCar],2		;Handling row no.2
	mov cl,[colRow2+6]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow2+6],cl	;move data back to variable


	mov [rowCar],2		;Handling row no.2
	mov cl,[colRow2+7]	;Using registers to handle with variables
	mov [columncar],cl
	call movecar		;procedure to move car
	mov cl,[columncar]
	mov [colRow2+7],cl	;move data back to variable
	
ret
endp manageCars2





proc paintCar							;this procedure paints every car which moved and replaced in its new position
										;also it makes the car go to column no.1 if reached the end of the screen
	cmp [columncar],79
	jne skipresetcolumn
	mov [columncar],1			
skipresetcolumn:
	;set cursor in the position of the car
	mov dh,[rowcar]	;rowcar
	mov dl,[columncar] ;columncar
	mov bh,0			;page
	mov ah,2
	int 10h
	;paints car at cursor's position
	mov ah,9
	mov al,16	;ascii code of the car to display
	mov bh,0h	;page
	mov bl,1101b ;color pink
	mov cx,1	;number of times to display character
	int 10h
	;move cursor back to frog
	mov dh,[rowFrog]	;rowFrog
	mov dl,[columnFrog]	;columnFrog
	mov bh,0			;page
	mov ah,2
	int 10h
	
ret
endp paintCar

proc movecar							;this procedure deletes the car from its old position and calls the procedure paintCar
										; to move it to its new place and paint it. 
										;it also calls the procedure identifyImpact to tell if impact with the character was made while 
										;the character was waiting on the road where cars a driving and a car hit it.
	

	;set cursor in car's position
	mov dh,[rowcar]	;rowcar
	mov dl,[columncar] ;columncar
	mov bh,0			;page
	mov ah,2
	int 10h
	;set car at cursor's position
	mov ah,9
	mov al,16	;ascii code of the car to display
	mov bh,0h	;page
	mov bl,0000b ;color black
	mov cx,1	;number of times to display character
	int 10h
	add [columncar],1
	call paintCar
	call identifyImpact
	
ret
endp movecar



proc startGame							;this procedure starts the game by painting the roads 
										;and set the cursor position where the frog should be at the beggining.
	;clear screen and start game
	;clear screen
	mov ax,0003h
    int 10h
	;draws road
	mov dx,offset road
	mov ah,9h
	int 21h
	;set cursor position in the middle of the first row which determind in the variables section
	mov dh,[rowFrog]	;rowFrog
	mov dl,[columnFrog]	;columnFrog
	mov bh,0			;page
	mov ah,2
	int 10h
	;set character at cursor's position to begin game
	mov ah,9
	mov al,1	;ascii code of the character to display 
	mov bh,0h	;page
	mov bl,0010 ;color green
	mov cx,1	;number of times to display character
	int 10h
	ret
endp startGame


proc completeRoad							;this procedure paints a road every time the character moved to a new place on the safe roads.
	;set cursor to frog's old position
	mov dh,[rowFrog]	;rowFrog
	mov dl,[columnFrog]	;columnFrog
	mov bh,0		;page
	mov ah,2
	int 10h
	
								;checks if last frog's position was on a safe road and if so, 
								;paints the last position with the ascii of '=', if not, draws nothing
	cmp [rowFrog],9				
	je roadcomplete
	cmp [rowFrog],7
	je roadcomplete
	cmp [rowFrog],5
	je roadcomplete
	cmp [rowFrog],3
	je roadcomplete
	cmp [rowFrog],1
	je roadcomplete
	jne paintBlack

roadcomplete:
	;set character at cursor's position
	mov ah,9
	mov al,61	;ascii code of the character to display ('=')
	mov bl,0111b;color white
	mov bh,0h	;page
	mov cx,1	;number of times to display character
	int 10h
	jmp endprocRoadComplete

paintBlack:
	; set character at cursor's position
	mov ah,9
	mov al,0	;ascii code of an empty character to display ('')
	mov bl,0000b;color black
	mov bh,0h	;page
	mov cx,1	;number of times to display character
	int 10h
	
endprocRoadComplete:
	ret	
endp completeRoad

proc characterMovement							;this procedure moves the character (frog) and calls the procedure 
												;identifyImpact if the frog ran into a car that didnt move.
	;set cursor position
	mov dh,[rowFrog]	;new rowFrog
	mov dl,[columnFrog]	;new columnFrog
	mov bh,0			;page
	mov ah,2
	int 10h
	;set character at cursor's position
	mov ah,9
	mov al,1	;ascii code of the character to display
	mov bh,0h	;page
	mov bl,0010	;color green
	mov cx,1	;number of times to display character
	int 10h
	call identifyImpact 
ret
endp characterMovement

;///////////////////////////////////////////////////////////////////////
;///////////////// START Identify impact for arrays ////////////////////
;///////////////////////////////////////////////////////////////////////

; each array recognizes impact if impact was made between character and cars, 
;if contact was made, it will call the procedure youLose which will print a "game over " message to the screen and ends the game.


proc identifyImpact2
	
	mov cl,2
	cmp [rowFrog],cl
	je cmpcolumn2
	jne endprocII27
	
	
cmpcolumn2:
	mov cl,[colRow2]
	cmp [columnFrog],cl
	je youLoose2
	jne endprocII2	
youLoose2:
	call youLose
endprocII2:


; call the next car in the this row array	
	mov cl,[colRow2+1]
	cmp [columnFrog],cl
	je youLoose21
	jne endprocII21	
youLoose21:
	call youLose
endprocII21:	

; call the next car in the this row array	
	mov cl,[colRow2+2]
	cmp [columnFrog],cl
	je youLoose22
	jne endprocII22
youLoose22:
	call youLose
endprocII22:	

; call the next car in the this row array	
	mov cl,[colRow2+3]
	cmp [columnFrog],cl
	je youLoose23
	jne endprocII23
youLoose23:
	call youLose
endprocII23:	


; call the next car in the this row array	
	mov cl,[colRow2+4]
	cmp [columnFrog],cl
	je youLoose24
	jne endprocII24
youLoose24:
	call youLose
endprocII24:	


; call the next car in the this row array	
	mov cl,[colRow2+5]
	cmp [columnFrog],cl
	je youLoose25
	jne endprocII25
youLoose25:
	call youLose
endprocII25:	


; call the next car in the this row array	
	mov cl,[colRow2+6]
	cmp [columnFrog],cl
	je youLoose26
	jne endprocII26
youLoose26:
	call youLose
endprocII26:	


; call the next car in the this row array	
	mov cl,[colRow2+7]
	cmp [columnFrog],cl
	je youLoose27
	jne endprocII27
youLoose27:
	call youLose
endprocII27:	

ret
endp identifyImpact2

proc identifyImpact4
	
	mov cl,4
	cmp [rowFrog],cl
	je cmpcolumn4
	jne endprocII47
	
	
cmpcolumn4:
	mov cl,[colRow4]
	cmp [columnFrog],cl
	je youLoose4
	jne endprocII4	
youLoose4:
	call youLose
endprocII4:


; call the next car in the this row array	
	mov cl,[colRow4+1]
	cmp [columnFrog],cl
	je youLoose41
	jne endprocII41	
youLoose41:
	call youLose
endprocII41:	

; call the next car in the this row array	
	mov cl,[colRow4+2]
	cmp [columnFrog],cl
	je youLoose42
	jne endprocII42
youLoose42:
	call youLose
endprocII42:	

; call the next car in the this row array	
	mov cl,[colRow4+3]
	cmp [columnFrog],cl
	je youLoose43
	jne endprocII43
youLoose43:
	call youLose
endprocII43:	


; call the next car in the this row array	
	mov cl,[colRow4+4]
	cmp [columnFrog],cl
	je youLoose44
	jne endprocII44
youLoose44:
	call youLose
endprocII44:	


; call the next car in the this row array	
	mov cl,[colRow4+5]
	cmp [columnFrog],cl
	je youLoose45
	jne endprocII45
youLoose45:
	call youLose
endprocII45:	


; call the next car in the this row array	
	mov cl,[colRow4+6]
	cmp [columnFrog],cl
	je youLoose46
	jne endprocII46
youLoose46:
	call youLose
endprocII46:	


; call the next car in the this row array	
	mov cl,[colRow4+7]
	cmp [columnFrog],cl
	je youLoose47
	jne endprocII47
youLoose47:
	call youLose
endprocII47:	


ret
endp identifyImpact4

proc identifyImpact6
	
	mov cl,6
	cmp [rowFrog],cl
	je cmpcolumn6
	jne endprocII67
	
	
cmpcolumn6:
	mov cl,[colRow6]
	cmp [columnFrog],cl
	je youLoose6
	jne endprocII6	
youLoose6:
	call youLose
endprocII6:


; call the next car in the this row array	
	mov cl,[colRow6+1]
	cmp [columnFrog],cl
	je youLoose61
	jne endprocII61	
youLoose61:
	call youLose
endprocII61:	

; call the next car in the this row array	
	mov cl,[colRow6+2]
	cmp [columnFrog],cl
	je youLoose62
	jne endprocII62
youLoose62:
	call youLose
endprocII62:	

; call the next car in the this row array	
	mov cl,[colRow6+3]
	cmp [columnFrog],cl
	je youLoose63
	jne endprocII63
youLoose63:
	call youLose
endprocII63:	


; call the next car in the this row array	
	mov cl,[colRow6+4]
	cmp [columnFrog],cl
	je youLoose64
	jne endprocII64
youLoose64:
	call youLose
endprocII64:	


; call the next car in the this row array	
	mov cl,[colRow6+5]
	cmp [columnFrog],cl
	je youLoose65
	jne endprocII65
youLoose65:
	call youLose
endprocII65:	


; call the next car in the this row array	
	mov cl,[colRow6+6]
	cmp [columnFrog],cl
	je youLoose66
	jne endprocII66
youLoose66:
	call youLose
endprocII66:	


; call the next car in the this row array	
	mov cl,[colRow6+7]
	cmp [columnFrog],cl
	je youLoose67
	jne endprocII67
youLoose67:
	call youLose
endprocII67:	

ret
endp identifyImpact6


proc identifyImpact8
	
	mov cl,8
	cmp [rowFrog],cl
	je cmpcolumn8
	jne endprocII87
	
	
cmpcolumn8:
	mov cl,[colRow8]
	cmp [columnFrog],cl
	je youLoose8
	jne endprocII8	
youLoose8:
	call youLose
endprocII8:


; call the next car in the this row array	
	mov cl,[colRow8+1]
	cmp [columnFrog],cl
	je youLoose81
	jne endprocII81	
youLoose81:
	call youLose
endprocII81:	

; call the next car in the this row array	
	mov cl,[colRow8+2]
	cmp [columnFrog],cl
	je youLoose82
	jne endprocII82
youLoose82:
	call youLose
endprocII82:	

; call the next car in the this row array	
	mov cl,[colRow8+3]
	cmp [columnFrog],cl
	je youLoose83
	jne endprocII83
youLoose83:
	call youLose
endprocII83:	

	
; call the next car in the this row array	
	mov cl,[colRow8+4]
	cmp [columnFrog],cl
	je youLoose84
	jne endprocII84
youLoose84:
	call youLose
endprocII84:	


; call the next car in the this row array	
	mov cl,[colRow8+5]
	cmp [columnFrog],cl
	je youLoose85
	jne endprocII85
youLoose85:
	call youLose
endprocII85:	


; call the next car in the this row array	
	mov cl,[colRow8+6]
	cmp [columnFrog],cl
	je youLoose86
	jne endprocII86
youLoose86:
	call youLose
endprocII86:	


; call the next car in the this row array	
	mov cl,[colRow8+7]
	cmp [columnFrog],cl
	je youLoose87
	jne endprocII87
youLoose87:
	call youLose
endprocII87:	


ret
endp identifyImpact8

proc identifyImpact
; calls each row (2,4,6, and 8) to check all cars in their array

	call identifyImpact2
	call identifyImpact4
	call identifyImpact6
	call identifyImpact8

ret
endp identifyImpact


;///////////////////////////////////////////////////////////////////////
;////////////////// END Identify impact for arrays /////////////////////
;///////////////////////////////////////////////////////////////////////








proc youLose
	;clear screen
	mov ax,0003h
    int 10h
	;print "game over" message
	mov dx,offset gameOver
	mov ah,9h
	int 21h
	;sound of losing
	mov [note],1300h
	call gameSound
	mov [note],2000h
	call gameSound
	mov [note],2500h
	call gameSound
	mov [note],3000h
	call gameSound
	mov [note],3500h
	call gameSound
	mov [note],4000h
	call gameSound
	mov [note],4500h
	call gameSound
	
	;shows "to start over" msg
	mov dx, offset gameovermsg
	mov ah,9h
	int 21h

WaitForPress2:	
	mov ah,0h
	int 16h
	
	cmp al,113
	je quit2
	cmp al,114
	je restart2
	jne WaitForPress2
quit2:
	call exit
	
restart2:
	mov [rowFrog],9
	mov [columnFrog],40
	call completeGame
ret
endp youLose

proc up							;this procedure moves the character up if the up arrow was pressed, 
								;it calls roadcomplete procedure and the decreses its row and calls characterMovement procedure.
	call completeRoad
	dec [rowFrog]	
	call characterMovement
	mov [note],1700h
	call gameSound
	ret
endp up

proc down							;this procedure moves the character down if the down arrow was pressed, 
									;it calls roadcomplete procedure and the increases its row and calls characterMovement procedure, 
									;if the row is the lowest row possible in the game, it wont move.
	cmp [rowFrog],9
	je e
	call completeRoad
	inc [rowFrog]
	call characterMovement
	mov [note],2300h
	call gameSound
e:	
	ret
endp down

proc left							;this procedure moves the character left if the left arrow was pressed, 
									;it calls roadcomplete procedure and compares the frog's row to 1 to check 
									;if moving the frog to the other side of the screen is necessary, 
									;then it jumps to the right lable to move it left or the other side then it calls characterMovement procedure.
	call completeRoad
	cmp [columnFrog],0
	je columnFrog0
	jne DecCol

columnFrog0:
	mov [columnFrog],79
	jmp endprocLeft

DecCol:
	dec [columnFrog]

endprocLeft:
	call characterMovement
	mov [note],3000h
	call gameSound
	ret
endp left

proc right							;this procedure moves the character left if the right arrow was pressed, 
									;it calls roadcomplete procedure and compares the frog's 
									;row to 79 to check if moving the frog to the other side of 
									;the screen is necessary, it jumps to the right lable to move it right 
									;or the other side then it calls characterMovement procedure.
	call completeRoad
	cmp [columnFrog],79
	je columnFrog79
	jne IncCol

columnFrog79:
	mov [columnFrog],0
	jmp endprocRight

IncCol:	;moves character right
	inc [columnFrog]
	call characterMovement
	
endprocRight: 
	call characterMovement
	mov [note],1300h
	call gameSound
	ret
endp right

proc GetInputStartIntructions							;this procedure waits for a char after the opening 
														;screen is shown, it gets a level data (1,2 or 3) 
														;and changes the variables as needed or clears screen and shows instructions if 'i' key was pressed.
getChar:
	;getting a character from user
	mov ah,00h
	int 16h
	
	;comparing character to options
	cmp al,51
	je GetInputHard
	cmp al,50
	je GetInputMedium
	cmp al,49
	je GetInputEasy
	cmp al,105
	je instructionslbl
	cmp al,113
	je quit3
	jmp getChar
		
instructionslbl:
	;clears the screen and shows instructions message
	call instructionss
	jmp getChar

GetInputHard:
	mov [interval],1
	jmp endprocGetInput
GetInputMedium:
	mov [interval],15
	jmp endprocGetInput
GetInputEasy:
	mov [interval],30
	jmp endprocGetInput
	
quit3:
	call exit
	
endprocGetInput:
ret

endp  GetInputStartIntructions


proc startprog							;this procedure prints the opening screen
	;print opening screen
	;print logo
	mov dx,offset logo
	mov ah,9h
	int 21h
	
	;print instructions message
	mov dx,offset instructionsmsg
	mov ah,9h
	int 21h
	
	
	;print start message
	mov dx,offset startmsg
	mov ah,9h
	int 21h	
	
	;print quit message
	mov dx,offset quitgameatbeginning
	mov ah,9h
	int 21h	
	
ret
endp startprog

proc checkClock							;this procedure checks the clock and is being used to move 
										;the cars by the level which was typed at the opening screen 
										;or instructions screen it also calls manageCars2,4,6 and 8 to move them by its level requirements.
	;checks clock
	mov ah,2ch
	int 21h	
	
	; mstemp holds the difference between mlisec (previous run of this proc) to the current clock (dl) if mstemp is > 200 move the car 
	mov [mstemp], dl
	
	;using registers
	mov bl,[milsec]		;milsec-ms from previous movement round
	sub bl,[mstemp]		;diff between 1st ms to the 2nd
	mov [mstemp],bl		;move the diff between ms's to mstemp
	
	;move car every [interval] milisecond
	mov al,[interval]
	neg [interval]
	mov ah,[interval]
	neg [interval]
	cmp [mstemp],al
	jg movecarlbl 
	cmp [mstemp],ah
	jl movecarlbl
	jg endprocCheckClock

movecarlbl:
	mov [milsec],dl
	call manageCars8
	call manageCars6
	call manageCars4
	call manageCars2
endprocCheckClock:
	call paintCar
	
ret
endp checkClock

proc exit							;this procedure exits the program when user wins or loses.
	mov ax, 4c00h
	int 21h
ret
endp exit
proc completeGame
	;clear screen
	mov ax,0003h
    int 10h
	;enter text mode
	mov al,03h
	mov ah,0
	int 10h
	
	call startprog
	call GetInputStartIntructions
	call startGame
	
WaitForKey:							;this lable waits for a key to be pressed to move the character (frog) 
									;while running itself in a endless loop until user loses or wins, 
									;meanwhile, while waiting for a key, it calls checkClock to move the cars by level requirements.
	
	
	
	call checkClock
	;get input from user	
	mov ah,01h
	int 16h

	cmp ah,72		;up arrow
	je up1
	cmp ah,75		;left arrow
	je left1
	cmp ah,77		;right arrow
	je right1
	cmp ah,80		;down arrow
	je down1
	cmp al,113
	je quit4
	jne nonArrow
	jmp WaitForKey	;loop
	
	
quit4:
	call exit
	
nonArrow:
	;clear buffer
	mov ah,0ch
	int 21h
	jmp WaitForKey
	
left1:							;this procedure calls left procedure if left arrow was pressed, 
								;and it clears the keyboad buffer then jumps back to WaitForKey lable.
	call left
	;clear buffer
	mov ah,0ch              
	int 21h
	
	jmp WaitForKey

right1:							;this procedure calls right procedure if right arrow was pressed, 
								;and it clears the keyboad buffer then jumps back to WaitForKey lable.
	call right
	;clear buffer
	mov ah,0ch              
	int 21h
	
	jmp WaitForKey
	
down1:							;this procedure calls down procedure if down arrow was pressed, 
								;and it clears the keyboad buffer then jumps back to WaitForKey lable.
	call down
	;clear buffer
	mov ah,0ch              
	int 21h
	
	jmp WaitForKey
	
up1:							;this procedure calls up procedure if up arrow was pressed, 
								;and it clears the keyboad buffer then jumps back to WaitForKey lable
								;it also compares the new row of the frog to row no.1 and if equal, it clears the screen and prints the youWin variable.
	call up
	cmp [rowFrog],1
	je won
	;clear buffer
	mov ah,0ch              
	int 21h
	
	jmp WaitForKey
	
won:
	;clear screen
	mov ax,0003h
    int 10h
	;show you win message
	mov dx,offset youWin
	mov ah,9h
	int 21h
	;sound of losing
	mov [note],3500h
	call gameSound
	mov [note],3000h
	call gameSound
	mov [note],2500h
	call gameSound
	mov [note],2000h
	call gameSound
	mov [note],1300h
	call gameSound
	mov [note],1000h
	call gameSound
	
	;shows "to start over" msg
	mov dx, offset gameovermsg
	mov ah,9h
	int 21h

WaitForPress:	
	mov ah,0h
	int 16h
	
	cmp al,113
	je quit
	cmp al,114
	je restart
	jne WaitForPress
	
quit:
	call exit
	
restart:
	mov [rowFrog],9
	mov [columnFrog],40
	call completeGame
	
ret
endp completeGame

start:
	mov ax, @data
	mov ds, ax
; --------------------------
; Your code here

	call completeGame
	
	
	
	
	
	
	
	
; --------------------------
	
exit1:
	call exit
END start


