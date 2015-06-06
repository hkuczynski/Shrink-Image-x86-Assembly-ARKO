#include <stdio.h>
#include <stdlib.h>

extern void shrinkbmp24(FILE *, unsigned int, unsigned int);

int main(int argc, char * argv[])   
{
    unsigned int scale_num, scale_den;
    
    if (argc <= 3)
    {
        printf ("Za malo argumentow\n");
    }
    else
    {
        FILE *fp;
        if ((fp = fopen(argv[1], "r+")) == NULL) 
        {
            printf ("Nie mogę otworzyć pliku %s \n", argv[1]);
        }
        else
        {
            scale_num = atoi(argv[2]);
            scale_den = atoi(argv[3]);
            
            shrinkbmp24(fp, scale_num, scale_den);
            
            fclose (fp); /* zamknij plik */
        }
    }
   
	return 0;
}