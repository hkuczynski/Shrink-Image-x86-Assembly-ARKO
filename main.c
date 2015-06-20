#include <stdio.h>
#include <stdlib.h>

extern void shrinkbmp24(unsigned char *, unsigned int, unsigned int);

int main(int argc, char * argv[])   
{
    unsigned int scale_num, scale_den;
    int i, size;
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
            fseek(inputImage, 0, SEEK_END);          // Jump to the end of the file
            fileLength = ftell(inputImage);             // Get the current byte offset in the file
            rewind(inputImage);                      // Jump back to the beginning of the file
            
            inputImageArray = (unsigned char *)malloc((fileLength+1)*sizeof(unsigned char)); // Enough memory for file + \0
            fread(inputImageArray, fileLength, 1, inputImage);
            
            //ustalic prawidlowy (nowy) rozmiar


            scale_num = atoi(argv[2]);
            scale_den = atoi(argv[3]);

            scale = (float)scale_num / (float)scale_den;

            shrinkbmp24(inputImageArray, scale_num, scale_den);
            
            fwrite(inputImageArray, fileLength, 1, outputImage);
            fclose(outputImage);
            fclose (inputImage); /* zamknij plik */
        }
    }
   
	return 0;
}