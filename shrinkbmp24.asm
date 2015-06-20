global shrinkbmp24

SECTION .text                           

shrinkbmp24:
        push    ebp                                     ; 
        mov     ebp, esp                                ; 
        sub     esp, 88                                 ; 
        mov     esi, DWORD[ebp+8]                       ; zapisanie wskaznika na obraz
        mov     eax, dword [ebp+0CH]                    ; obliczanie scale
        mov     edx, 0                                  ; 
        mov     dword [ebp-58H], eax                    ; 
        mov     dword [ebp-54H], edx                    ; 
        fild    qword [ebp-58H]                         ; wczytanie int scale_num
        fstp    dword [ebp-44H]                         ; zapisanie float scale_num i wyrzucenie ze stosu
        fld     dword [ebp-44H]                         ; wczytanie float scale_num
        mov     eax, dword [ebp+10H]                    ; 
        mov     edx, 0                                  ; 
        mov     dword [ebp-58H], eax                    ; 
        mov     dword [ebp-54H], edx                    ; 
        fild    qword [ebp-58H]                         ; wczytanie integer scale_den
        fstp    dword [ebp-44H]                         ; zapisanie float scale_den i wyrzucenie ze stosu
        fld     dword [ebp-44H]                         ; wczytanie float scale_den
        fdivp   st1, st0                                ; dzielenie float scane_num / float scale_den
        fstp    dword [ebp-28H]                         ; zapisanie wyniku dzielenia
        mov     eax, dword [esi+10]                     ; pobranie offsetu i zapisanie (dodane)
        mov     dword [ebp-1CH], eax                    ; Offset = 54
        mov     eax, dword [esi+18]                     ; pobranie szerokosci i zapisanie (dodane)
        mov     dword [ebp-18H], eax                    ; actWidth = 1366
        fild    dword [ebp-18H]                         ; obliczanie newWidth
        fmul    dword [ebp-28H]                         ; 
        ;fnstcw  word [ebp-46H]                         ; 
        movzx   eax, word [ebp-46H]                     ; 
        mov     ah, 12                                  ; 
        mov     word [ebp-48H], ax                      ; 
        ;fldcw   word [ebp-48H]                          ; 
        fistp   dword [ebp-14H]                         ; 
        ;fldcw   word [ebp-46H]                          ; 
        mov     eax, DWORD[ebp-14H]                     ; zapisanie newWidth do tablicy                     
        mov     DWORD[esi+18], eax                      ; zapisanie newWidth do tablicy

        mov     eax, dword [esi+22]                     ; pobranie aktualnej wysokosci i zapisanie (dodane)
        mov     dword [ebp-20H], eax                    ; actHeight = 768
        fild    dword [ebp-20H]                         ; obliczanie newHeight
        fmul    dword [ebp-28H]                         ; 
        ;fldcw   word [ebp-48H]                          ; 
        fistp   dword [ebp-24H]                         ; 
        ;fldcw   word [ebp-46H]                          ; 
        mov     eax, DWORD[ebp-24H]                     ;******dodane|zapisanie wysokosci
        mov     DWORD[esi+22], eax                       ;******dodane|zapisanie wysokosci

        mov     edx, dword [ebp-18H]                    ; actPadding = 4 - ((actWidth * 3) % 4);
        mov     eax, edx                                ; 
        add     eax, eax                                ; 
        add     edx, eax                                ; 
        mov     eax, edx                                ; 
        and     edx, 03H                                ; 
        mov     eax, edx                                ; 
        mov     edx, 4                                  ; 
        sub     edx, eax                                ; 
        mov     eax, edx                                ; 
        mov     dword [ebp-40H], eax                    ; 

        mov     edx, dword [ebp-14H]                    ; newPadding = 4 - ((newWidth * 3) % 4);
        mov     eax, edx                                ; 
        add     eax, eax                                ; 
        add     edx, eax                                ; 
        mov     eax, edx                                ; 
        and     edx, 03H                                ; 
        mov     eax, edx                                ; 
        mov     edx, 4                                  ; 
        sub     edx, eax                                ; 
        mov     eax, edx                                ; 
        mov     dword [ebp-3CH], eax                    ; 

        cmp     dword [ebp-40H], 4                      ; if(actPadding == 4)
        jnz     skipActPadding                          ; 
        mov     dword [ebp-40H], 0                      ; 
skipActPadding  :  
        cmp     dword [ebp-3CH], 4                      ; 
        jnz     skipNewPadding                          ; 
        mov     dword [ebp-3CH], 0                      ; 
skipNewPadding  : 

        mov     dword [ebp-30H], 0                      ; cy=0
        mov     eax, dword [esi+10]                     ;****dodane| przesuniecie wskaznika o ofsset
        add     esi, eax                                ;****dodane| przesuniecie wskaznika o ofsset                     
CyLoop:  
        mov     dword [ebp-2CH], 0                      ; cx=0

        ;cyNewWidthNewPadding = cy * (newWidth *3 + newPadding);
        mov     edx, dword [ebp-14H]                    ; obliczanie cyNewWidthNewPadding
        mov     eax, edx                                ; actWidth *3
        add     eax, eax                                ; 
        add     edx, eax                                ; 
        mov     eax, dword [ebp-3CH]                    ; pobranie newPadding
        add     eax, edx                                ; actWidth *3 + newPadding
        imul    eax, dword [ebp-30H]                    ; mnozenie cy*(actWidth *3 + newPadding)
        mov     dword [ebp-10H], eax                    ; zapisanie wyniku

        ;cyScaleActWidth3Scale = (int)(cy / scale) * (actWidth *3 + actPadding)
        fild    dword [ebp-30H]                         ; wrzucenie cy na stos
        fdiv    dword [ebp-28H]                         ; podzielenie przez skale
        ;fldcw   word [ebp-48H]                          ; ?
        fistp   dword [ebp-4CH]                         ; zapisanie wyniku
        ;fldcw   word [ebp-46H]                          ; ?
        mov     ecx, dword [ebp-4CH]                    ; zapisanie do ecx = cyScaleActWidth3Scale
        mov     edx, dword [ebp-18H]                    ; pobranie actWidth
        mov     eax, edx                                ; obliczanie actWidth*3
        add     eax, eax                                ;       =||=
        add     edx, eax                                ;       =||=
        mov     eax, dword [ebp-40H]                    ; pobranie actPadding
        add     eax, edx                                ; dodanie actPadding+actWidth*3
        imul    eax, ecx                                ; (cy / scale) * (actWidth *3 + actPadding)
        mov     dword [ebp-0CH], eax                    ; zapisanie wyniku
CxLoop: 
        ; int pixel = (cyNewWidthNewPadding + (cx*3))
        mov     edx, dword [ebp-2CH]                    ; pobranie cx
        mov     eax, edx                                ; cx*3
        shl     eax, 1                                  ; mnozenie cx * 2
        add     edx, eax                                ; 2cx + cx
        mov     eax, dword [ebp-10H]                    ; pobranie cyNewWidthNewPadding
        add     eax, edx                                ; cyNewWidthNewPadding+cx*3
        mov     dword [ebp-8H], eax                     ; zapisanie pixel

        ; int nearestMatch =  (cyScaleActWidth3Scale + ((int)(cx / scale) *3) );
        fild    dword [ebp-2CH]                         ; pobranie cx
        fdiv    dword [ebp-28H]                         ; podzielenie przez skale
        ;fldcw   word [ebp-48H]                          ; 
        fistp   dword [ebp-4CH]                         ; wyrzucenie wyniku do zmiennej
        ;fldcw   word [ebp-46H]                          ; 
        mov     edx, dword [ebp-4CH]                    ; przeniesienie wyniku do edx
        mov     eax, edx                                ; (cx / scale) *3)
        add     eax, eax                                ; 
        add     edx, eax                                ; 
        mov     eax, dword [ebp-0CH]                    ; pobranie cyScaleActWidth3Scale
        add     eax, edx                                ; dodanie (cx / scale) *3) + cyScaleActWidth3Scale
        mov     dword [ebp-4H], eax                     ; zapisanie wyniku

        ;buffer[offset + pixel   ] =  buffer[offset + nearestMatch ];
        mov     eax, dword [ebp-8H]                     ; pobranie pixel
        mov     edx, eax                                ; przeniesienie do edx
        mov     eax, esi
        add     edx, eax                                ; eax + offset + pixel => wskaznik w edx
        mov     eax, dword [ebp-4H]                     ; pobranie nearestMatch
        mov     ecx, eax                                ; zapisanie do ecx
        mov     eax, esi
        add     eax, ecx                                ; przesuniecie o offset+NearestMatch
        movzx   ecx, byte [eax]                         ; pobranie bajtu z eax w eax
        mov     byte [edx], cl                          ; zapisanie bajtu w edx
        inc     eax                                     ;*****dodane | inkrementacja i zamiana pozostalych 2 bajtow
        inc     edx                                     ;*****dodane | inkrementacja i zamiana pozostalych 2 bajtow
        movzx   ecx, byte [eax]                         ;*****dodane | inkrementacja i zamiana pozostalych 2 bajtow
        mov     byte [edx], cl                          ;*****dodane | inkrementacja i zamiana pozostalych 2 bajtow
        inc     eax                                     ;*****dodane | inkrementacja i zamiana pozostalych 2 bajtow
        inc     edx                                     ;*****dodane | inkrementacja i zamiana pozostalych 2 bajtow
        movzx   ecx, byte [eax]                         ;*****dodane | inkrementacja i zamiana pozostalych 2 bajtow
        mov     byte [edx], cl                          ;*****dodane | inkrementacja i zamiana pozostalych 2 bajtow

        add     dword [ebp-2CH], 1                      ; 
        mov     eax, dword [ebp-2CH]                    ; 
        cmp     eax, dword [ebp-14H]                    ; 
        jl      CxLoop  

        add     dword [ebp-30H], 1                      ; 
        mov     eax, dword [ebp-30H]                    ; 
        cmp     eax, dword [ebp-24H]                    ; 
        jl      CyLoop                                   ; 
exit:
        leave                                           ; 
        ret                                             ; 

