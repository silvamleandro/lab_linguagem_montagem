
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h   


mov al, 13h
mov ah, 0
int 10h       ; set graphics video mode. 
	
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
        jz fim
    
        jmp b2_fim   
    
fim: ret




