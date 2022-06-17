;Rineyskaya Vladislava ITP-11 var 21
;y=(3b+2a-4)/(5-a)
;a=3, b=2, y=4(10)=4(16)
dseg segment para public 'data'
	 a db 3
	 b db 2
	 y db ?
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
  mov dl,5     ;dl=5
  sub dl,a     ;dl=5-a
  mov al,3     ;al=3
  imul b       ;al=3*b
  mov bl,al    ;bl=3*b
  mov al,2     ;al=2
  imul a       ;al=2*a
  add al,bl    ;al=3*b+2*a
  sub al,4     ;al=3*b+2*a-4
  cbw
  idiv dl      ;al=(3*b+2*a-4)/(5-a) остаток в ah
  mov y,al     ;y=al
  lea dx,mes   ;вывод сообщения 'конец программы'
  mov ax,0900H
  int 21H
  mov ax,4C00H ;завершение программы
  int 21H
 osn endp
cseg ends
end osn