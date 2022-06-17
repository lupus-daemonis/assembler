;Rineyskaya 21 Var
;Если минимальный элемент матрицы встречается более трех раз, то упорядочить элементы строк матрицы по возрас-танию методом стандартного обмена. 
;В противном случае матрицу оставить без изменения.
extrn vvod: near, disp: near
dseg segment para public 'data'
	mas db 16 dup(?) 			
	message1 db 'Enter n = $'	
	message2 db 'Enter m = $'	
	message3 db 'mas[$'
	message4 db ',$'
	message5 db '] = $'
	message6 db 'Isxodnaya matritsa$'
	message7 db 10, 13, '$'
	message8 db ' index: $'
	message9 db ' $'
	message10 db 'Polychenaya matritsa$'
	message11 db 'Max = $' 
	message12 db 'Min = $' 
	message14 db 'kolichestvo minimalnix elementov $'
	n dw ? 
	m dw ?	 
	min db ? 
	mindi dw ?
	col dw ?
dseg ends

sseg segment para stack 'stack' 
	db 50 dup(0) 
sseg ends

cseg segment para public 'code'
	osn proc near
		assume cs: cseg, ds: dseg, ss: sseg
		mov ax, dseg
		mov ds, ax  
		mov ax, 0002H
		int 10H
		
	;Ввод n
		lea dx, message1	
		mov ax, 0900h
		int 21h
		call vvod	
		mov n, bx	
	;Ввод m 
		lea dx, message2
		mov ax, 0900h
		int 21h
		call vvod	
		mov m, bx  
	
	;Ввод элементов массива
		mov cx, n 
		mov si, 0 
		mov bx, offset mas 
		startread:
			push cx 
			mov cx, m 
			mov di,0 
			reading:
				lea dx, message3 
				mov ax, 0900h
				int 21h
				mov ax, si
				call disp 
				lea dx, message4
				mov ax, 0900h
				int 21h
				mov ax, di
				call disp
				lea dx, message5 
				mov ax, 0900h
				int 21h
				push bx			
				call vvod	
				mov dl, bl	
				pop bx		
				mov mas[bx][di], dl 
				inc di	
			loop reading	
			pop cx	
			add bx,m 
			inc si	
		loop startread		
			 
	;Вывод элементов массива
		lea dx, message6 
		mov ax, 0900h
		int 21h
		lea dx, message7 
		mov ax, 0900h
		int 21h
		mov cx, n 
		mov si, 0 
		mov bx, offset mas 
		startwritein:
			push cx 
			mov cx, m 
			mov di, 0 
			writingin: 
				mov al,[bx][di] 
				cbw	
				call disp	
				lea dx, message9 
				mov ax, 0900h
				int 21h
				inc di	
			loop writingin	
			pop cx	
			add bx, m 
			inc si	 
			lea dx, message7 
			mov ax, 0900h
			int 21h
		loop startwritein 
		
			mov bx, offset mas 
			mov cx, n 	
			mov si, 0
			mov dl, mas[bx][si]	
			
	;Поиск минимального элемента 
			mov min, dl 
			mov ax, di 
			mov mindi, ax  
			stringfindmin:
				push cx
				mov cx, m
				mov di, 0
			columnfindmin: 
				mov al, mas[bx][di]   
				cmp al, min 
					jl findmin 
				jmp incdi
		
				findmin: 		
					mov min, al 
					mov dx, di 
					add dx, bx 
					mov mindi, dx
					jmp incdi 
				
				incdi: 
				inc di 
			loop columnfindmin
				pop cx
				add bx, m
				inc si
			loop stringfindmin
			
	;поиск количества минимальных элементов
			mov col, 0
			mov ax, di   
			mov bx, offset mas
			mov cx, n	
			stringfindcol:
				push cx
				mov cx, m
				mov di, 0
			columnfindcol: 
				mov al, mas[bx][di]   
				cmp al, min 
					je findcol 
				jmp incdi1
		
				findcol: 		
					inc col 
				
				incdi1: 
				inc di 
			loop columnfindcol
				pop cx
				add bx, m
			loop stringfindcol
			
	
	; Вывод минимального элементов и их индексов 
			lea dx, message7 
			mov ax, 0900h
			int 21h
			lea dx, message12 
			mov ax, 0900h
			int 21h
			mov al, min 
			mov ah, 0
			call disp 
			lea dx, message8 
			mov ax, 0900h
			int 21h
			mov ax, mindi  
			call disp
			lea dx, message7 
			mov ax, 0900h
			int 21h
			lea dx, message14
			mov ax, 0900h
			int 21h
			mov ax, col 
			mov ah, 0
			call disp
		
		; сортировка
cmp col,3
jle theend		
mov cx,n 
cikl1: 
push cx 
mov bx,offset mas 
mov cx,n 
cikl3: 
push cx 
mov cx,m 
dec cx 
mov si,0 
cikl2: 
mov di,si 
inc di 
mov al,mas[bx][si] 
mov dl,mas[bx][di] 
cmp al,dl 
jle met1 
mov mas[bx][si],dl 
mov mas[bx][di],al 
met1: 
inc si 
loop cikl2 
add bx,m 
pop cx 
loop cikl3 
pop cx 
loop cikl1

	;вывод полученной матрицы
	theend:
				lea dx,message7 
				mov ax,0900h
				int 21h
				lea dx,message7 
				mov ax,0900h
				int 21h
				lea dx, message10
				mov ax, 0900h
				int 21h
				lea dx, message7 
				mov ax, 0900h
				int 21h
				mov cx, n
				mov si, 0 
				mov bx, offset mas 
				startwriteout:
					push cx 
					mov cx, m 
					mov di, 0 
					writingout: 
						mov al,[bx][di] 
						cbw	
						call disp	
						lea dx, message9 
						mov ax, 0900h
						int 21h
						inc di
					loop writingout	
					pop cx	
					add bx, m 
					inc si	 
					lea dx, message7
					mov ax, 0900h
					int 21h
				loop startwriteout
					
		exit:
			mov ax, 4C00H
			int 21H	
	osn endp
cseg ends 
end osn