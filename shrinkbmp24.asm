; algorytm
;    cy = 0;
;    do
;    {
;        cx = 0;
;        
;        cyNewWidthNewPadding = cy * (newWidth *3 + newPadding);
;        cyScaleActWidth3Scale = (int)(cy / scale) * (actWidth *3 + actPadding);
;        
;        do
;        {
;            pixel_new = (cyNewWidthNewPadding + (cx*3));
;            pixel_old =  (cyScaleActWidth3Scale + ((int)(cx / scale) *3) );
;               
;            image[offset + pixel_new    ] =  image[offset + pixel_old    ];
;            image[offset + pixel_new + 1] =  image[offset + pixel_old + 1];
;            image[offset + pixel_new + 2] =  image[offset + pixel_old + 2];
;            
;            cx++;
;        } while(cx < newWidth);
;        
;        cy++;
;    } while(cy < newHeight);


;zmienne lokalne
; ebp-40 - scale
; ebp-20 - newWidth
; ebp-36 - newHeight
; ebp-28 - offset
; ebp-32 - actHeight
; ebp-24 - actWidth
; ebp-64 - actPadding
; ebp-60 - newPadding

global shrinkbmp24

SECTION .text                           

shrinkbmp24:
        push    ebp                                     ; 
        mov     ebp, esp                                ; 
        sub     esp, 88                                 ; deklaracja wielkosci stosu
        mov     edi, DWORD[ebp+8]                       ; zapisanie wskaznika na obraz

        mov     eax, dword [ebp+12]                     ; obliczanie scale 
        mov     dword [ebp-88], eax                     ; zapisanie scale_num
        mov     dword [ebp-84], 0                     	; 
        fild    qword [ebp-88]                          ; wczytanie int scale_num
        fstp    dword [ebp-68]                          ; zapisanie float scale_num i wyrzucenie ze stosu
        fld     dword [ebp-68]                          ; wczytanie float scale_num
        mov     eax, dword [ebp+16]                    	; 
        mov     dword [ebp-88], eax                     ; 
        mov     dword [ebp-84], 0                     	; 
        fild    qword [ebp-88]                          ; wczytanie integer scale_den
        fstp    dword [ebp-68]                          ; zapisanie float scale_den i wyrzucenie ze stosu
        fld     dword [ebp-68]                          ; wczytanie float scale_den
        fdivp   st1, st0                                ; dzielenie float scane_num / float scale_den
        fstp    dword [ebp-40]                          ; zapisanie wyniku dzielenia (scale)
        
        mov     dword [ebp-92], 1
        fild    dword [ebp-92]
        fld     dword [ebp-40]
        fdivp   st1, st0
        fstp    dword [ebp-92]
        
        mov     eax, dword [edi+10]                     ; pobranie offsetu i zapisanie 
        mov     dword [ebp-28], eax                    	; Offset 
        mov     eax, dword [edi+18]                     ; pobranie szerokosci i zapisanie 
        mov     dword [ebp-24], eax                     ; actWidth

        fild    dword [ebp-24]                          ; obliczanie newWidth (int)
        fmul    dword [ebp-40]                          ; 
        movzx   eax, word [ebp-70]                     	; kopiuje wartosc z ebp-70 
        mov     ah, 12                                  ; 
        mov     word [ebp-72], ax                      	; 
        fistp   dword [ebp-20]                          ; 
        mov     eax, DWORD[ebp-20]                      ; zapisanie newWidth do eax                   
        mov     DWORD[edi+18], eax                      ; zapisanie newWidth do tablicy

        mov     eax, dword [edi+22]                     ; pobranie aktualnej wysokosci i zapisanie 
        mov     dword [ebp-32], eax                     ; actHeight
        fild    dword [ebp-32]                          ; obliczanie newHeight
        fmul    dword [ebp-40]                          ; 
        fistp   dword [ebp-36]                          ; 
        mov     eax, DWORD[ebp-36]                      ; zapisanie newHeight
        mov     DWORD[edi+22], eax                      ; zapisanie newHeight

        mov     edx, dword [ebp-24]                     ; actPadding = 4 - ((actWidth * 3) % 4);
        mov     eax, edx                                ; 
        shl     eax, 1                                ; 
        add     edx, eax                                ;  
        and     edx, 3                                	; % 4 
        mov     eax, 4                                  ; 
        sub     eax, edx                                ; 
        mov     dword [ebp-64], eax                     ; 

        mov     edx, dword [ebp-20]                     ; newPadding = 4 - ((newWidth * 3) % 4);
        mov     eax, edx                                ; 
        shl     eax, 1                                ; 
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
        mov     dword [ebp-48], 0                       ; cy=0
        mov     eax, dword [edi+10]                     ; przesuniecie wskaznika o ofsset
        add     edi, eax                                ; przesuniecie wskaznika o ofsset                     
CyLoop:  
        mov     dword [ebp-44], 0                      	; cx=0

                                                        ; cyNewWidthNewPadding = cy * (newWidth *3 + newPadding);
        mov     edx, dword [ebp-20]                     ; obliczanie cyNewWidthNewPadding
        mov     eax, edx                                ; actWidth *3
        add     eax, eax                                ; 
        add     edx, eax                                ; 
        mov     eax, dword [ebp-60]                     ; pobranie newPadding
        add     eax, edx                                ; actWidth *3 + newPadding
        imul    eax, dword [ebp-48]                     ; mnozenie cy*(actWidth *3 + newPadding)
        mov     dword [ebp-16], eax                     ; zapisanie wyniku

                                                    ; cyScaleActWidth3Scale = (int)(cy / scale) * (actWidth *3 + actPadding)
        fild    dword [ebp-48]                          ; wrzucenie cy na stos
        fdiv    dword [ebp-40]                          ; podzielenie przez skale
        fistp   dword [ebp-72]                          ; zapisanie wyniku
        mov     ecx, dword [ebp-72]                     ; zapisanie do ecx = cyScaleActWidth3Scale
        mov     edx, dword [ebp-24]                     ; pobranie actWidth
        mov     eax, edx                                ; obliczanie actWidth*3
        add     eax, eax                                ;       =||=
        add     edx, eax                                ;       =||=
        mov     eax, dword [ebp-64]                     ; pobranie actPadding
        add     eax, edx                                ; dodanie actPadding+actWidth*3
        imul    eax, ecx                                ; (cy / scale) * (actWidth *3 + actPadding)
        mov     dword [ebp-12], eax                     ; zapisanie wyniku
CxLoop: 
                                                        ; pixel = cyNewWidthNewPadding + (cx*3)
        mov     edx, dword [ebp-44]                     ; pobranie cx
        mov     eax, edx                                ; cx*3
        shl     eax, 1                                  ; mnozenie cx * 2
        add     edx, eax                                ; 2cx + cx
        mov     eax, dword [ebp-16]                     ; pobranie cyNewWidthNewPadding
        add     eax, edx                                ; cyNewWidthNewPadding+cx*3
        mov     dword [ebp-8], eax                      ; zapisanie pixel

                                                        ; nearestMatch =  (cyScaleActWidth3Scale + (cx / scale) *3);
        fild    dword [ebp-44]                          ; pobranie cx
        fdiv    dword [ebp-40]                          ; podzielenie przez skale
        fistp   dword [ebp-72]                          ; wyrzucenie wyniku do zmiennej
        mov     edx, dword [ebp-72]                     ; przeniedienie wyniku do edx
        mov     eax, edx                                ; (cx / scale) *3)
        add     eax, eax                                ; 
        add     edx, eax                                ; 
        mov     eax, dword [ebp-12]                     ; pobranie cyScaleActWidth3Scale
        add     eax, edx                                ; dodanie (cx / scale) *3) + cyScaleActWidth3Scale
        mov     dword [ebp-4], eax                      ; zapisanie wyniku

                                                    ; buffer[offset + pixel   ] =  buffer[offset + nearestMatch ];
        mov     eax, dword [ebp-8]                      ; pobranie pixel
        mov     edx, eax                                ; przeniedienie do edx
        mov     eax, edi
        add     edx, eax                                ; eax + offset + pixel => wskaznik w edx
        mov     eax, dword [ebp-4]                      ; pobranie nearestMatch
        mov     ecx, eax                                ; zapisanie do ecx
        mov     eax, edi
        add     eax, ecx                                ; przesuniecie o offset+NearestMatch
        
        movzx   ecx, byte [eax]                         ; pobranie bajtu z eax w ecx
        mov     byte [edx], cl                          ; zapisanie bajtu w edx
        inc     eax                                     ; inkrementacja i zamiana pozostalych 2 bajtow
        inc     edx                                     ; inkrementacja i zamiana pozostalych 2 bajtow
        movzx   ecx, word [eax]
        mov word[edx], cx

        add     dword [ebp-44], 1                       ; inkrementacja cx
        mov     eax, dword [ebp-44]                     ; 
        cmp     eax, dword [ebp-20]                     ; 
        jl      CxLoop  

        add     dword [ebp-48], 1                       ; 
        mov     eax, dword [ebp-48]                     ; 
        cmp     eax, dword [ebp-36]                     ; 
        jl      CyLoop                                  ; 
exit:
        leave                                           ; 
        ret                                             ; 

