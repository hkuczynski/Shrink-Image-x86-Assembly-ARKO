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
; ebp-40 - pixel
; ebp-44 - loopWidth
; ebp-48 - loopHeight
; ebp-60 - newPadding
; ebp-64 - actPadding
;;;;;;;;;;;;;;;;;;;;;
; algorytm
;odwScale = 1 / scale;
;    loopHeight = 0;
;    
;    do
;    {
;        pixelOut = loopHeight * (newWidth *3 + newPadding);
;        pixel = ((int)(loopHeight / scale) * (actWidth *3 + actPadding));
;        loopWidth = 0;
;
;        do
;        {
;            pixelIn = pixel +  ((int)(loopWidth / scale) *3);
;            buffer[offset + pixelOut    ] =  buffer[offset + pixelIn    ];
;            buffer[offset + pixelOut + 1] =  buffer[offset + pixelIn + 1];
;            buffer[offset + pixelOut + 2] =  buffer[offset + pixelIn + 2];
;
;            loopWidth++;
;            pixelOut += 3;
;        } while(loopWidth < newWidth);
;
;        loopHeight++;
;    } while(loopHeight < newHeight);

global shrinkbmp24

SECTION .text

shrinkbmp24:
        push    ebp                                     ;
        mov     ebp, esp                                ;
        sub     esp, 68                                 ; deklaracja wielkosci stosu
        mov     edi, DWORD[ebp+8]                       ; zapisanie wskaznika na obraz
        
        mov     eax, dword [edi+10]                     ; pobranie offsetu 
        mov     dword [ebp-28], eax                    	; zapisanie
        mov     eax, dword [edi+18]                     ; pobranie szerokosci i zapisanie
        mov     dword [ebp-24], eax                     ; actWidth
        
        mov     eax, dword[ebp-24]                      ; wczytuje actWidth do eax
        mov     edx, dword[ebp+12]                      ; wczytuje scale_num do edx
        mul     edx                                     ; eax * edx
        shl     eax, 16                                 ; przesuwa o 16 w lewo
        mov     edx, 0                                  ; wczytuje 0 do edx
        mov     ecx, dword[ebp+16]                      ; wczytuje scale_den do ecx
        shl     ecx, 16                                 ; przesuwa o 16 w lewo
        div     ecx                                     ; eax / ecx
        shld    eax, edx, 16                
        shr     eax, 16                                 
        mov     dword[ebp-20], eax                      ; zapisuje 
        mov     DWORD[edi+18], eax                      ; zapisanie newWidth do tablicy

        mov     eax, dword [edi+22]                     ; pobranie aktualnej wysokosci i zapisanie
        mov     dword [ebp-32], eax                     ; actHeight
        mov     edx, dword[ebp+12]                      ; wczytuje scale_num do edx
        mul     edx                                     ; eax * edx
        shl     eax, 16                                 ; przesuwa o 16 w lewo
        mov     edx, 0                                  ; wczytuje 0 do edx
        mov     ecx, dword[ebp+16]                      ; wczytuje scale_den do ecx
        shl     ecx, 16                                 ; przesuwa o 16 w lewo
        div     ecx                                     ; eax / ecx
        shld    eax, edx, 16                
        shr     eax, 16                                 
        mov     dword[ebp-36], eax                      ; zapisanie newHeight
        mov     DWORD[edi+22], eax                      ; zapisanie newHeight

        mov     eax, dword [ebp-24]                     ; actPadding = 4 - ((actWidth * 3) % 4);
        lea     edx, [eax + eax*2]                      ; actWidth * 3
        and     edx, 3                                	; % 4
        mov     eax, 4                                  ;
        sub     eax, edx                                ;
        mov     dword [ebp-64], eax                     ;

        mov     eax, dword [ebp-20]                     ; newPadding = 4 - ((newWidth * 3) % 4);
        lea     edx, [eax + eax*2]                      ; newWidth * 3     
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
        mov     eax, dword [edi+18]                     ; wczytanie newWidth
        lea     eax, [eax + eax*2]                      ; newWidth * 3
        mov     ebx, dword [ebp-60]                     ; wczytanie newPadding
        add     eax, ebx                                ; obliczenie newWidth*3 + newPadding
        mov     ebx, DWORD[edi+22]                      ; wczytanie newHeight
        mul     ebx                                     ; (newWidth * 3 + newPadding) * newHeight
        mov     ebx, DWORD [edi+10]
        add     eax, ebx
        mov     dword [edi+2], eax
        mov     dword [ebp-48], 0                       ; loopHeight=0
        mov     eax, dword [edi+10]                     ; przesuniecie wskaznika o offset
        add     edi, eax                                ; przesuniecie wskaznika o offset                   
CyLoop:  
        mov     dword [ebp-44], 0                       ; loopWidth = 0
                                                        ; pixelOut = loopHeight * (newWidth *3 + newPadding);
        mov     eax, dword [ebp-20]                     ; wczytanie newWidth
        lea     edx, [eax + eax*2]                      ; newWidth * 3
        mov     eax, dword [ebp-60]                     ; pobranie newPadding
        add     eax, edx                                ; newWidth *3 + newPadding
        mov     ecx, dword [ebp-48]
        mul    ecx                                      ; mnozenie loopHeight*(newWidth *3 + newPadding)
        mov     dword [ebp-16], eax                     ; zapisanie wyniku pixelOut
                                                        ; pixel = loopHeight * scale_den / scale_num * (actWidth * 3 + actPadding);
        mov     eax, dword [ebp-48]                     ; wczytanie loopHeight
        mov     ecx, dword[ebp+16]                      ; wczytuje scale_den do edx
        mul     ecx                                     ; eax * edx
        shl     eax, 16
        mov     edx, 0                                  ; wczytuje 0 do edx
        mov     ecx, dword[ebp+12]                      ; wczytuje scale_num do ecx
        shl     ecx, 16                                 ; przesuwa o 16 w lewo
        div     ecx                                     ; eax / ecx
        shld    eax, edx, 16                
        shr     eax, 16                                 
        mov     ecx , eax
        mov     edx, dword [ebp-24]                     ; pobranie actWidth
        lea     edx, [edx + edx*2]
        mov     eax, dword [ebp-64]                     ; pobranie actPadding
        add     eax, edx                                ; dodanie actPadding+actWidth*3
        mul     ecx                                     ; (cy / scale) * (actWidth *3 + actPadding)
        mov     dword [ebp-40], eax                     ; zapisanie wyniku pixelIn

CxLoop: 
                                                        ; pixelIn = pixel +  ((int)(loopWidth / scale) *3);
        mov     eax, dword[ebp-44]                      ; wczytanie loopWidth do eax
        mov     ecx, dword[ebp+16]                      ; wczytanie scale_den do ecx
        mul     ecx                                     ; loopWidth * scale_den
        shld    eax, edx, 16                            
        mov     edx, 0                                  ; wczytanie 0 do edx
        mov     ecx, dword[ebp+12]                      ; wczytanie scale_num do edx
        shl     ecx, 16                                 ; przesuniecie o 16 w lewo
        div     ecx                                     ; loopWidth * scale_den / scale_num
        shld    eax, edx, 16    
        shr     eax, 16                                 ; przesuniecie o 16 w prawo
        
        mov     ecx, 3                                  ; wczytanie 3 do ecx
        mov     edx, 0                                  ; wczytanie 0 do edx
        mul     ecx                                     ; (int)(loopWidth / scale) *3
        mov     ecx, dword[ebp-40]                      ; wczytanie pixel do ecx
        add     eax, ecx                                ; pixel +  ((int)(loopWidth / scale) *3)
        mov     dword[ebp-12], eax                      ; zapisanie wyniku pixelIn

        mov     edx, dword [ebp-16]                     ; wczytanie pixelOut do edx
        mov     eax, edi                                ; wczytanie wskaznika na tablice do eax
        add     edx, eax                                ; eax + offset + pixelOut => wskaznik w edx
        mov     ecx, dword [ebp-12]                     ; wczytanie pixelIn do ecx
        mov     eax, edi                                ; wczytanie wskaznika na tablice do eax
        add     eax, ecx                                ; przesuniecie o pixelIn
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
                                                        ; pixelOut obliczanie
        mov     eax, dword [ebp-16]                     ; wczytanie pixelOut do eax
        mov     edx, 3                                  ; wczytanie 3 do edx
        add     eax, edx                                ; dodanie
        mov     dword [ebp-16], eax                     ; zapisanie pixelOut
    
        add     dword [ebp-44], 1                       ; dekrementacja loopWidth
        mov     eax, dword[ebp-44]
        cmp     eax, dword [ebp-20]
        jl      CxLoop                                  ; sprawdzenie czy wieksze od 0

        add     dword [ebp-48], 1                       ; inkrementacja loopHeight
        mov     eax, dword [ebp-48]                     ; 
        cmp     eax, dword [ebp-36]                     ; 
        jl      CyLoop                                  ; 
exit:
        leave                                           ; 
        ret                                             ; 