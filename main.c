#include <stdio.h>
#include <stdlib.h>

extern void shrinkbmp24(unsigned char *, unsigned int, unsigned int);

int main(int argc, char * argv[])   
{
    unsigned int scale_num, scale_den;
    int i, size = 0;
    long fileLength;
    float scale;

    FILE *outputImage, *inputImage;
    unsigned char *inputImageArray, *outputImageArray;
    
    if (argc <= 3)
    {
        printf ("Za malo argumentow\n");
    }
    else
    {
        
        if ((inputImage = fopen(argv[1], "r+")) == NULL)
        {
            printf ("Nie mogę otworzyć pliku %s \n", argv[1]);
        }
        else
        {
            outputImage = fopen("out.bmp", "w");
            fseek(inputImage, 0, SEEK_END);          
            fileLength = ftell(inputImage);             
            rewind(inputImage);                      
            
            inputImageArray = (unsigned char *)malloc((fileLength+1)*sizeof(unsigned char));
            fread(inputImageArray, fileLength, 1, inputImage);

            scale_num = atoi(argv[2]);
            scale_den = atoi(argv[3]);

            scale = (float)scale_num / (float)scale_den;

            shrinkbmp24(inputImageArray, scale_num, scale_den);
            
            size += (inputImageArray[2] >> 4) << 4;
            size += (inputImageArray[2] % 16);
             
            size += (inputImageArray[3] >> 4) << 12;
            size += (inputImageArray[3] % 16) << 8;
 
            size += (inputImageArray[4] >> 4) << 20;
            size += (inputImageArray[4] % 16) << 16;
 
            size += (inputImageArray[5] >> 4) << 28;
            size += (inputImageArray[5] % 16) << 24;
            
            fwrite(inputImageArray, size, 1, outputImage);
            fclose(outputImage);
            fclose (inputImage);
        }
    }
   
	return 0;
}