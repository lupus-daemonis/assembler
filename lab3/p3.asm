;Rineyskaya Vladislava 30 var ITP-11
;-10<=al<=7
extrn x:byte, y:byte
public p3
cseg segment para public 'code'
p3 proc near 
   assume cs:cseg 
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
end   