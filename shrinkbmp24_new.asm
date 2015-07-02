; Disassembly of file: shrinkbmp24.o
; Thu Jul  2 18:46:55 2015
; Mode: 32 bits
; Syntax: YASM/NASM
; Instruction set: 80386, 80x87


global shrinkbmp24: function


SECTION .text   align=4 execute                         ; section number 1, code

shrinkbmp24:; Function begin
        push    ebp                                     ; 0000 _ 55
        mov     ebp, esp                                ; 0001 _ 89. E5
        sub     esp, 68                                 ; 0003 _ 83. EC, 44
        mov     eax, dword [ebp+0CH]                    ; 0006 _ 8B. 45, 0C
        mov     edx, 0                                  ; 0009 _ BA, 00000000
        push    edx                                     ; 000E _ 52
        push    eax                                     ; 000F _ 50
        fild    qword [esp]                             ; 0010 _ DF. 2C 24
        lea     esp, [esp+8H]                           ; 0013 _ 8D. 64 24, 08
        mov     eax, dword [ebp+10H]                    ; 0017 _ 8B. 45, 10
        mov     edx, 0                                  ; 001A _ BA, 00000000
        push    edx                                     ; 001F _ 52
        push    eax                                     ; 0020 _ 50
        fild    qword [esp]                             ; 0021 _ DF. 2C 24
        lea     esp, [esp+8H]                           ; 0024 _ 8D. 64 24, 08
        fdivp   st1, st(0)                              ; 0028 _ DE. F9
        fstp    dword [ebp-8H]                          ; 002A _ D9. 5D, F8
        mov     dword [ebp-24H], 54                     ; 002D _ C7. 45, DC, 00000036
        mov     dword [ebp-2CH], 1280                   ; 0034 _ C7. 45, D4, 00000500
        fild    dword [ebp-2CH]                         ; 003B _ DB. 45, D4
        fmul    dword [ebp-8H]                          ; 003E _ D8. 4D, F8
        fnstcw  word [ebp-42H]                          ; 0041 _ D9. 7D, BE
        movzx   eax, word [ebp-42H]                     ; 0044 _ 0F B7. 45, BE
        mov     ah, 12                                  ; 0048 _ B4, 0C
        mov     word [ebp-44H], ax                      ; 004A _ 66: 89. 45, BC
        fldcw   word [ebp-44H]                          ; 004E _ D9. 6D, BC
        fistp   dword [ebp-30H]                         ; 0051 _ DB. 5D, D0
        fldcw   word [ebp-42H]                          ; 0054 _ D9. 6D, BE
        mov     dword [ebp-28H], 720                    ; 0057 _ C7. 45, D8, 000002D0
        fild    dword [ebp-28H]                         ; 005E _ DB. 45, D8
        fmul    dword [ebp-8H]                          ; 0061 _ D8. 4D, F8
        fldcw   word [ebp-44H]                          ; 0064 _ D9. 6D, BC
        fistp   dword [ebp-34H]                         ; 0067 _ DB. 5D, CC
        fldcw   word [ebp-42H]                          ; 006A _ D9. 6D, BE
        mov     edx, dword [ebp-2CH]                    ; 006D _ 8B. 55, D4
        mov     eax, edx                                ; 0070 _ 89. D0
        add     eax, eax                                ; 0072 _ 01. C0
        lea     edx, [eax+edx]                          ; 0074 _ 8D. 14 10
        mov     eax, edx                                ; 0077 _ 89. D0
        sar     eax, 31                                 ; 0079 _ C1. F8, 1F
        mov     ecx, eax                                ; 007C _ 89. C1
        shr     ecx, 30                                 ; 007E _ C1. E9, 1E
        lea     eax, [edx+ecx]                          ; 0081 _ 8D. 04 0A
        and     eax, 03H                                ; 0084 _ 83. E0, 03
        sub     eax, ecx                                ; 0087 _ 29. C8
        mov     edx, eax                                ; 0089 _ 89. C2
        mov     eax, 4                                  ; 008B _ B8, 00000004
        sub     eax, edx                                ; 0090 _ 29. D0
        mov     dword [ebp-20H], eax                    ; 0092 _ 89. 45, E0
        mov     edx, dword [ebp-30H]                    ; 0095 _ 8B. 55, D0
        mov     eax, edx                                ; 0098 _ 89. D0
        add     eax, eax                                ; 009A _ 01. C0
        lea     edx, [eax+edx]                          ; 009C _ 8D. 14 10
        mov     eax, edx                                ; 009F _ 89. D0
        sar     eax, 31                                 ; 00A1 _ C1. F8, 1F
        mov     ecx, eax                                ; 00A4 _ 89. C1
        shr     ecx, 30                                 ; 00A6 _ C1. E9, 1E
        lea     eax, [edx+ecx]                          ; 00A9 _ 8D. 04 0A
        and     eax, 03H                                ; 00AC _ 83. E0, 03
        sub     eax, ecx                                ; 00AF _ 29. C8
        mov     edx, eax                                ; 00B1 _ 89. C2
        mov     eax, 4                                  ; 00B3 _ B8, 00000004
        sub     eax, edx                                ; 00B8 _ 29. D0
        mov     dword [ebp-1CH], eax                    ; 00BA _ 89. 45, E4
        cmp     dword [ebp-20H], 4                      ; 00BD _ 83. 7D, E0, 04
        jnz     ?_001                                   ; 00C1 _ 75, 07
        mov     dword [ebp-20H], 0                      ; 00C3 _ C7. 45, E0, 00000000
?_001:  cmp     dword [ebp-1CH], 4                      ; 00CA _ 83. 7D, E4, 04
        jnz     ?_002                                   ; 00CE _ 75, 07
        mov     dword [ebp-1CH], 0                      ; 00D0 _ C7. 45, E4, 00000000
?_002:  fld1                                            ; 00D7 _ D9. E8
        fdiv    dword [ebp-8H]                          ; 00D9 _ D8. 75, F8
        fstp    dword [ebp-4H]                          ; 00DC _ D9. 5D, FC
        mov     dword [ebp-14H], 0                      ; 00DF _ C7. 45, EC, 00000000
?_003:  mov     edx, dword [ebp-30H]                    ; 00E6 _ 8B. 55, D0
        mov     eax, edx                                ; 00E9 _ 89. D0
        add     eax, eax                                ; 00EB _ 01. C0
        add     eax, edx                                ; 00ED _ 01. D0
        add     eax, dword [ebp-1CH]                    ; 00EF _ 03. 45, E4
        imul    eax, dword [ebp-14H]                    ; 00F2 _ 0F AF. 45, EC
        mov     dword [ebp-0CH], eax                    ; 00F6 _ 89. 45, F4
        fild    dword [ebp-14H]                         ; 00F9 _ DB. 45, EC
        fmul    dword [ebp-4H]                          ; 00FC _ D8. 4D, FC
        mov     edx, dword [ebp-2CH]                    ; 00FF _ 8B. 55, D4
        mov     eax, edx                                ; 0102 _ 89. D0
        add     eax, eax                                ; 0104 _ 01. C0
        add     eax, edx                                ; 0106 _ 01. D0
        add     eax, dword [ebp-20H]                    ; 0108 _ 03. 45, E0
        push    eax                                     ; 010B _ 50
        fild    dword [esp]                             ; 010C _ DB. 04 24
        lea     esp, [esp+4H]                           ; 010F _ 8D. 64 24, 04
        fmulp   st1, st(0)                              ; 0113 _ DE. C9
        fldcw   word [ebp-44H]                          ; 0115 _ D9. 6D, BC
        fistp   dword [ebp-10H]                         ; 0118 _ DB. 5D, F0
        fldcw   word [ebp-42H]                          ; 011B _ D9. 6D, BE
        mov     eax, dword [ebp-30H]                    ; 011E _ 8B. 45, D0
        sub     eax, 1                                  ; 0121 _ 83. E8, 01
        mov     dword [ebp-18H], eax                    ; 0124 _ 89. 45, E8
?_004:  mov     eax, dword [ebp-0CH]                    ; 0127 _ 8B. 45, F4
        add     eax, dword [ebp-24H]                    ; 012A _ 03. 45, DC
        mov     edx, eax                                ; 012D _ 89. C2
        add     edx, dword [ebp+8H]                     ; 012F _ 03. 55, 08
        mov     eax, dword [ebp-10H]                    ; 0132 _ 8B. 45, F0
        add     eax, dword [ebp-24H]                    ; 0135 _ 03. 45, DC
        add     eax, dword [ebp+8H]                     ; 0138 _ 03. 45, 08
        movzx   eax, byte [eax]                         ; 013B _ 0F B6. 00
        mov     byte [edx], al                          ; 013E _ 88. 02
        mov     edx, dword [ebp+8H]                     ; 0140 _ 8B. 55, 08
        add     edx, 1                                  ; 0143 _ 83. C2, 01
        mov     eax, dword [ebp-0CH]                    ; 0146 _ 8B. 45, F4
        add     eax, dword [ebp-24H]                    ; 0149 _ 03. 45, DC
        lea     ecx, [edx+eax]                          ; 014C _ 8D. 0C 02
        mov     edx, dword [ebp+8H]                     ; 014F _ 8B. 55, 08
        add     edx, 1                                  ; 0152 _ 83. C2, 01
        mov     eax, dword [ebp-10H]                    ; 0155 _ 8B. 45, F0
        add     eax, dword [ebp-24H]                    ; 0158 _ 03. 45, DC
        lea     eax, [edx+eax]                          ; 015B _ 8D. 04 02
        movzx   eax, byte [eax]                         ; 015E _ 0F B6. 00
        mov     byte [ecx], al                          ; 0161 _ 88. 01
        mov     edx, dword [ebp+8H]                     ; 0163 _ 8B. 55, 08
        add     edx, 2                                  ; 0166 _ 83. C2, 02
        mov     eax, dword [ebp-0CH]                    ; 0169 _ 8B. 45, F4
        add     eax, dword [ebp-24H]                    ; 016C _ 03. 45, DC
        lea     ecx, [edx+eax]                          ; 016F _ 8D. 0C 02
        mov     edx, dword [ebp+8H]                     ; 0172 _ 8B. 55, 08
        add     edx, 2                                  ; 0175 _ 83. C2, 02
        mov     eax, dword [ebp-10H]                    ; 0178 _ 8B. 45, F0
        add     eax, dword [ebp-24H]                    ; 017B _ 03. 45, DC
        lea     eax, [edx+eax]                          ; 017E _ 8D. 04 02
        movzx   eax, byte [eax]                         ; 0181 _ 0F B6. 00
        mov     byte [ecx], al                          ; 0184 _ 88. 01
        sub     dword [ebp-18H], 1                      ; 0186 _ 83. 6D, E8, 01
        fild    dword [ebp-10H]                         ; 018A _ DB. 45, F0
        fld     dword [ebp-4H]                          ; 018D _ D9. 45, FC
        fld     dword [?_005]                           ; 0190 _ D9. 05, 00000000(d)
        fmulp   st1, st(0)                              ; 0196 _ DE. C9
        faddp   st1, st(0)                              ; 0198 _ DE. C1
        fldcw   word [ebp-44H]                          ; 019A _ D9. 6D, BC
        fistp   dword [ebp-10H]                         ; 019D _ DB. 5D, F0
        fldcw   word [ebp-42H]                          ; 01A0 _ D9. 6D, BE
        add     dword [ebp-0CH], 3                      ; 01A3 _ 83. 45, F4, 03
        cmp     dword [ebp-18H], 0                      ; 01A7 _ 83. 7D, E8, 00
        jns     ?_004                                   ; 01AB _ 0F 89, FFFFFF76
        add     dword [ebp-14H], 1                      ; 01B1 _ 83. 45, EC, 01
        mov     eax, dword [ebp-14H]                    ; 01B5 _ 8B. 45, EC
        cmp     eax, dword [ebp-34H]                    ; 01B8 _ 3B. 45, CC
        jl      ?_003                                   ; 01BB _ 0F 8C, FFFFFF25
        leave                                           ; 01C1 _ C9
        ret                                             ; 01C2 _ C3
; shrinkbmp24 End of function


SECTION .data   align=4 noexecute                       ; section number 2, data


SECTION .bss    align=4 noexecute                       ; section number 3, bss


SECTION .rodata align=4 noexecute                       ; section number 4, const

?_005:                                                  ; dword
        dd 40400000H                                    ; 0000 _ 3.0 


; Error: Relocation number 1 has a non-existing source address. Section: 0 Offset: 00000006H
; Error: Relocation number 2 has a non-existing source address. Section: 0 Offset: 00000006H
; Error: Relocation number 3 has a non-existing source address. Section: 0 Offset: 00000006H
; Error: Relocation number 4 has a non-existing source address. Section: 0 Offset: 0000000CH
; Error: Relocation number 5 has a non-existing source address. Section: 0 Offset: 00000010H
; Error: Relocation number 6 has a non-existing source address. Section: 0 Offset: 00000010H
; Error: Relocation number 7 has a non-existing source address. Section: 0 Offset: 00000014H
; Error: Relocation number 8 has a non-existing source address. Section: 0 Offset: 00000018H
; Error: Relocation number 9 has a non-existing source address. Section: 0 Offset: 0000001CH
; Error: Relocation number 10 has a non-existing source address. Section: 0 Offset: 00000031H
; Error: Relocation number 11 has a non-existing source address. Section: 0 Offset: 00000065H
; Error: Relocation number 12 has a non-existing source address. Section: 0 Offset: 00000102H
; Error: Relocation number 13 has a non-existing source address. Section: 0 Offset: 0000012BH
; Error: Relocation number 14 has a non-existing source address. Section: 0 Offset: 0000012FH
; Error: Relocation number 15 has a non-existing source address. Section: 0 Offset: 00000133H

