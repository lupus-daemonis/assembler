;Rineyskaya 21 Var 
;Поменять местами максимальный и минимальный элементы на побочной диагонали
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
	message9 db ' $'
	message10 db 'Polychenaya matritsa$'
	message11 db 'Max = $'
	message12 db 'Min = $'
	message13 db 'Elementi diagonali$' 
	errormessage1 db 'Matritsa ne kvadratnaya$' 
	n dw ? 
	m dw ?	
	max db ? 
	maxdi dw ? 
	min db ? 
	mindi dw ?
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
	
; ОБРАБОТКА МАТРИЦЫ
	; Проверка, квадратная ли матрица
		mov ax, n 
		cmp ax, m
			jne error1 	
		jmp ok 
	
		error1: 
			lea dx, errormessage1
			mov ax,0900h
			int 21h
			jmp exit	
		
		ok:		
			mov bx, offset mas 
			mov cx, n 
			mov di, m 
			dec di	
			mov dl, mas[bx][di]	
	
	;Поиск максимального и минимального элемента
			mov max, dl 
			mov min, dl 
			mov ax, di 
			mov mindi, ax 
			mov maxdi, ax 
			side: 
				mov al, mas[bx][di] 
				cmp al, max 
					jg findmax  
				cmp al, min 
					jl findmin 
				jmp incdi
		
				findmin: 		
					mov min, al 
					mov dx, di 
					add dx, bx 
					mov mindi, dx
					jmp incdi
	
				findmax: 
				mov max, al 
				mov dx, di 
				add dx, bx 
				mov maxdi, dx 
				
				incdi:
				add bx, m 
				dec di 
			loop side 
	
	; Вывод максимального и минимального элементов и их индексов
			lea dx, message7 
			mov ax, 0900h
			int 21h
			lea dx, message11 
			mov ax, 0900h
			int 21h
			mov al, max 
			mov ah, 0
			call disp 
			lea dx, message7 
			mov ax, 0900h
			int 21h
			lea dx, message12 
			mov ax, 0900h
			int 21h
			mov al, min 
			mov ah, 0
			call disp 
		
		; Перестановка максимального и минимального элементов
				mov bx, offset mas 
				mov di, maxdi 
				mov si, mindi 
				mov al, mas[bx][di] 
				mov dl, mas[bx][si] 
				mov mas[bx][di], dl 
				mov mas[bx][si], al 	

	;вывод полученной матрицы
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