;Rineyskaya 21 Var
;y=(2a+4b-3)/8
dseg segment para public 'data'
	a db 3
	b db 2
	y db ?
	mesa db 10,13,'a=$'
	mesb db 10,13,'b=$'
	mesy db 10,13,'y=$'
dseg ends
sseg segment para stack 'stack'
	db 256 dup (0)
sseg ends
	extrn disp:near
cseg segment para public 'code'
	main proc near 
	assume cs:cseg, ds:dseg, ss:sseg 
	mov ax,dseg
	mov ds,ax 
	mov al,a    ;al=a 
	sal al,1    ;al=2a
	mov bl,b    ;bl=b
	sal bl,2    ;bl=4b 	
	add al,bl   ;al=2a+4b
	sub al,3    ;al=2a+4b-3
	sar al,3    ;al=(2a+4b-3)/8
	mov y,al    ;y=al 
	lea dx,mesa 
	mov ax,0900H
	int 21H
	mov al,a 
	cbw 
	call disp 
	lea dx,mesb 
	mov ax,0900H
	int 21H
	mov al,b 
	cbw 
	call disp
	lea dx,mesy 
	mov ax,0900H
	int 21H
	mov al,y 
	cbw 
	call disp
	mov ax,4c00H 
	int 21H 
main endp 
cseg ends
end main 