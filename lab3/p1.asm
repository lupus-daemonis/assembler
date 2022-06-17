;Rineyskaya Vladislava 30 var ITP-11
;al>7
extrn x:byte, y:byte
public p1
cseg segment para public 'code'
p1 proc near 
   assume cs:cseg
   mov al,3
   imul x       ;al=3*x
   imul y       ;al=3*x*y
   sub al,1     ;al=3*x*y-1
   add al,y     ;al=3*x*y - 1 + y
   ret
p1 endp
cseg ends
end   