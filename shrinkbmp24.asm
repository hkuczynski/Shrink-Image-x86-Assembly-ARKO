section .data

section .text

global shrinkbmp24

shrinkbmp24:
   	push ebp
   	mov ebp, esp
    
	mov eax, [ebp + 8]	;image pointer
	mov ebx, [ebp + 12]	;scale_num
	mov ecx, [ebp + 16]     ;scale_den
	
	
end:
	mov esp, ebp
	pop ebp
	ret