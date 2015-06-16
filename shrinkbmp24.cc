#include <stdio.h>
#include <stdlib.h>

void shrinkbmp24(unsigned char *buffer, long filelen, unsigned char *newImage, unsigned int scale_num, unsigned int scale_den)
{
	long i, j;
        float scale = (float)scale_num / (float)scale_den;
        int newWidth = 0, newHeight = 0, tmpInt, actWidth = 0, actHeight = 0, y, offset = 0, size = 0, actPadding, newPadding, pixel, nearestMatch, cy, cx;
        int padding_new = 0, padding_act = 0;
    
        
	i = 0;
    newImage[i] = buffer[i];
    i++;
   newImage[i] = buffer[i];
   i++;

            size = size + (buffer[i] / 16) * 16;
            size = size + (buffer[i] % 16);
            newImage[i] = buffer[i];

            i++;
            
            size = size + (buffer[i] / 16) * 16*16*16;
            size = size + (buffer[i] % 16) * 16*16;
            newImage[i] = buffer[i]; 
            i++;

            size = size + (buffer[i] / 16) * 16*16*16*16*16;
            size = size + (buffer[i] % 16) * 16*16*16*16;
            newImage[i] = buffer[i];
            i++;

            size = size + (buffer[i] / 16) * 16*16*16*16*16*16*16;
            size = size + (buffer[i] % 16) * 16*16*16*16*16*16;
     

	while (i < 10)
	{
            newImage[i] = buffer[i];
            i++; 
	}
    
            offset = offset + (buffer[i] / 16) * 16;
            offset = offset + (buffer[i] % 16);
    newImage[i] = buffer[i];
            i++;
    
            offset = offset + (buffer[i] / 16) * 16*16*16;
            offset = offset + (buffer[i] % 16) * 16*16;
    newImage[i] = buffer[i];
            i++;
    
            offset = offset + (buffer[i] / 16) * 16*16*16*16*16;
            offset = offset + (buffer[i] % 16) * 16*16*16*16;
    newImage[i] = buffer[i];
            i++;
    
            offset = offset + (buffer[i] / 16) * 16*16*16*16*16*16*16;
            offset = offset + (buffer[i] % 16) * 16*16*16*16*16*16;


            while (i < 18)
                {
                    newImage[i] = buffer[i];
                    i++;
                }

            actWidth = actWidth + (buffer[i] / 16) * 16;
            actWidth = actWidth + (buffer[i] % 16);
            i++;

            actWidth = actWidth + (buffer[i] / 16) * 16*16*16;
            actWidth = actWidth + (buffer[i] % 16) * 16*16;
            i++;

            actWidth = actWidth + (buffer[i] / 16) * 16*16*16*16*16;
            actWidth = actWidth + (buffer[i] % 16) * 16*16*16*16;
            i++;

            actWidth = actWidth + (buffer[i] / 16) * 16*16*16*16*16*16*16;
            actWidth = actWidth + (buffer[i] % 16) * 16*16*16*16*16*16;
            
            newWidth = actWidth * scale;
            tmpInt = newWidth;
    
            i -= 3;
    
            newImage[i] = (tmpInt % 16) ;
            tmpInt /= 16;
            newImage[i] += (tmpInt % 16)* 16;
            tmpInt /= 16;
            i++;
    
            newImage[i] = (tmpInt % 16) ;
            tmpInt /= 16;
            newImage[i] += (tmpInt % 16)* 16;
            tmpInt /= 16;
            i++;
    
            newImage[i] = (tmpInt % 16) ;
            tmpInt /= 16;
            newImage[i] += (tmpInt % 16)* 16;
            tmpInt /= 16;
            i++;
    
            newImage[i] = (tmpInt % 16) ;
            tmpInt /= 16;
            newImage[i] += (tmpInt % 16)* 16;
            tmpInt /= 16;
            i++;

    
            actHeight = actHeight + (buffer[i] / 16) * 16;
            actHeight = actHeight + (buffer[i] % 16);
            i++;

            actHeight = actHeight + (buffer[i] / 16) * 16*16*16;
            actHeight = actHeight + (buffer[i] % 16) * 16*16;
            i++;

            actHeight = actHeight + (buffer[i] / 16) * 16*16*16*16*16;
            actHeight = actHeight + (buffer[i] % 16) * 16*16*16*16;
            i++;

            actHeight = actHeight + (buffer[i] / 16) * 16*16*16*16*16*16*16;
            actHeight = actHeight + (buffer[i] % 16) * 16*16*16*16*16*16;
            
            newHeight = actHeight * scale;
            tmpInt = newHeight;
    
            i -= 3;
    
            newImage[i] = (tmpInt % 16) ;
            tmpInt /= 16;
            newImage[i] += (tmpInt % 16)* 16;
            tmpInt /= 16;
            i++;
    
            newImage[i] = (tmpInt % 16) ;
            tmpInt /= 16;
            newImage[i] += (tmpInt % 16)* 16;
            tmpInt /= 16;
            i++;
    
            newImage[i] = (tmpInt % 16) ;
            tmpInt /= 16;
            newImage[i] += (tmpInt % 16)* 16;
            tmpInt /= 16;
            i++;
    
            newImage[i] = (tmpInt % 16) ;
            tmpInt /= 16;
            newImage[i] += (tmpInt % 16)* 16;
            tmpInt /= 16;
            i++;
    
            size -= offset;
            size /= actHeight;
            actPadding = size % (actWidth * 3);      

            newPadding = 4 - ((newWidth * 3) % 4);

        while (i < offset)
	{
                newImage[i] = buffer[i];

		i++;
        }
        
        cy = 0;
        cx = 0;
    
        while(cy < newHeight)
        {            
            cx = 0;
            while(cx < newWidth)
            {
                pixel = (cy * (newWidth *3 + newPadding)) + (cx*3);
                nearestMatch =  (((int)(cy / scale) * (actWidth *3 + actPadding)) + ((int)(cx / scale) *3) );
                
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