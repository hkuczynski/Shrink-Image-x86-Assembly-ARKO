#include <stdio.h>
#include <stdlib.h>

void shrinkbmp24(FILE *img, unsigned int scale_num, unsigned int scale_den)
{
	long i, j;
	unsigned char *buffer, *newImage;
	long filelen;
        float scale = (float)scale_num / (float)scale_den;
        int newWidth = 0, newHeight = 0, tmpInt, actWidth = 0, actHeight = 0, y, offset = 0, size = 0, actPadding, newPadding;
        int padding_new = 0, padding_act = 0;
        
	FILE *out;
        out = fopen("out.bmp", "w");

	fseek(img, 0, SEEK_END);          // Jump to the end of the file
	filelen = ftell(img);             // Get the current byte offset in the file
	rewind(img);                      // Jump back to the beginning of the file

	buffer = (unsigned char *)malloc((filelen+1)*sizeof(unsigned char)); // Enough memory for file + \0
	fread(buffer, filelen, 1, img); 
        
        newImage = (unsigned char*)malloc(sizeof(unsigned char) * filelen);
        
        
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

    
    
            //=========================== HEIGHT ===============================
    
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
		//fprintf(out, "%c", newImage[i]);
		i++;
        }
        

        for(int cy = 0; cy < newHeight; cy++)
        {
            for(int cx = 0; cx < newWidth; cx++)
            {
                

                
                
                int pixel = (cy * (newWidth *3 + newPadding)) + (cx*3);
                int nearestMatch =  (((int)(cy / scale) * (actWidth *3 + actPadding)) + ((int)(cx / scale) *3) );
                
                
                newImage[offset + pixel   ] =  buffer[offset + nearestMatch ];
                newImage[offset + pixel + 1] =  buffer[offset + nearestMatch + 1];
                newImage[offset + pixel + 2 ] =  buffer[offset + nearestMatch + 2];
                
            }
            
            
                        padding_new += newPadding;// * (int)(cy * scale);
                        padding_act += actPadding / scale;

        }
        
    
	fwrite(newImage, filelen, 1, out); 

	fclose(out);

}