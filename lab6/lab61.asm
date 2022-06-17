;Rineyskaya, 21 Var, ITP-11, BCD числа
;y=(3a+2b-c)/5
;a=12, b=21, c=18, y=12
masm
model small
.data
	len equ 2   ;разрядность числа 
	a db 2,1    ;неупакованное число 12
	b db 1,2    ;неупакованное число 21
	c db 8,1    ;неупакованное число 18 
	three db 3 
	two db 2 
	five db 5 
	ten db 10 
	prod1 db 3 dup (0)  ;произведние 3а=36
	prod2 db 3 dup (0)  ;произведние 2b=42
	sum1 db 3 dup (0)   ;сумма 3а+2b=78
	sub1 db 3 dup (0)   ;разность 3а+2b-с=60
	rez db 2 dup (0)    ;частное (3а+2b-с)/5=12
.stack 
	db 256 dup (0) 
.code
	main proc near 
	mov ax,@data 
	mov ds,ax 
	xor ax,ax   	 ;произведние 3а=36 
	len equ 2  		 ;размерность сомножителя 1
	xor bx,bx 
	xor si,si
	xor di,di 
	mov cx,len  	 ;в сх длина наибольшего сомножителя 1 
m1: mov al,a[si] 
	mul three 
	aam        		 ;коррекция умножения
	adc al,dl 		 ;учли предыдущий перенос  
	aaa        		 ;скорректировали результат сложения с переносом
	mov dl,ah  		 ;запомнили перенос
	mov prod1[bx],al 
	inc si
	inc bx
	loop m1 
	mov prod1[bx],dl ;учли последний перенос 
	xor ax,ax        ;произведние 2b=42
	len equ 2        ;размерность сомножителя 1
	xor bx,bx 
	xor si,si 
	xor di,di 
	mov cx,len       ;в сх длина наибольшего сомножителя 1
m2: mov al,b[si] 
	mul two 
	aam         	 ;коррекция умножения
	adc al,dl   	 ;учли предыдущий перенос  
	aaa         	 ;скорректировали результат сложения с переносом
	mov dl,ah   	 ;запомнили перенос
	mov prod2[bx],al 
	inc si 
	inc bx 
	loop m2 
	mov prod2[bx],dl  ;учли последний перенос 
	xor bx,bx         ;сумма 3а+2b=78
	mov cx,3
m3: mov al,prod1[bx] 
	adc al,prod2[bx] 
	aaa 
	mov sum1[bx],al 
	inc bx 
	loop m3 
	adc sum1[bx],0 
	xor ax,ax  			;разность 3а+2b-с=60
	xor bx,bx 	
	mov cx,2   			;загрузка в сх счетчика цикла
m4: mov al,sum1[bx] 
	sbb al,c[bx] 
	aas 
	mov sub1[bx],al 
	inc bx 
	loop m4 
	xor ax,ax       	;частное (3а+2b-с)/5=12 
	mov si,1 
	mov al,sub1[si] 
	imul ten        	;умножаем первую цифру числа на 10 
	dec si 
	add al,sub1[si]     ;прибавляем вторую цифру числа 
	div five            ;делим: в al BCD-частное, в ah - BCD-остаток 
	;формируем результат в виде BCD-числа 
	mov bl,al          ;запоминаем частное 
	mov ah,0           ;убираем остаток 
	div ten            ;выделяем цифры числа 
	mov di,0 
	mov rez[di],ah     ;запоминаем вторую цифру числа
	inc di 
	mov rez[di],al     ;запоминаем первую цифру числа
	mov ax,4c00h 
	int 21h 
main endp 
end main 
