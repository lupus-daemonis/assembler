;Rineyskaya Vladislava ITP-11 var 21
;y=(3b+2a-4)/(5-a)
;a=3, b=2, y=4(10)=4(16)
dseg segment para public 'data'
	 a dw 3
	 b dw 2
	 y dw ?
mes db 'конец программы$'
dseg ends 
sseg segment para stack 'stack'
	 db 30 dup (0)
sseg ends
cseg segment para public 'code'
  osn proc near
  assume cs:cseg,ds:dseg,ss:sseg
  mov ax,dseg
  mov ds,ax
  mov cx,5      ;cx=5
  sub cx,a      ;cx=5-a
  mov ax,3      ;ax=3
  imul b        ;ax=3*b
  mov bx,ax     ;bx=3*b
  mov ax,2      ;ax=2
  imul a        ;ax=2*a
  add ax,bx     ;ax=3*b+2*a
  sub ax,4      ;ax=3*b+2*a-4
  cwd
  idiv cx       ;ax=(3*b+2*a-4)/(5-a) остаток в ax
  mov y,ax 	    ;y=ax
  lea dx,mes    ;вывод сообщения 'конец программы'
  mov ax,0900H
  int 21H
  mov ax,4C00H  ;завершение программы
  int 21H
 osn endp
cseg ends
end osn