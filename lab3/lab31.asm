;Rineyskaya Vladislava 30 var ITP-11
;y=3xy-1+y, x+y>7
;y=(x+y)(x^2+4), x+y<-10
;3x^2 - 2y^2 + 1, -10<=x+y<=7

;x=9, y=1, f=27 (1B)
;x=-2, y=-14, f=-2 (-2)
;x=2, y=1, f=11 (B)
dseg segment para public 'data'
   x db -2
   y db -14
   f db ?
   mes db 'конец программы$'
dseg ends
sseg segment para stack 'stack'
   dw 30 dup(0)
sseg ends
cseg segment para public 'code'
osn proc near
assume cs:cseg, ds:dseg, ss:sseg
   mov ax,dseg
   mov ds,ax
   mov al,x
   add al,y
   cmp al,7   
   jg m1
   cmp al,-10
   jl m2
   
;вычисляем значение функции при -10<=al<=7   
   mov al,2    ;al=2
   imul y      ;al=2*y
   imul y      ;al=2*y*y
   mov bl,al   ;bl=2*y*y
   mov al,3    ;al=3
   imul x      ;al=3*x
   imul x      ;al=3*x*x
   sub al,bl   ;al=3*x*x - 2*y*y
   add al,1    ;al=3*x*x - 2*y*y +1
   jmp m3

;вычисляем значение функции при al>7       
m1:mov al,3
   imul x       ;al=3*x
   imul y       ;al=3*x*y
   sub al,1     ;al=3*x*y-1
   add al,y     ;al=3*x*y - 1 + y
   jmp m3

;вычисляем значение функции при al<-10     
m2:mov al,x
   imul x      ;al=x*x
   add al,4    ;al=x*x+4
   mov bl,al
   mov al,x    ;al=x
   add al,y    ;al=x+y
   cbw
   idiv bl     ;al=(x+y)/(x*x+4)
   jmp m3
   
m3:mov f,al 
   lea dx,mes
   mov ah,9 
   int 21H
   mov ax, 4c00h
   int 21H  
osn endp
cseg ends
end osn 