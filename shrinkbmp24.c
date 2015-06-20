#include <stdio.h>
#include <stdlib.h>

void shrinkbmp24(unsigned char *buffer, unsigned int scale_num, unsigned int scale_den)
{
    float scale = (float)scale_num / (float)scale_den;
    int newHeight = 0, newWidth, actWidth, tmpInt, actHeight = 0, offset = 0, actPadding, newPadding;
    int padding_new = 0, padding_act = 0, cy, cx, cyNewWidthNewPadding, cyScaleActWidth3Scale;
    
    
    //TRZEBA DODAC POBIERANIE OFFSETU
    //mov eax, DWORD[esi+10]
    
    
    //i = 22 18 - 12, 22 - 25;
    
    offset = 54;
    actWidth = 1366;
    newWidth = actWidth * scale;
    actHeight = 768;
    newHeight = actHeight * scale;
    actPadding = 4 - ((actWidth * 3) % 4);
    newPadding = 4 - ((newWidth * 3) % 4);
    

    if(actPadding == 4)
        actPadding = 0;
    
    if(newPadding == 4)
        newPadding = 0;

    cy = 0;
    do
    {
        cx = 0;
        
        cyNewWidthNewPadding = cy * (newWidth *3 + newPadding);
        cyScaleActWidth3Scale = (int)(cy / scale) * (actWidth *3 + actPadding);
        
        do
        {
            int pixel = (cyNewWidthNewPadding + (cx*3));
            int nearestMatch =  (cyScaleActWidth3Scale + ((int)(cx / scale) *3) );
               
            buffer[offset + pixel   ] =  buffer[offset + nearestMatch ];
            buffer[offset + pixel + 1] =  buffer[offset + nearestMatch + 1];
            buffer[offset + pixel + 2 ] =  buffer[offset + nearestMatch + 2];
            
            cx++;
        } while(cx < newWidth);
        
        padding_new += newPadding;
        padding_act += actPadding / scale;
        cy++;
    } while(cy < newHeight);
    
}