;Movendo um quadrado branco de 10x10 pixels na tela

org 100h
             
jmp startCenario
;jmp startJogo
         
col dw ? ;armazena o tamanho da coluna (10px) 
ant_col dw ? ; inicio impressao, coluna
ant_linha dw ? ; inicio impressao, linha
linha dw 104 ;o maximo de linha que ele vai imprimir
aux_ax dw ?
aux_cx dw ?
aux_dx dw ?


startCenario:
    
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
;mov al,13h
;mov ah,0
;int 10h     ; set graphics video mode.
 
mov cx,154
mov dx,94
mov col,164
mov ant_col,154
mov ant_linha,94
mov al, 0xf ; pixel color


again:
    ;mov al, 0xf
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
    
    colisao_D:
        mov al,0x4 ; vermelho 0
        
    continua_D:
        mov dx,ant_linha
        add ant_col,10
        add col,10
        jmp again

S:  ;Funcionando
    cmp dx,200
    jz auxiliar
    jmp apaga_S
    
    colisao_S:
        mov al,0x4 ; vermelho 0
         
    continua_S:
        add ant_linha,10
        mov dx,ant_linha
        mov cx,ant_col 
        add linha,10
        jmp again    

A:  ;Funcionando
    mov cx,ant_col
    cmp cx,0
    jz auxiliar  ; borda
    jmp apaga_A
    
    colisao_A:
       mov al,0x4 ; vermelho 0
             
    continua_A: 
        mov dx,ant_linha             
        sub ant_col,10
        mov cx,ant_col
        sub col,10
        jmp again     
    

W:  
    mov dx,ant_linha
    cmp dx,0
    jz auxiliar
    jmp apaga_W
    
    colisao_W:
       mov al,0x4 ; vermelho 
    
    continua_W:
        sub ant_linha,10
        mov dx,ant_linha
        mov cx,ant_col
        sub linha,10
        jmp again   
         
         
apaga_D:
    mov al,0x0
    mov dx,ant_linha
    mov cx,ant_col
    
    imprimir_apaga_D:
        cmp dx,linha
        jz colisao2_tecla_D
      
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
        jz colisao2_tecla_D
        mov cx,ant_col
        jmp imprimir_apaga_D
  
        
apaga_S:  
    mov dx,ant_linha
    mov al,0x0
    mov cx,ant_col 

    imprimir_apaga_S:
        cmp dx,linha
        jz colisao2_tecla_S
      
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
        jz colisao2_tecla_S
        mov cx,ant_col
        jmp imprimir_apaga_S 
      
        
apaga_A:  
    mov dx,ant_linha
    mov al,0x0
    mov cx,ant_col

    imprimir_apaga_A:
        cmp dx,linha
        jz colisao1_tecla_A
      
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
        jz colisao1_tecla_A
        mov cx,ant_col
        jmp imprimir_apaga_A
      
        
apaga_W:
    mov dx,ant_linha
    mov al,0x0
    mov cx,ant_col 

    imprimir_apaga_W:
        cmp dx,linha
        jz colisao1_tecla_W
      
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
        jz colisao1_tecla_W
        mov cx,ant_col
        jmp imprimir_apaga_W
                            
                            

auxiliar:  ; colidiu com a borda
    mov al,0xf
    mov cx,ant_col
    mov dx,ant_linha
    jmp again                            
   

colisao1_tecla_A: ; colisao tecla A
    colisao_coluna_A: ; verifica se ele colidiu com a coluna 1
        cmp cx, 100    ; <=
        jle colisao_linha1_A ; tive a colisao na coluna 1, verificando a linha
        mov al,0xf
        jmp continua_A

        colisao_linha1_A: ; verifica se colidiu na coluna 2
            cmp dx, 100
            jle colisao_A  ; colidiu coluna e linha
            mov al,0xf
            jmp continua_A ; everything is good, for now
            

colisao1_tecla_W:
    colisao_coluna_W: ; verifica se ele colidiu com a coluna 1
        cmp dx, 100    ; <=
        jle colisao_linha1_W ; tive a colisao na coluna 1, verificando a linha
        mov al,0xf
        jmp continua_W

        colisao_linha1_W: ; verifica se colidiu na coluna 2
            cmp cx, 100
            jle colisao_W  ; colidiu coluna e linha
            mov al,0xf
            jmp continua_W ; everything is good, for now


colisao2_tecla_S: ; colisao tecla A
    colisao_coluna_S: ; verifica se ele colidiu com a coluna 1
        cmp dx, 100    ; <=
        jge colisao_linha1_S ; tive a colisao na coluna 1, verificando a linha
        mov al,0xf
        jmp continua_S

        colisao_linha1_S: ; verifica se colidiu na coluna 2
            cmp cx, 220
            jge colisao_S  ; colidiu coluna e linha
            mov al,0xf
            jmp continua_S ; everything is good, for now
            

colisao2_tecla_D:
    colisao_coluna_D: ; verifica se ele colidiu com a coluna 1
        cmp cx, 220    ; <=
        jge colisao_linha1_D ; tive a colisao na coluna 1, verificando a linha
        mov al,0xf
        jmp continua_D

        colisao_linha1_D: ; verifica se colidiu na coluna 2
            cmp dx, 100
            jge colisao_D  ; colidiu coluna e linha
            mov al,0xf
            jmp continua_D ; everything is good, for now


fim: ret