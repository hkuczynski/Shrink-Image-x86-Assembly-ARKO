#include <stdio.h>
#include <stdlib.h>

void shrinkbmp24(FILE *img, unsigned int scale_num, unsigned int scale_den)
{
	long i, j;
	char *buffer, *newImage;
	long filelen;
        float scale = (float)scale_num / (float)scale_den;
        int newWidth = 0, newHeight = 0, tmpInt, actWidth = 0, actHeight = 0, x, y, k;
        
        
        
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
        
        newImage = (char*)malloc(sizeof(char) * filelen);
        
        
	i = 0;
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
    
    
            printf("NEW WIDTH = %d\n", newWidth);
            printf("NEW HEIGHT = %d\n", newHeight);
            
            
	
        while (i < 54)
	{
                newImage[i] = buffer[i];
		//fprintf(out, "%c", newImage[i]);
		i++;
	}
    
        k = 0;
        while (i < filelen)
        {
            x = (i-54) * scale;
            y = (i-54) / actWidth * scale;
            k = 0;
            while (k < 16)
            {
                    printf("x = %d, y = %d, k = %d, index = %d\n", x, y, k, x*y+k);
                    newImage[x + y*newWidth + k + 54] = buffer[i + k];
                    //fprintf(out, "%c", buffer[x+y*actWidth + k]);
                    i++;
                    k++;
            }
        }
    
    
	fwrite(newImage, filelen, 1, out); 
	

	//Size of the BMP file
	//fprintf(out, "%c",);

	fclose(out);

}