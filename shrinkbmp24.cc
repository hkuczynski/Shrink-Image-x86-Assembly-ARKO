void shrinkbmp24(unsigned char *buffer, unsigned char *newImage, unsigned int scale_num, unsigned int scale_den, int size)
{
    float scale;
    int newHeight, newWidth, actWidth, tmpInt, actHeight, offset, actPadding, newPadding;
    int padding_new = 0, padding_act = 0, cy, cx;
    
    scale = (float)scale_num / (float)scale_den;
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
    while(cy < newHeight)
    {
        cx = 0;
        while(cx < newWidth)
        {
            int pixel = (cy * (newWidth *3 + newPadding)) + (cx*3);
            int nearestMatch =  (((int)(cy / scale) * (actWidth *3 + actPadding)) + ((int)(cx / scale) *3) );
               
            newImage[offset + pixel   ] =  buffer[offset + nearestMatch ];
            newImage[offset + pixel + 1] =  buffer[offset + nearestMatch + 1];
            newImage[offset + pixel + 2 ] =  buffer[offset + nearestMatch + 2];
            
            cx++;
        }
        
        padding_new += newPadding;
        padding_act += actPadding / scale;
        cy++;
    }
}