;Movendo um quadrado branco de 10x10 pixels na tela

org 100h

jmp start  
         
col dw ?
ant_col dw ?
ant_linha dw ?
linha dw 10
aux_ax dw ?
aux_cx dw ?
aux_dx dw ?

start:
mov al,13h
mov ah,0
int 10h     ; set graphics video mode. 
mov cx,0
mov dx,0
mov col,10
mov ant_col,0
mov ant_linha,0

mov al, 0xf
again:
    cmp dx,linha
    jz para
      
    mov ah, 0ch
    int 10h         ;seta o pixel. not inrio pretense
    inc cx
    push ax
    mov ax,col
    cmp cx,ax
    pop ax
    jz pula_linha
    jmp again 
    
    
    pula_linha:
        inc dx 
        cmp dx,linha
        jz para
        mov cx,ant_col
        jmp again
        


;stop:    
;    mov cx,0x0
;    mov dx,0x0    
para:
    ; Limpa o cursor
    
    mov dx,0
    mov bh,0   
    mov ah,2
        
    int 10h
    
    mov ah,1h
    int 21h
    
    ; Baixo
    cmp al,'S' 
    jz S
    
    cmp al,'s' 
    jz S
    
    ; Direita        
    cmp al,'D'
    jz D
     
    cmp al,'d'
    jz D
    
    ; Esquerda
    cmp al,'A'
    jz A
     
    cmp al,'a'
    jz A
    
    ; Cima
    cmp al,'W'
    jz W
            
    cmp al,'w'
    jz W 
    
D:
    mov dx,ant_linha
    mov al,0xc 
    
    mov ant_col,cx
    add col,10
    jmp again

S:
    add ant_linha,10
    mov dx,ant_linha
    mov al,0xc
    mov cx,ant_col 
    add linha,10
    jmp again    

A:
    mov dx,ant_linha
    mov al,0xf 
              
    sub ant_col,10
    mov cx,ant_col
    sub col,10
    jmp again     
    

W:
    sub ant_linha,10
    mov dx,ant_linha
    mov al,0xf
    mov cx,ant_col
    sub linha,10
    jmp again   


;mov aux_ax,ax
;    mov aux_cx,dx
;    mov aux_dx,cx 
;    jmp limpa
;    continua:
;    mov ah,aux_ax
;    mov cx,aux_dx
;    mov dx,aux_cx
;limpa:  
;    mov cx,ant_linha
;    mov dx,ant_col
;    mov al,0x0
    
;    again2:
;        cmp dx,linha
;        jz continua
          
;        mov ah, 0ch
;        int 10h         ;seta o pixel. not inrio pretense
;        inc cx
;        push ax
;        mov ax,col
;        cmp cx,ax
;        pop ax
;        jz pula_linha2
;        jmp again2 
    
    
;        pula_linha2:
;            inc dx 
;            cmp dx,linha
;            jz continua
;            mov cx,ant_col
;            jmp again2

ret




