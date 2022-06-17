;Rineyskaya 21 var
;Распечатать год создания файла
extrn disp:near
masm
model small
.data
fname db "c:\lab\lab9\file.txt",0
point_fname dd fname
desc dw 0
data dw 0
.stack 256
.486
.code
main:
mov ax,@data
mov ds,ax 
lds dx,point_fname 	;формируем указатель на строку string
; открываем файл
mov al,00h 			;режит доступа - только чтение
lds dx,point_fname
mov ah,3dh
int 21h
jc exit
mov desc,ax
mov bx,ax 			;дескриптов в bx
mov ax,5700h
int 21h
mov data,dx
jc exit 			;переход в случае ошибки
mov ax,dx
shr ax,9 			;выделяем год с 1980
and ax,007fh
add ax,1980
call disp
;в cx атрибуты 
nop 				;для тестирования
exit:
;выход из программы
mov ax,4c00h 		;пересылка 4c00h в регистр ax
int 21h 			;вызов прерывания с номером 21h
end main 			;конец программы с точкой входа main