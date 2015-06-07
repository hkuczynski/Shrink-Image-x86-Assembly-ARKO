#include <stdio.h>
#include <stdlib.h>

void shrinkbmp24(FILE *img, unsigned int scale_num, unsigned int scale_den)
{
	long i;
	char *buffer;
	long filelen;
        float scale = (float)scale_num / (float)scale_den;
        int newWidth = 0, newHeight = 0, tmpInt;
        
        printf("%d\n", scale_num);
        printf("%d\n", scale_den);
        printf("%f\n", scale);
        
	FILE *out;
        out = fopen("out.bmp", "w");

	fseek(img, 0, SEEK_END);          // Jump to the end of the file
	filelen = ftell(img);             // Get the current byte offset in the file
	rewind(img);                      // Jump back to the beginning of the file

	buffer = (char *)malloc((filelen+1)*sizeof(char)); // Enough memory for file + \0
	fread(buffer, filelen, 1, img); 

        //printf("%c", buffer[0]);
        
        
        
        
	i = 0;
	while (i < 18)
	{
            printf("%d\n", buffer[i]); 
            fprintf(out, "%c", buffer[i]);
            i++; 
	}

            newWidth = newWidth + (buffer[i] / 16) * 16;
            newWidth = newWidth + (buffer[i] % 16);
            i++;

            newWidth = newWidth + (buffer[i] / 16) * 16*16*16;
            newWidth = newWidth + (buffer[i] % 16) * 16*16;
            i++;

            newWidth = newWidth + (buffer[i] / 16) * 16*16*16*16*16;
            newWidth = newWidth + (buffer[i] % 16) * 16*16*16*16;
            i++;

            newWidth = newWidth + (buffer[i] / 16) * 16*16*16*16*16*16*16;
            newWidth = newWidth + (buffer[i] % 16) * 16*16*16*16*16*16;
            
            newWidth = newWidth * scale;
            tmpInt = newWidth;
    
            i -= 3;
    
            buffer[i] = (tmpInt - (tmpInt / 16)) * 10;
            buffer[i] += tmpInt % 16;
            fprintf(out, "%c", buffer[i]);
            i++;
    
            buffer[i] = (tmpInt - (tmpInt / 16 / 16 / 16)) * 10;
            buffer[i] = tmpInt - (tmpInt / 16 / 16);
            fprintf(out, "%c", buffer[i]);
            i++;
    
            buffer[i] = (tmpInt - (tmpInt / 16 / 16 / 16 / 16 / 16)) * 10;
            buffer[i] = tmpInt - (tmpInt / 16 / 16 / 16 / 16);
            fprintf(out, "%c", buffer[i]);
            i++;
    
            buffer[i] = (tmpInt - (tmpInt / 16 / 16 / 16 / 16 / 16 / 16 / 16)) * 10;
            buffer[i] = tmpInt - (tmpInt / 16 / 16 / 16 / 16 / 16 / 16);
            fprintf(out, "%c", buffer[i]);
            i++;
    
            //=========================== HEIGHT ===============================
            
            newHeight = newHeight + (buffer[i] / 16) * 16;
            newHeight = newHeight + (buffer[i] % 16);
            i++;

            newHeight = newHeight + (buffer[i] / 16) * 16*16*16;
            newHeight = newHeight + (buffer[i] % 16) * 16*16;
            i++;

            newHeight = newHeight + (buffer[i] / 16) * 16*16*16*16*16;
            newHeight = newHeight + (buffer[i] % 16) * 16*16*16*16;
            i++;

            newHeight = newHeight + (buffer[i] / 16) * 16*16*16*16*16*16*16;
            newHeight = newHeight + (buffer[i] % 16) * 16*16*16*16*16*16;
            
            newHeight = newHeight * scale;
            
                        i -= 3;
                        while (i < 26)
            {
                buffer[i] = 0;
                buffer[i] += newHeight / 16;
                buffer[i] += newHeight % 16;
                fprintf(out, "%d", buffer[i]);
                i++;
            }
            
            
            printf("NEW W = %d\n", newWidth);
            printf("NEW H = %d\n", newHeight);
	
        while (i < filelen)
	{
		fprintf(out, "%c", buffer[i]);
		i++; 
	}
	
	

	//Size of the BMP file
	//fprintf(out, "%c",);

	fclose(out);

}