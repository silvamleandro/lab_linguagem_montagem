
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

;Movendo um quadrado branco de 10x10 pixels na tela

org 100h

jmp startBlocos   
         
col dw ? ;armazena o tamanho da coluna (10px) 
ant_col dw ? ; inicio impressao, coluna
ant_linha dw ? ; inicio impressao, linha
linha dw 104 ;o maximo de linha que ele vai imprimir
aux_ax dw ?
aux_cx dw ?
aux_dx dw ?

startBlocos:
mov al,13h
mov ah,0
int 10h     ; set graphics video mode.

b1_imprimir:
    ;valores iniciais variaveis
    mov al, 0x7  ; pixel color
    mov cx, 0   ; column
    mov dx, 0   ; row

                          
    b1_inicio: ; imprimir cinza 100x100  
        ;atualizar
        mov ah, 0ch
    	int 10h
    	
    	inc cx ; incrementando coluna
        cmp cx, 100
        jz b1_pularlinha_inicio 

        jmp b1_inicio                                
        
        
    b1_pularlinha_inicio:  
        mov cx, 0 ; zerando a coluna
        inc dx    ; prox linha  
    
        cmp dx, 5
        jz b1_meio_esq
    
        jmp b1_inicio                   

    
    
    b1_meio_esq:
        ;atualizar
        mov ah, 0ch
    	int 10h 
    	
    	inc cx ; incrementando coluna
        cmp cx, 5  
        jz b1_esq_to_dir
        
        jmp b1_meio_esq
        
    b1_esq_to_dir:
        mov cx, 95
        jmp b1_meio_dir
    
    
    b1_meio_dir: 
        ;atualizar
        mov ah, 0ch
    	int 10h 
    	
    	inc cx ; incrementando coluna
        cmp cx, 100  
        jz b1_pularlinha_meio
        
        jmp b1_meio_dir
    	
    	    
    b1_pularlinha_meio:  
        mov cx, 0 ; zerando a coluna
        inc dx    ; prox linha  
    
        cmp dx, 95
        jz b1_fim
    
        jmp b1_meio_esq                       
              
          
          
    b1_fim:  
        ;atualizar
        mov ah, 0ch
    	int 10h
    	
    	inc cx ; incrementando coluna
        cmp cx, 100
        jz b1_pularlinha_fim 

        jmp b1_fim  
                    
                    
    b1_pularlinha_fim:
        mov cx, 0 ; zerando a coluna
        inc dx    ; prox linha  
    
        cmp dx, 100
        jz b2_imprimir
    
        jmp b1_fim  
     
     

b2_imprimir:
    ;valores iniciais variaveis
    mov al, 0x7  ; pixel color
    mov cx, 220   ; column
    mov dx, 100   ; row

                          
    b2_inicio: ; imprimir cinza 100x100  
        ;atualizar
        mov ah, 0ch
    	int 10h
    	
    	inc cx ; incrementando coluna
        cmp cx, 320
        jz b2_pularlinha_inicio 

        jmp b2_inicio                                
        
        
    b2_pularlinha_inicio:  
        mov cx, 220 ; zerando a coluna
        inc dx    ; prox linha  
    
        cmp dx, 105
        jz b2_meio_esq
    
        jmp b2_inicio                   

    
    
    b2_meio_esq:
        ;atualizar
        mov ah, 0ch
    	int 10h 
    	
    	inc cx ; incrementando coluna
        cmp cx, 225  
        jz b2_esq_to_dir
        
        jmp b2_meio_esq
        
    b2_esq_to_dir:
        mov cx, 315
        jmp b2_meio_dir
    
    
    b2_meio_dir: 
        ;atualizar
        mov ah, 0ch
    	int 10h 
    	
    	inc cx ; incrementando coluna
        cmp cx, 320  
        jz b2_pularlinha_meio
        
        jmp b2_meio_dir
    	
    	    
    b2_pularlinha_meio:  
        mov cx, 220 ; zerando a coluna
        inc dx    ; prox linha  
    
        cmp dx, 195
        jz b2_fim
    
        jmp b2_meio_esq                       
              
          
          
    b2_fim:  
        ;atualizar
        mov ah, 0ch
    	int 10h
    	
    	inc cx ; incrementando coluna
        cmp cx, 320
        jz b2_pularlinha_fim 

        jmp b2_fim  
                    
                    
    b2_pularlinha_fim:
        mov cx, 220 ; zerando a coluna
        inc dx    ; prox linha   
        
        cmp dx, 200
        jz startJogo
    
        jmp b2_fim




startJogo:
 
mov cx,154
mov dx,94
mov col,164
mov ant_col,154
mov ant_linha,94

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
    
 
D:  ;Funcionando
    cmp cx,320
    jz auxiliar  
    
    jmp apaga_D 
    continua_D:
        mov dx,ant_linha
        mov al,0xf 
        
        ;mov ant_col,cx  
        add ant_col,10
        add col,10
        jmp again

S:  ;Funcionando
    cmp dx,200
    jz auxiliar
    jmp apaga_S
    continua_S:
        add ant_linha,10
        mov dx,ant_linha
        mov al,0xf
        mov cx,ant_col 
        add linha,10
        jmp again    

A:  ;Funcionando
    mov cx,ant_col
    cmp cx,0
    jz auxiliar
    jmp apaga_A
    continua_A:
        mov dx,ant_linha
        mov al,0xf 
                  
        sub ant_col,10
        mov cx,ant_col
        sub col,10
        jmp again     
    

W:  
    mov dx,ant_linha
    cmp dx,0
    jz auxiliar
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
    ;sub cx, 10
    ;mov ant_col,cx 
    mov cx,ant_col
    
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
                            
                            
auxiliar:
    mov al,0xc
    mov cx,ant_col
    mov dx,ant_linha
    jmp again                            

                
fim: ret

ret




