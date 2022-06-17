;Rineyskaya 21 Var
;Если максимальный элемент вектора больше 10, то все отрицательные элементы обнулить.
extrn VVOD:near,disp:near
dseg segment para public 'data'
	mas db 10 dup (?)
	max db ?
	sum db ?
	mes1 db 'Vvedite n=$'
	mes2 db 'mas[$'
	mes3 db ']=$'
	mes4 db 'Vector$'
	mes5 db 10,13,'$'
  	mes6 db ' $'
	mes7 db 'Max=$'
	mes8 db 'Sum=$'
	n dw ?
dseg ends
sseg segment para stack 'stack'
	db 30 dup(0)			
sseg ends
cseg segment para public 'code'
osn proc near
	assume cs:cseg,ds:dseg,ss:sseg
	mov ax,dseg
	mov ds,ax
;ввод вектора, очистка экрана
	mov ax,0002h
	int 10h
;ввод размерности вектора n
	lea dx,mes1
	mov ax,0900h
	int 21h
	call VVOD
	mov n,bx
;вывод элементов вектора
	mov cx,n
	mov si,0
zikl1:
	lea dx,mes2
	mov ax,0900h
	int 21h
	mov ax,si
	call disp
	lea dx,mes3
	mov ax,0900h
	int 21h
	call VVOD
	mov mas[si],bl
	inc si
	loop zikl1
;вывод вектора
	lea dx,mes4
	mov ax,0900h
	int 21h
	lea dx,mes5
	mov ax,0900h
	int 21h
	mov cx,n
	mov si,0
zikl2:
	mov al,mas[si]
	cbw
	call disp
	lea dx,mes6
	mov ax,0900h
	int 21h
	inc si
	loop zikl2
;нахождение максимального элемена 
	mov cx,n
	mov si,0
	mov al,mas
zikl3:
	cmp al,mas[si]
	jg m1
	mov al,mas[si]
m1: 	inc si
	loop zikl3
	mov max, al
;сравнение с 10
	mov al, max
	cmp al,10  
	jl m2
;замена отрицательных элеменнов
	mov cx,n  
	mov si,0
start:  cmp mas[si],0  
	jg met  
	mov mas[si],0 
met:    inc si  
	loop start
	
m2: lea dx,mes5    
	mov ax,0900h    
	int 21h    
	lea dx,mes7      
	mov ax,0900h    
	int 21h    
	mov al,max    
	cbw    
	call disp   
	
;вывод полученного вектора
	lea dx,mes5
	mov ax,0900h
	int 21h
	mov cx,n
	mov si,0
zikl4:
	mov al,mas[si]
	cbw
	call disp
	lea dx,mes6
	mov ax,0900h
	int 21h
	inc si
	loop zikl4
;завершение программы
	mov ax,4c00h
	int 21h
osn endp
cseg ends
end osn