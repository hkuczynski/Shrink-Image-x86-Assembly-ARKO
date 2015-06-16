#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#include "bmp.h"


int
main(int argc, char *argv[])
{
    // ensure proper usage
    if (argc != 4)
    {
        printf("Usage: resize n infile outfile\n");
        return 1;
    }

    // ensure resize factor is between 1 and 100
    int arglength = strlen(argv[1]);

    for (int i = 0; i < arglength; i++)
    {
        if (!isdigit(argv[1][i]))
        {
            printf("Resize factor must be an integer\n");
            return 5;
        }
    }

    if (atoi(argv[1]) < 1 || atoi(argv[1]) > 100)
    {
        printf("Resize factor must be integer between 1 and 100\n");
        return 6;
    }

    // store valid resize factor
    int factor = atoi(argv[1]);

    // remember filenames
    char *infile = argv[2];
    char *outfile = argv[3];

    // open input file
    FILE *inptr = fopen(infile, "r");
    if (inptr == NULL)
    {
        printf("Could not open %s.\n", infile);
        return 2;
    }

    // open output file
    FILE *outptr = fopen(outfile, "w");
    if (outptr == NULL)
    {
        fclose(inptr);
        fprintf(stderr, "Could not create %s.\n", outfile);
        return 3;
    }

    // read infile's BITMAPFILEHEADER
    BITMAPFILEHEADER bf;
    fread(&bf, sizeof(BITMAPFILEHEADER), 1, inptr);

    // read infile's BITMAPINFOHEADER
    BITMAPINFOHEADER bi;
    fread(&bi, sizeof(BITMAPINFOHEADER), 1, inptr);

    // ensure infile is (likely) a 24-bit uncompressed BMP 4.0
    if (bf.bfType != 0x4d42 || bf.bfOffBits != 54 || bi.biSize != 40 ||
        bi.biBitCount != 24 || bi.biCompression != 0)
    {
        fclose(outptr);
        fclose(inptr);
        fprintf(stderr, "Unsupported file format.\n");
        return 4;
    }

    // save original image height and width, padding, SizeImage
    int oldheight = bi.biHeight;
    int oldwidth = bi.biWidth;
    int oldpadding = (4-(oldwidth*sizeof(RGBTRIPLE)) % 4) % 4;
    int oldSizeImage = bi.biSizeImage;

    // edit outfile's BITMAPINFOHEADER to account for resize
    bi.biWidth = bi.biWidth * factor;
    bi.biHeight = bi.biHeight * factor;

    // determine padding for scanlines
    int padding =  (4 - (bi.biWidth * sizeof(RGBTRIPLE)) % 4) % 4;

    bi.biSizeImage = (oldSizeImage - oldpadding * oldheight) * (factor *
                     factor) + padding * bi.biHeight;

    // write outfile's BITMAPINFOHEADER
    fwrite(&bi, sizeof(BITMAPINFOHEADER), 1, outptr);

    // edit outfile's BITMAPFILEHEADER to account for resize
    bf.bfSize = bf.bfSize - oldSizeImage + bi.biSizeImage;

    // write outfile's BITMAPFILEHEADER
    fwrite(&bf, sizeof(BITMAPFILEHEADER), 1, outptr);

    // create buffer using mallc
    RGBTRIPLE *buffer = (RGBTRIPLE)malloc(sizeof(RGBTRIPLE) * bi.biWidth);

    // iterate over infile's scanlines
    for (int i = 0; i < abs(oldheight); i++)
    {
        int element = 0;

        // iterate over pixels in scanline
        for (int j = 0; j < oldwidth; j++)
        {
            // temporary storage
            RGBTRIPLE triple;

            // read RGB triple from infile and store in buffer
            fread(&triple, sizeof(RGBTRIPLE), 1, inptr);

            //iterate over each pixel factor times
            for (int k = 0; k < factor; k++)
            {
                buffer[element] = triple;
                element++;
            }
        }

        // skip over any input padding
        fseek(inptr, oldpadding, SEEK_CUR);


        // print each row from buffer factor times
        for (int r = 0; r < factor; r++)
        {
            // write RGB triple to outfile
            fwrite(buffer, sizeof(RGBTRIPLE), bi.biWidth, outptr);

            // write padding to outfile
            for (int p = 0; p < padding; p++)
            fputc(0x00, outptr);
        }
    }
    // close infile
    fclose(inptr);

    // close outfile
    fclose(outptr);

    // that's all folks
    return 0;
}