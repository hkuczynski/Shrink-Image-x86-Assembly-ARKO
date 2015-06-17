section	.text 
global  shrinkbmp24

shrinkbmp24:

push   ebp
mov    ebp,esp
sub    esp,0x58
    					;float scale;
    					;int newHeight, newWidth, actWidth, tmpInt, actHeight, offset, actPadding, newPadding;
    					;int padding_new = 0, padding_act = 0, cy, cx;
mov    DWORD [ebp-0x30],0x0
mov    DWORD [ebp-0x2c],0x0
    
    					;scale = (float)scale_num / (float)scale_den;
 mov    eax,DWORD [ebp+0x10]
 mov    edx,0x0
 mov    DWORD [ebp-0x58],eax
 mov    DWORD [ebp-0x54],edx
 fild   QWORD [ebp-0x58]
 fstp   DWORD [ebp-0x44]
 fld    DWORD [ebp-0x44]
 mov    eax,DWORD [ebp+0x14]
 mov    edx,0x0
 mov    DWORD [ebp-0x58],eax
 mov    DWORD [ebp-0x54],edx
 fild   QWORD [ebp-0x58]
 fstp   DWORD [ebp-0x44]
 fld    DWORD [ebp-0x44]
 fdivr st(1),st
 fstp   DWORD [ebp-0x20]
    					;//mov eax, DWORD[esi+10]
    
    
    					;//i = 22 18 - 12, 22 - 25;
    
    ;offset = 54;
 mov    DWORD [ebp-0x1c],0x36
    					;actWidth = 1366;
  mov    DWORD [ebp-0x18],0x556
    					;newWidth = actWidth * scale;
  fild   DWORD [ebp-0x18]
  fmul   DWORD [ebp-0x20]
  fnstcw WORD [ebp-0x46]
  movzx  eax,WORD [ebp-0x46]
  mov    ah,0xc
  mov    WORD [ebp-0x48],ax
  fldcw  WORD [ebp-0x48]
  fistp  DWORD [ebp-0x14]
  fldcw  WORD [ebp-0x46]
    					;actHeight = 768;
mov    DWORD [ebp-0x10],0x300
    					;newHeight = actHeight * scale;
  fild   DWORD [ebp-0x10]
  fmul   DWORD [ebp-0x20]
  fldcw  WORD [ebp-0x48]
  fistp  DWORD [ebp-0xc]
  fldcw  WORD [ebp-0x46]
    					;actPadding = 4 - ((actWidth * 3) % 4);
  mov    edx,DWORD [ebp-0x18]
  mov    eax,edx
  add    eax,eax
  add    edx,eax
  mov    eax,edx
  sar    eax,0x1f
  shr    eax,0x1e
  add    edx,eax
  and    edx,0x3
  sub    edx,eax
  mov    eax,edx
  mov    edx,0x4
  sub    edx,eax
  mov    eax,edx
  mov    DWORD [ebp-0x38],eax
    					;newPadding = 4 - ((newWidth * 3) % 4);
  mov    edx,DWORD [ebp-0x14]
  mov    eax,edx
  add    eax,eax
  add    edx,eax
  mov    eax,edx
  sar    eax,0x1f
  shr    eax,0x1e
  add    edx,eax
  and    edx,0x3
  sub    edx,eax
  mov    eax,edx
  mov    edx,0x4
  sub    edx,eax
  mov    eax,edx
  mov    DWORD [ebp-0x34],eax
    

    					;if(actPadding == 4)
  cmp    DWORD [ebp-0x38],0x4
  jne    gowno
        				;actPadding = 0;
mov    DWORD [ebp-0x38],0x0

gowno:
    
    					;if(newPadding == 4)
  cmp    DWORD [ebp-0x34],0x4
  jne    gowno1
        				;newPadding = 0;
mov    DWORD [ebp-0x34],0x0
gowno1:

    					;cy = 0;
mov    DWORD [ebp-0x28],0x0
    					;while(cy < newHeight)
jmp    exit
    					;{
        					;cx = 0;
        					gowno3:
mov    DWORD [ebp-0x24],0x0
gowno1:
        					;while(cx < newWidth)
jmp    1da <_Z11shrinkbmp24PhS_jji+0x1da>
        					;{
            					;int pixel = (cy * (newWidth *3 + newPadding)) + (cx*3);
 mov    edx,DWORD [ebp-0x14]
 mov    eax,edx
 add    eax,eax
 add    edx,eax
 mov    eax,DWORD [ebp-0x34]
 add    eax,edx
 imul   eax,DWORD [ebp-0x28]
 mov    ecx,eax
 mov    edx,DWORD [ebp-0x24]
 mov    eax,edx
 add    eax,eax
 add    eax,edx
 add    eax,ecx
 mov    DWORD [ebp-0x8],eax
            					;int nearestMatch =  (((int)(cy / scale) * (actWidth *3 + actPadding)) + ((int)(cx / scale) *3) );
 fild   DWORD [ebp-0x28]
 fdiv   DWORD [ebp-0x20]
 fldcw  WORD [ebp-0x48]
 fistp  DWORD [ebp-0x4c]
 fldcw  WORD [ebp-0x46]
 mov    ecx,DWORD [ebp-0x4c]
 mov    edx,DWORD [ebp-0x18]
 mov    eax,edx
 add    eax,eax
 add    edx,eax
 mov    eax,DWORD [ebp-0x38]
 add    eax,edx
 imul   ecx,eax
 mov    edx,ecx
 fild   DWORD [ebp-0x24]
 fdiv   DWORD [ebp-0x20]
 fldcw  WORD [ebp-0x48]
 fistp  DWORD [ebp-0x4c]
 fldcw  WORD [ebp-0x46]
 mov    ecx,DWORD [ebp-0x4c]
 mov    eax,ecx
 add    eax,eax
 add    eax,ecx
 add    eax,edx
 mov    DWORD [ebp-0x4],eax
               
            					;newImage[offset + pixel   ] =  buffer[offset + nearestMatch ];
 mov    edx,DWORD [ebp-0x1c]
 mov    eax,DWORD [ebp-0x8]
 add    eax,edx
 mov    edx,eax
 mov    eax,DWORD [ebp+0xc]
 add    edx,eax
 mov    ecx,DWORD [ebp-0x1c]
 mov    eax,DWORD [ebp-0x4]
 add    eax,ecx
 mov    ecx,eax
 mov    eax,DWORD [ebp+0x8]
 add    eax,ecx
 movzx  eax,BYTE [eax]
 mov    BYTE [edx],al
            					;newImage[offset + pixel + 1] =  buffer[offset + nearestMatch + 1];
 mov    edx,DWORD [ebp-0x1c]
 mov    eax,DWORD [ebp-0x8]
 add    eax,edx
 lea    edx,[eax+0x1]
 mov    eax,DWORD [ebp+0xc]
 add    edx,eax
 mov    ecx,DWORD [ebp-0x1c]
 mov    eax,DWORD [ebp-0x4]
 add    eax,ecx
 lea    ecx,[eax+0x1]
 mov    eax,DWORD [ebp+0x8]
 add    eax,ecx
 movzx  eax,BYTE [eax]
 mov    BYTE [edx],al
            					;newImage[offset + pixel + 2 ] =  buffer[offset + nearestMatch + 2];
 mov    edx,DWORD [ebp-0x1c]
 mov    eax,DWORD [ebp-0x8]
 add    eax,edx
 lea    edx,[eax+0x2]
 mov    eax,DWORD [ebp+0xc]
 add    edx,eax
 mov    ecx,DWORD [ebp-0x1c]
 mov    eax,DWORD [ebp-0x4]
 add    eax,ecx
 lea    ecx,[eax+0x2]
 mov    eax,DWORD [ebp+0x8]
 add    eax,ecx
 movzx  eax,BYTE [eax]
 mov    BYTE [edx],al
            
            					;cx++;
add    DWORD [ebp-0x24],0x1

    					;cy = 0;
    					;while(cy < newHeight)
    					;{
        					;cx = 0;
        					;while(cx < newWidth)
 mov    eax,DWORD [ebp-0x24]
 cmp    eax,DWORD [ebp-0x14]
 jl     105 <_Z11shrinkbmp24PhS_jji+0x105>
            					;newImage[offset + pixel + 2 ] =  buffer[offset + nearestMatch + 2];
            
            					;cx++;
        					;}
        
        					;padding_new += newPadding;
 mov    eax,DWORD [ebp-0x34]
 add    DWORD [ebp-0x30],eax
        					;padding_act += actPadding / scale;
 fild   DWORD [ebp-0x2c]
 fild   DWORD [ebp-0x38]
 fdiv   DWORD [ebp-0x20]
 faddp  st(1),st
 fldcw  WORD [ebp-0x48]
 fistp  DWORD [ebp-0x2c]
 fldcw  WORD [ebp-0x46]
        					;cy++;
add    DWORD [ebp-0x28],0x1
    
    					;if(newPadding == 4)
        					;newPadding = 0;

    					;cy = 0;
    					;while(cy < newHeight)
mov    eax,DWORD [ebp-0x28]
cmp    eax,DWORD [ebp-0xc]
jl     f9 <_Z11shrinkbmp24PhS_jji+0xf9>
        
 leave  
 ret    
