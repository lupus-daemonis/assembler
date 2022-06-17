;Rineyskaya Vladislava 30 var ITP-11
program lab35;
uses crt;
var
   x,y,f:integer;
function p1(x,y:ineger):integer; assembler;
asm
   mov al,3
   imul x       ;al=3*x
   imul y       ;al=3*x*y
   sub al,1     ;al=3*x*y-1
   add al,y     ;al=3*x*y - 1 + y
end;
function p2(x,y:ineger):integer; assembler;
asm
   mov al,x
   imul x      ;al=x*x
   add al,4    ;al=x*x+4
   mov bl,al   ;bl=x*x+4
   mov al,x    ;al=x
   add al,y    ;al=x+y
   cbw
   idiv bl     ;al=(x+y)/(x*x+4)
end;
function p3(x,y:ineger):integer; assembler;
asm
   mov al,2    ;al=2
   imul y      ;al=2*y
   imul y      ;al=2*y*y
   mov bl,al   ;bl=2*y*y
   mov al,3    ;al=3
   imul x      ;al=3*x
   imul x      ;al=3*x*x
   sub al,bl   ;al=3*x*x - 2*y*y
   add al,1    ;al=3*x*x - 2*y*y +1
end;
begin
  clrscr;
  Write('¬ведите x,y-->');
  Readln(x,y);
  if x+y>7 then f:=p1(x,y)
	else if x+y<-10 then f:=p2(x,y)
		else f:=p3(x,y);
  Writeln('f=',f)
end.