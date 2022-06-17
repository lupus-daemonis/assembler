;Rineyskaya 21 var
;Преобразование ввода: клавиши «F7», «F8» → текст «Нажата F7», «Нажата F8».
masm
model small
.data
ESC_ equ 1Bh ;ASCII-код клавиши ESC
KF7 equ 41h ;скан-код клавиши F7
KF8 equ 42h ;скан-код клавиши F8

mes_KF7 db 'Nazhata klavisha F7',0ah,0dh,'$'
mes_KF8 db 'Nazhata klavisha F8',0ah,0dh,'$'

.stack
db 256 dup (0)
.code
start:
mov ax,@data
mov ds,ax

mov ah,0h
int 16h ;чтение символа с клавиатуры

cmp al, ESC_ ;проверка выхода из программы
je exit

cmp ah, KF7 ;проверка нажатия клавиши F7
je met_KF7

cmp ah, KF8 ;проверка нажатия клавиши F8
je met_KF8

jmp start

met_KF7:
mov ax,0900h
lea dx,mes_KF7 ;вывод текстового сообщения клавиши F7
int 21h
jmp next

met_KF8:
mov ax,0900h
lea dx,mes_KF8 ;вывод текстового сообщения клавиши F8
int 21h

next: jmp start
exit: mov ah, 2h
mov dl, '!'
int 21h
mov ax,4c00h
int 21h
ret
end start