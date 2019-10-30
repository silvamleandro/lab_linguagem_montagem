;Movendo um quadrado branco de 10x10 pixels na tela

org 100h

jmp start  
         
col dw ? ;armazena o tamanho da coluna (10px) 
ant_col dw ? ; inicio impressao, coluna
ant_linha dw ? ; inicio impressao, linha
linha dw 10 ;o maximo de linha que ele vai imprimir
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

again:
    mov al, 0xf
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
    mov cx,0
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
    
 
D:  cmp cx,320
    jz again
    jmp apaga_D 
    continua_D:
        mov dx,ant_linha
        mov al,0xf 
        
        mov ant_col,cx
        add col,10
        jmp again

S:  
    cmp dx,200
    jz again
    jmp apaga_S
    continua_S:
        add ant_linha,10
        mov dx,ant_linha
        mov al,0xf
        mov cx,ant_col 
        add linha,10
        jmp again    

A:  
    cmp cx,0
    jz again
    jmp apaga_A
    continua_A:
        mov dx,ant_linha
        mov al,0xf 
                  
        sub ant_col,10
        mov cx,ant_col
        sub col,10
        jmp again     
    

W:  
    cmp dx,0
    jz again
    jmp apaga_W
    continua_W:
        sub ant_linha,10
        mov dx,ant_linha
        mov al,0xf
        mov cx,ant_col
        sub linha,10
        jmp again   
         
         
apaga_D:
    mov al,0x0
    mov dx,ant_linha
    sub cx, 10
    mov ant_col,cx
    
    imprimir_apaga_D:
        cmp dx,linha
        jz continua_D
      
        mov ah, 0ch
        int 10h       
        inc cx
        push ax
        mov ax,col
        cmp cx,ax
        pop ax
        jz pula_linha_apaga_D
        jmp imprimir_apaga_D 
    
    pula_linha_apaga_D:
        inc dx 
        cmp dx,linha
        jz continua_D
        mov cx,ant_col
        jmp imprimir_apaga_D
  
        
apaga_S:
    mov dx,ant_linha
    mov al,0x0
    mov cx,ant_col 

    imprimir_apaga_S:
        cmp dx,linha
        jz continua_S
      
        mov ah, 0ch
        int 10h       
        inc cx
        push ax
        mov ax,col
        cmp cx,ax
        pop ax
        jz pula_linha_apaga_S
        jmp imprimir_apaga_S 
    
    pula_linha_apaga_S:
        inc dx 
        cmp dx,linha
        jz continua_S
        mov cx,ant_col
        jmp imprimir_apaga_S 
      
        
apaga_A:
    mov dx,ant_linha
    mov al,0x0
    mov cx,ant_col

    imprimir_apaga_A:
        cmp dx,linha
        jz continua_A
      
        mov ah, 0ch
        int 10h       
        inc cx
        push ax
        mov ax,col
        cmp cx,ax
        pop ax
        jz pula_linha_apaga_A
        jmp imprimir_apaga_A 
    
    pula_linha_apaga_A:
        inc dx 
        cmp dx,linha
        jz continua_A
        mov cx,ant_col
        jmp imprimir_apaga_A
      
        
apaga_W:
    mov dx,ant_linha
    mov al,0x0
    mov cx,ant_col 

    imprimir_apaga_W:
        cmp dx,linha
        jz continua_W
      
        mov ah, 0ch
        int 10h       
        inc cx
        push ax
        mov ax,col
        cmp cx,ax
        pop ax
        jz pula_linha_apaga_W
        jmp imprimir_apaga_W
    
    pula_linha_apaga_W:
        inc dx 
        cmp dx,linha
        jz continua_W
        mov cx,ant_col
        jmp imprimir_apaga_W

fim: ret