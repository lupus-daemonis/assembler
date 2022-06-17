;Rineyskaya, 21 Var, ITP-11, макросы (лаб раб сдвиги)
;a = 136, n = 6 
ds_macro macro 
	mov ax,dseg
	mov ds,ax
endm
out_str_bx macro str,rg
	push ax
	mov ah,09h
	mov dx, offset str
	int 21h
	mov ax,rg
	call disp
	pop ax
endm
out_str macro str
	push ax
	mov ah,09h
	mov dx, offset str
	int 21h
	pop ax
endm
exit macro 
	mov ax,4c00h
	int 21h
endm
sseg segment para stack 'stack'
    db 256 dup (0)
sseg ends
dseg segment para public 'data'
	a dw 136 ;10001000
mes1 db 'Number of the first non-zero bit -->$'
mes2 db 10,13,'Number of the last non-zero bit -->$'
mes3 db 10,13,'The sixth bit is zero$'
mes4 db 10,13,'The sixth bit is not zero$'
mes5 db 10,13,'The sixth bit is equal to one -->$'
mes6 db 10,13,'The seventh bit is zero$'
mes7 db 10,13,'The seventh bit is not zero$'
mes8 db 10,13,'The seventh bit is equal to zero -->$'
mes9 db 10,13,'The fifth bit is zero$'
mes10 db 10,13,'The fifth is not zero$'
mes11 db 10,13,'The fifth bit is convert -->$'
mes12 db 10,13,'Shift logical left -->$'
mes13 db 10,13,'Shift logical right -->$'
mes14 db 10,13,'Shift arithmetic left -->$'
mes15 db 10,13,'Shift arithmetic rigth -->$'
mes16 db 10,13,'Rotate left -->$'
mes17 db 10,13,'Rotate right -->$'
mes18 db 10,13,'Rotate through carry left -->$'
mes19 db 10,13,'Rotate through carry right -->$'
mes20 db 10,13,'Logical command or, and, xor: $'
dseg ends
	extrn disp:near
cseg segment para public 'code'
    osn proc near
	assume cs:cseg,ds:dseg,ss:sseg
	ds_macro
	.486
;сканирование бит вперед
	mov ax,a 
	bsf bx,ax
	out_str_bx mes1,bx
;сканирование бит в обратном порядке
	mov ax,a 
	bsr bx,ax
	out_str_bx mes2,bx
;проверка и установка 6ого бита
	mov bx,a 
	mov ax,6
	bts bx,ax
;переход,если бит равен 1
	jc m1 
	out_str mes3
	jmp m2
m1: out_str mes4
m2: out_str_bx mes5,bx
;проверка и сброс 7ого бита
	mov bx,a 
	mov ax,7
	btr bx,ax
;переход, если бит равен 1
	jc m3 
	out_str mes6
	jmp m4
m3: out_str mes7
m4: out_str_bx mes8, bx
;проверка и инвентирование 5ого бита
	mov bx,a 
	mov ax, 5
	btc bx,ax
;переход, если бит равен 1
	jc m5 
	out_str mes9
	jmp m6
m5: out_str mes10
m6: out_str_bx mes11, bx
;логический сдвиг влево
	mov ax,a 
	shl ax,6
	mov bx,ax
	out_str_bx mes12, bx
;логический сдвиг вправо
	mov ax,a 
	shr ax,6
	mov bx,ax
	out_str_bx mes13, bx
;арифметический сдвиг влево
	mov ax,a 
	sal ax,6
	mov bx,ax
	out_str_bx mes14, bx
;арифметический сдвиг вправо
	mov ax,a
	sar ax,6
	mov bx,ax
	out_str_bx mes15, bx
;циклический сдвиг влево
	mov ax,a 
	rol ax,6
	mov bx,ax
	out_str_bx mes16, bx
;циклический сдвиг вправо
	mov ax,a 
	ror ax,6
	mov bx,ax
	out_str_bx mes17, bx
;логические команды or,and,xor
    out_str mes20
;устанвока шестого бита	
	mov ax,a
	or ax, 1000000b 
	mov bx,ax
	out_str_bx mes5,bx
;сброс седьмого бита
	mov ax,a 
	and ax, 1111111101111111b
	mov bx,ax
	out_str_bx mes8,bx
;инвентирование пятого бита
	mov ax,a 
	xor ax, 100000b
	mov bx,ax
	out_str_bx mes11,bx
	exit
osn endp
cseg ends
end osn		