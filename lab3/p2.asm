;Rineyskaya Vladislava 30 var ITP-11
;al<-10
extrn x:byte, y:byte
public p2
cseg segment para public 'code'
p2 proc near 
   assume cs:cseg 
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
cseg ends
end   