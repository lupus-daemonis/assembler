;Rineyskaya, var 21, сопроцессор
;с использованием вещественных команд сопроцессора

;y=3xy-1+y, x+y>7
;y=(x+y)(x^2+4), x+y<-10
;3x^2 - 2y^2 + 1, -10<=x+y<=7

;x=6 y=3.5 f=65.5
;x=0 y=-14 f=-3.5
;x=1.5  y=1.5 f=3.25

masm
model use16 small
.486
.stack 100h
.data ;сегмент данных
	x dd 6.0
	y dd 3.5
	f dd ?
	five dd 5.0
	three dd 3.0
	one dd 1.0
	seven dd 7.0
	two dd 2.0
	four dd 4.0
	ten dd -10.0
	znam dd ?
.code
main proc
	mov ax,@data
	mov ds,ax
	finit			;приведение сопроцессора в начальное состояние
	fld x 			;загрузка значение a в st(0)
	fadd y 			;st(0)=a+b
	fcomp ten 		;сравниваем st(0) c -10 и одновременно сбрасываем регистр st(0)
	fstsw ax 		;сохранение swr в регистре ax
	sahf 			;запись swr->ax-> регистр флагов
	jc met2 		;если a+b<-10 переход на метку1
	fld x 			;загрузка значение a в st(0)
	fadd y 			;st(0)=a+b
	fcomp seven	    ;сравниваем st(0) c 7 и одновременно сбрасываем регистр st(0)
	fstsw ax 		;сохранение swr в регистре ax
	sahf 			;запись swr->ax-> регистр флагов
	jnc met1 		;если a+b>2 переход на метку2
	call p3 		;вычисляем значение при 7>a+b>-10
	jmp exit
met1: call p2 		;вычисляем значение при a+b>7
	jmp exit
met2: call p1 		;вычисляем значение при a+b<-10
exit: mov ax, 4c00h
	int 21h
main endp

p1 proc 			;вычисляем значение при a+b<-10
	fld x 			;st(0)=a
	fmul y 			;st(0)=a*a
	fadd four		;a*a+4
	fst znam
	fld x 			;st(0)=a
	fadd y			;st(0)=a+b
	fdiv znam       ;st(0)=(a+b)/(a*a+4)
	fst f
	ret
p1 endp

p2 proc 			;вычисляем значение при a+b>7
	fld x 			;st(0)=a
	fmul three 		;st(0)=3*a
	fmul y 			;st(0)=3*a*b
	fsub one 		;st(0)=3*a*b-1
	fadd y			;st(0)=3*a*b-1+b
	fst f 			
	ret
p2 endp

p3 proc 			;вычисляем значение при -10<=x+y<=7
	fld y			;st(0)=b
	fmul y			;st(0)=b*b
	fmul two		;st(0)=2*b*b
	fst znam
	fld x 			;st(0)=a
	fmul x			;st(0)=a*a
	fmul three 		;st(0)=a*a*3
	fsub znam 		;st(0)=a*a*3-2*b*b
	fadd one		;st(0)=a*a*3-2*b*b+1
	fst f
	ret
p3 endp
end main