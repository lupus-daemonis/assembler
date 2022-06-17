;Rineyskaya, var21, строки
;Распечатать первое слово строки
.MODEL small 
.STACK 100h 
.DATA 
	razm equ 1 
	vivod db 0Dh, 0Ah, '$' 
	String db 'eto lab rab po strokam!',0ah,0dh,'$' 
	PosLen db ' 0 0',0ah,0dh,'$'; 
	Pos dw ? 
	Len dw ? 
	nom dw ? 
.CODE 
	assume ds:@data,es:@data 
main PROC
	mov ax, @data
	mov ds, ax
	mov es,ax 
	mov ah,09h
	lea dx,String
	int 21h 		;вывод сообщения mes
	mov al,' ' 		;пробел
	cld 			;сброс флага df
	lea di,String   ;загрузка в es:di смещения строки
	mov si,di 		;запоминаем адрес начала строки
	mov cx,18 		;для префикса repne длина строки
	;поиск в строке и выход при первом совпадении
	repne scas String
	je found 
found: dec di
	sub di,si 		;находим номер совпавшего символа
	mov nom,di
	mov [Pos],-1
	mov ax,nom
	mov [Len],ax 
	mov al,10 
	int 29h 
	mov ah, 40h 
	mov bx, razm 
	mov cx, [Len]  
	lea dx, [String+1] 
	add dx, [Pos] 
	int 21h  
	;завершение программы
	xor ax,ax
	int 16h
	mov ax,4c00h
	int 21h
MAIN ENDP
END MAIN