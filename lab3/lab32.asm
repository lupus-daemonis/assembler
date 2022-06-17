;Rineyskaya Vladislava 30 var ITP-11
;x=9, y=1, f=27 (1B)
;x=-2, y=-14, f=-2 (-2)
;x=2, y=1, f=11 (B)
dseg segment para public 'data'
   x db 2
   y db 1
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
   
;процедура при -10<=al<=7
   call p3
   jmp m3

;процедура при al>7
m1: call p1
    jmp m3 
   
;процедура при al<-10
m2: call p2
    jmp m3 

m3: mov f,al 
   lea dx,mes
   mov ah,9
   int 21h
   mov ax, 4c00h
   int 21h
osn endp

;при al>7 
p1 proc near
   mov al,3
   imul x       ;al=3*x
   imul y       ;al=3*x*y
   sub al,1     ;al=3*x*y-1
   add al,y     ;al=3*x*y - 1 + y
   ret
p1 endp

;при al<-10   
p2 proc near   
   mov al,x
   imul x      ;al=x*x
   add al,4    ;al=x*x+4
   mov bl,al   ;bl=x*x+4
   mov al,x    ;al=x
   add al,y    ;al=x+y
   cbw
   idiv bl     ;al=(x+y)/(x*x+4)
   ret
p2 endp

;при -10<=al<=7
p3 proc near       
   mov al,2    ;al=2
   imul y      ;al=2*y
   imul y      ;al=2*y*y
   mov bl,al   ;bl=2*y*y
   mov al,3    ;al=3
   imul x      ;al=3*x
   imul x      ;al=3*x*x
   sub al,bl   ;al=3*x*x - 2*y*y
   add al,1    ;al=3*x*x - 2*y*y +1
   ret
p3 endp
cseg ends
end osn 