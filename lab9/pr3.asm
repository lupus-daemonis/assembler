;Rineyskaya 21 var
;изменение свойств: Ctrl+N, Ctrl+M -> название комбинации клавиш с 
;соответствующей цветовой гаммой (фон/текст): красный/белый, синий/красный. 
masm
model small
.data
ESC_    equ     1Bh     ;ASCII-код клавиши ESC
CTRL_N    db     'CTRL_N', 0dh,0ah,'$'
CTRL_M    db     'CTRL_M', 0dh,0ah,'$'
        org 100h
.stack
   db 256 dup (0)

.code

 start:
        mov ax,@data
        mov ds,ax

        mov ah,0h
        int 16h       ;чтение символа с клавиатуры

        cmp al, ESC_ ; ESC check
        je exit
 	
  	;N
    cmp ax,310Eh
	je next_n

	;M
    cmp ax,320Dh
    je next_m

        jmp start

next_n:
        mov     ah, 09h  ; вывод сообщения
        mov     bl, 04fh ; красный текст на белом фоне
        mov     cx, 6
        int     10h

	mov ax, 0900h
        lea     dx,CTRL_n
        int     21h
        jmp next

next_m:
        mov     ah, 09h  ; вывод сообщения
        mov     bl, 014h ; синий цвет на красном фоне
        mov     cx, 6   
        int     10h

	mov ax, 0900h
        lea     dx,CTRL_m
        int     21h
next:
       jmp start

exit:
        mov ax,4c00h
        int 21h
    
end start

	