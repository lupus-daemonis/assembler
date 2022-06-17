;Rineyskaya 21 Var
;a = 136, n = 6
sseg segment para stack 'stack' 
	db 256 dup (0)
sseg ends
dseg segment para public 'data'
a dw 136 ;10001000
mes db 10, 13, '$'
mes1 db 'Number of the first non-zero bit -->$'
mes2 db 'Number of the last non-zero bit -->$'
mes3 db 'The sixth bit is zero$'
mes4 db 'The sixth bit is not zero$'
mes5 db 'The sixth bit is equal to one-->$'
mes6 db 'The seventh bit is zero$'
mes7 db 'The seventh bit is not zero$'
mes8 db 'The seventh bit is equal to zero-->$'
mes9 db 'The fifth bit is zero$'
mes10 db 'The fifth bit is not zero$'
mes11 db 'The fifth bit is converted-->$'
mes12 db 'Shift logical left-->$'
mes13 db 'Shift logical right-->$'
mes14 db 'Shift arithmetic left-->$'
mes15 db 'Shift arithmetic right-->$'
mes16 db 'Rotate left-->$'
mes17 db 'Rotate right-->$'
mes18 db 'Rotate through carry left-->$'
mes19 db 'Rotate through carry right-->$'
mes20 db 'Logical command or, and, xor:$'
dseg ends	
	extrn disp:near
cseg segment para public 'code'
	main proc near 
	assume cs:cseg, ds:dseg, ss:sseg
	mov ax,dseg 
	mov ds,ax 
	.486
	mov ax,0002h
	int 10h
;сканирование бит вперед 
	mov ax,a 
	bsf bx,ax 
	lea dx,mes1 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp
	lea dx, mes 
	mov ax, 0900h
	int 21h
;сканирование бит в обратном порядке
	mov ax,a 
	bsr bx,ax 
	lea dx,mes2 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp
	lea dx, mes 
	mov ax, 0900h
	int 21h
;проверка и установка шестого бита
	mov bx,a 
	mov ax,6 
	bts bx,ax 
	jc m1 ;переход, если бит равен 1
	lea dx,mes3 
	mov ax,0900h 
	int 21h
	lea dx, mes 
	mov ax, 0900h
	int 21h
	jmp m2
m1: lea dx,mes4 
	mov ax,0900h 
	int 21h
	lea dx, mes 
	mov ax, 0900h
	int 21h
m2: lea dx,mes5 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp 
	lea dx, mes 
	mov ax, 0900h
	int 21h
;проверка и сброс седьмого бита
	mov bx,a 
	mov ax,7 
	btr bx,ax
	jc m3 ;переход, если бит равен 1
	lea dx,mes6 
	mov ax,0900h 
	int 21h
	lea dx, mes 
	mov ax, 0900h
	int 21h
	jmp m4
m3: lea dx,mes7 
	mov ax,0900h 
	int 21h
	lea dx, mes 
	mov ax, 0900h
	int 21h
m4: lea dx,mes8 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp
	lea dx, mes 
	mov ax, 0900h
	int 21h
;проверка и инвертирование пятого бита
	mov bx,a 
	mov ax,5 
	btc bx,ax
	jc m5 ;переход, если бит равен 1
	lea dx,mes9 
	mov ax,0900h 
	int 21h
	lea dx, mes 
	mov ax, 0900h
	int 21h
	jmp m6
m5: lea dx,mes10 
	mov ax,0900h 
	int 21h
m6: lea dx,mes11 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp
	lea dx, mes 
	mov ax, 0900h
	int 21h
;логический сдвиг влево 
	mov ax,a 
	shl ax,6 
	mov bx,ax 
	lea dx,mes12 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp 
	lea dx, mes 
	mov ax, 0900h
	int 21h
;логический сдвиг вправо 
	mov ax,a 
	shr ax,6 
	mov bx,ax 
	lea dx,mes13 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp
	lea dx, mes 
	mov ax, 0900h
	int 21h
;арифметический сдвиг влево 
	mov ax,a 
	sal ax,6 
	mov bx,ax 
	lea dx,mes14 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp
	lea dx, mes 
	mov ax, 0900h
	int 21h
;арифметический сдвиг вправо
	mov ax,a 
	sar ax,6 
	mov bx,ax 
	lea dx,mes15 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp
	lea dx, mes 
	mov ax, 0900h
	int 21h
;циклический сдвиг влево 
	mov ax,a 
	rol ax,6 
	mov bx,ax 
	lea dx,mes16 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp
	lea dx, mes 
	mov ax, 0900h
	int 21h
;циклический сдвиг вправо 
	mov ax,a 
	ror ax,6 
	mov bx,ax 
	lea dx,mes17 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp
	lea dx, mes 
	mov ax, 0900h
	int 21h
;логические команды or,and,xor
	lea dx,mes20
	mov ax,0900h
	int 21h
	lea dx, mes 
	mov ax, 0900h
	int 21h
;установка шестого бита 
	mov ax,a 
	or ax,1000000b 
	mov bx,ax 
	lea dx,mes5 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp 
	lea dx, mes 
	mov ax, 0900h
	int 21h
;сброс седьмого бита 
	mov ax,a 
	and ax,01111111b
	mov bx,ax 
	lea dx,mes8 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp
	lea dx, mes 
	mov ax, 0900h
	int 21h
;инвертирование пятого бита
	mov ax,a 
	xor ax,100000b
	mov bx,ax 
	lea dx,mes11 
	mov ax,0900h 
	int 21h
	mov ax,bx 
	call disp
;завершение программы
	mov ax,4c00h 
	int 21h
	main endp
	cseg ends 
	end main