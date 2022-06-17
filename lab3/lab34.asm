;Rineyskaya Vladislava 30 var ITP-11
;x=9, y=1, f=27 (1B)
;x=-2, y=-14, f=-2 (-2)
;x=2, y=1, f=11 (B)
dseg segment para public 'data'
   x db 2
   y db 1
   f db ?
   mes1 db 10,13,'$'
   mes db 'конец программы$'
   mes2 db 'Vvedite x-->$'
   mes3 db 'Vvedite y-->$'
   mes4 db 'f=$'
dseg ends
sseg segment para stack 'stack'
   dw 30 dup(0)
sseg ends
   public x,y
   extrn p1:near, p2:near, p3:near, disp:near, vvod:near
cseg segment para public 'code'
osn proc near
assume cs:cseg, ds:dseg, ss:sseg
   mov ax,dseg
   mov ds,ax
   lea dx,mes2
   mov ah,9
   int 21h
   call vvod
   mov x,bl
   lea dx,mes3
   mov ah,9
   int 21h
   call vvod
   mov y,bl
   mov al,x
   add al,y
   cmp al,7   
   jg m1
   cmp al,-10
   jl m2
   call p3
   jmp m3
m1: call p1
   jmp m3
m2: call p2
m3: mov f,al
   lea dx,mes4
   mov ah,9
   int 21h
   mov al,f
   cbw
   call disp
   lea dx,mes1
   mov ah,9
   int 21h
   lea dx,mes
   mov ah,9
   int 21h
   mov ax, 4c00h
   int 21h
osn endp
cseg ends
end osn