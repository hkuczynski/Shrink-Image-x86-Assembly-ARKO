;;;;;;;;;;;;;;;;;;;
;;zmienne lokalne;;
;;;;;;;;;;;;;;;;;;;
; ebp-12 - pixelIn
; ebp-16 - pixelOut
; ebp-20 - newWidth
; ebp-24 - actWidth
; ebp-28 - offset
; ebp-32 - actHeight
; ebp-36 - newHeight
; ebp-40 - scale
; ebp-44 - loopWidth
; ebp-48 - loopHeight
; ebp-52 - 1/scale
; ebp-60 - newPadding
; ebp-64 - actPadding

global shrinkbmp24

SECTION .text

shrinkbmp24:
        push    ebp                                     ;
        mov     ebp, esp                                ;
        sub     esp, 88                                 ; deklaracja wielkosci stosu
        mov     edi, DWORD[ebp+8]                       ; zapisanie wskaznika na obraz

        mov     eax, dword [ebp+12]                     ; wczytanie scale_num do eax
        shl     eax, 16                                 ; przesuniecie o 16 w lewo
        mov     edx, 0                                  ; wczytanie 0 do edx
        mov     ecx, dword [ebp+16]                     ; wczytanie scale_den do ecx
        div     ecx                                     ; scale_num / scale_den
        shld     eax, edx, 16                           
        shr     eax, 16
        mov     dword [ebp-40], eax                     ; zapisanie wyniku
                                                        ; obliczanie 1 / scale
        mov     eax, 1                                  ; wczytanie 1 do eax
        shl     eax, 16                                 ; przesuniecie o 16 w lewo
        mov     edx, 0                                  ; wczytanie 0 do edx
        mov     ecx, dword [ebp-40]                     ; wczytanie scale do ecx
        div     ecx                                     ; 1 / scale
        shld     eax, edx, 16               
        shr     eax, 16
        mov     dword [ebp-52], eax                     ;zapisanie wyniku
        
        mov     eax, dword [edi+10]                     ; pobranie offsetu 
        mov     dword [ebp-28], eax                    	; zapisanie
        mov     eax, dword [edi+18]                     ; pobranie szerokosci i zapisanie
        mov     dword [ebp-24], eax                     ; actWidth
        
        mov     eax, dword[ebp-24]                      ; wczytuje actWidth do eax
        imul    eax, dword[ebp-40]                      ; mnozy przez scale
        shr     eax, 16                                 ; przesuwa o 16 (fix to int)
        mov     dword[ebp-20], eax                      ; zapisuje 
        mov     DWORD[edi+18], eax                      ; zapisanie newWidth do tablicy

        mov     eax, dword [edi+22]                     ; pobranie aktualnej wysokosci i zapisanie
        mov     dword [ebp-32], eax                     ; actHeight

        mov     eax, dword[ebp-32]                      ; wczytanie actHeight do eax
        imul    eax, dword[ebp-40]                      ; pomnożenie przez scale
        shr     eax, 16                                 ;przesuniecie o 16
        mov     dword[ebp-36], eax                      ;zapisanie newHeight
        mov     DWORD[edi+22], eax                      ; zapisanie newHeight

        mov     edx, dword [ebp-24]                     ; actPadding = 4 - ((actWidth * 3) % 4);
        mov     eax, edx                                ;
        shl     eax, 1                                  ;
        add     edx, eax                                ;
        and     edx, 3                                	; % 4
        mov     eax, 4                                  ;
        sub     eax, edx                                ;
        mov     dword [ebp-64], eax                     ;

        mov     edx, dword [ebp-20]                     ; newPadding = 4 - ((newWidth * 3) % 4);
        mov     eax, edx                                ;
        shl     eax, 1                                  ;
        add     edx, eax                                ;
        and     edx, 3                                  ; % 4
        mov     eax, 4                                  ;
        sub     eax, edx                                ;
        mov     dword [ebp-60], eax                     ;

        cmp     dword [ebp-64], 4                       ; if(actPadding == 4)
        jnz     skipActPadding                          ;
        mov     dword [ebp-64], 0                       ;
skipActPadding  :
        cmp     dword [ebp-60], 4                       ;
        jnz     skipNewPadding                          ;
        mov     dword [ebp-60], 0                       ;
skipNewPadding  :
                                                        ; obliczanie size
        mov     eax, dword [edi+18]                     ; wczytanie newHeight
        shl     eax, 1                                  ; newHeight *= 2
        add     eax, eax                                ; newHeight += newHeight
        mov     ebx, dword [ebp-60]                     ; wczytanie newPadding
        add     eax, ebx                                ; obliczenie newWidth*3 + newPadding
        mov     ebx, DWORD[edi+22]                      ; wczytanie newHeight
        mul     ebx                                     ; (newWidth * 3 + newPadding) * newHeight
        mov     ebx, DWORD [edi+10]
        add     eax, ebx
        mov     dword [edi+2], eax
        mov     dword [ebp-48], 0                       ; loopHeight=0
        mov     eax, dword [edi+10]                     ; przesuniecie wskaznika o ofsset
        add     edi, eax                                ; przesuniecie wskaznika o ofsset                   
CyLoop:  
        mov     eax, dword [ebp-20]
        dec     eax
        mov     dword [ebp-44], eax
                                                        ; pixelOut = loopHeight * (newWidth *3 + newPadding);
        mov     edx, dword [ebp-20]                     ; obliczanie pixelOut
        mov     eax, edx                                ; newWidth *3
        add     eax, eax                                ; 
        add     edx, eax                                ; 
        mov     eax, dword [ebp-60]                     ; pobranie newPadding
        add     eax, edx                                ; newWidth *3 + newPadding
        imul    eax, dword [ebp-48]                     ; mnozenie cy*(newWidth *3 + newPadding)
        mov     dword [ebp-16], eax                     ; zapisanie wyniku pixelOut

        mov     eax, dword [ebp-48]                     ; wczytanie loopHeight
        shl     eax, 16
        mov     edx, 0
        mov     ecx, dword [ebp-40]                     ; wczytanie scale
        div     ecx
        shld     eax, edx, 16                           
        shr     eax, 16
        mov     dword [ebp-72], eax

        mov     ecx, dword [ebp-72]                     ; zapisanie do ecx = cyScaleActWidth3Scale
        mov     edx, dword [ebp-24]                     ; pobranie actWidth
        mov     eax, edx                                ; obliczanie actWidth*3
        add     eax, eax                                ;       =||=
        add     edx, eax                                ;       =||=
        mov     eax, dword [ebp-64]                     ; pobranie actPadding
        add     eax, edx                                ; dodanie actPadding+actWidth*3
        imul    eax, ecx                                ; (cy / scale) * (actWidth *3 + actPadding)
        mov     dword [ebp-12], eax                     ; zapisanie wyniku pixelIn
        
CxLoop: 
        mov     edx, dword [ebp-16]                      ; pobranie pixelOut
        mov     eax, edi
        add     edx, eax                                ; eax + offset + pixel => wskaznik w edx
        mov     ecx, dword [ebp-12]                      ; pobranie nearestMatch
        mov     eax, edi
        add     eax, ecx                                ; przesuniecie o offset+NearestMatch
        movzx   ecx, byte [eax]                         ; pobranie bajtu z eax w ecx
        mov     byte [edx], cl                          ; zapisanie bajtu w edx
        inc     eax                                     ; inkrementacja i zamiana pozostalych 2 bajtow
        inc     edx                                     ; inkrementacja i zamiana pozostalych 2 bajtow
        movzx   ecx, byte [eax]                         ; inkrementacja i zamiana pozostalych 2 bajtow
        mov     byte [edx], cl                          ; inkrementacja i zamiana pozostalych 2 bajtow
        inc     eax                                     ; inkrementacja i zamiana pozostalych 2 bajtow
        inc     edx                                     ; inkrementacja i zamiana pozostalych 2 bajtow
        movzx   ecx, byte [eax]                         ; inkrementacja i zamiana pozostalych 2 bajtow
        mov     byte [edx], cl                          ; inkrementacja i zamiana pozostalych 2 bajtow
        ;pixelOut obliczanie
        mov     eax, dword [ebp-16]
        mov     edx, 3
        add     eax, edx
        mov     dword [ebp-16], eax
        

        
        ;pixelIn obliczanie

        mov     eax, dword [ebp-52]
        mov     ecx, 3
        shl     ecx, 16
        imul    eax, ecx
        shr     eax, 16
        mov     edx, dword [ebp-12]
        add     eax, edx
        mov     dword [ebp-12], eax
        
        sub     dword [ebp-44], 1                       ; 
        jnz      CxLoop  

        add     dword [ebp-48], 1                       ; 
        mov     eax, dword [ebp-48]                     ; 
        cmp     eax, dword [ebp-36]                     ; 
        jl      CyLoop                                  ; 
exit:
        leave                                           ; 
        ret                                             ; 

