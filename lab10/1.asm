;Rineyskaya, var 21, сопроцессор
;с использованием целочисленных команд сопроцессора

;y=3xy-1+y, x+y>7
;y=(x+y)(x^2+4), x+y<-10
;3x^2 - 2y^2 + 1, -10<=x+y<=7

;x=6 y=2 f=37
;x=0 y=-12 f=-3
;x=1 y=4 f=-28

masm
model use16 small
.486
.stack 100h
.data				;сегмент данных
	x dw 0	
	y dw -12
	f dw ?
	five dw 5
	three dw 3
	one dw 1
	seven dw 7
	two dw 2
	four dw 4
	ten dw -10
	znam dw ?
.code
main proc
	mov ax,@data
	mov ds,ax
	finit 			;приведение сопроцессора в начальное состояние

	fild x 			;загрузка значение a в st(0)
	fiadd y 		;st(0)=a+b
	ficomp ten		;сравниваем st(0) c -10 и одновременно сбрасываем регистр st(0)
	fstsw ax 		;сохранение swr в регистре ax
	sahf 			;запись swr->ax-> регистр флагов
	jc met2		 	;если a+b<-10 переход на метку1
	fild x 			;загрузка значение a в st(0)
	fiadd y 		;st(0)=a+b
	ficomp seven 	;сравниваем st(0) c 7 и одновременно сбрасываем регистр st(0)
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
	fild x		    ;st(0)=a
	fimul y 		;st(0)=a*a
	fiadd four		;a*a+4
	fist znam
	fild x 			;st(0)=a
	fiadd y 		;st(0)=a+b
	fidiv znam 		;st(0)=(a+b)/(a*a+4)
	fist f
	ret
p1 endp

p2 proc 			;вычисляем значение при a+b>7
	fild x 			;st(0)=a
	fimul three 	;st(0)=3*a
	fimul y 		;st(0)=3*a*b
	fisub one 		;st(0)=3*a*b-1
	fiadd y 		;st(0)=3*a*b-1+y
	fist f 
	ret
p2 endp

p3 proc 
	fild y 			;st(0)=b
	fimul y 		;st(0)=b*b
	fimul two 		;st(0)=2*b*b
	fist znam 
	fild x 			;st(0)=a
	fimul x 		;st(0)=a*a
	fimul three 	        ;st(0)=a*a*3
	fisub znam 		;st(0)=a*a*3-2*b*b
	fiadd one 		;st(0)=a*a*3-2*b*b+1
	fist f
	ret
	p3 endp
end main