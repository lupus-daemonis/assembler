;Rineyskaya 21 var
;��������� �������: Ctrl+N, Ctrl+M -> �������� ���������� ������ � 
;��������������� �������� ������ (���/�����): �������/�����, �����/�������. 
masm
model small
.data
ESC_    equ     1Bh     ;ASCII-��� ������� ESC
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
        int 16h       ;������ ������� � ����������

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
        mov     ah, 09h  ; ����� ���������
        mov     bl, 04fh ; ������� ����� �� ����� ����
        mov     cx, 6
        int     10h

	mov ax, 0900h
        lea     dx,CTRL_n
        int     21h
        jmp next

next_m:
        mov     ah, 09h  ; ����� ���������
        mov     bl, 014h ; ����� ���� �� ������� ����
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

	