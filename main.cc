#include <stdio.h>
#include <stdlib.h>

extern void shrinkbmp24(unsigned char*, long, unsigned char*, unsigned int, unsigned int);

int main(int argc, char * argv[])   
{
    unsigned int scale_num, scale_den;
    unsigned char *buffer, *newImage;
    int i, filelen;
    
    if (argc <= 3)
    {
        printf ("Za malo argumentow\n");
    }
    else
    {
        FILE *img;
        if ((img = fopen(argv[1], "r+")) == NULL)
        {
            printf ("Nie mogę otworzyć pliku %s \n", argv[1]);
        }
        else
        {
            FILE *out;
            out = fopen("out.bmp", "w");
            
            fseek(img, 0, SEEK_END);          // Jump to the end of the file
            filelen = ftell(img);             // Get the current byte offset in the file
            rewind(img);                      // Jump back to the beginning of the file
            
            buffer = (unsigned char *)malloc((filelen+1)*sizeof(unsigned char)); // Enough memory for file + \0
            fread(buffer, filelen, 1, img);
            
            newImage = (unsigned char*)malloc(sizeof(unsigned char) * filelen);

            
            scale_num = atoi(argv[2]);
            scale_den = atoi(argv[3]);
            
            
            
            shrinkbmp24(buffer, filelen, newImage, scale_num, scale_den);
            
            fwrite(newImage, filelen, 1, out);
            
            fclose (img); /* zamknij plik */
            fclose (out); /* zamknij plik */
            
        }
    }
   
	return 0;
}