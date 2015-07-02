#include <stdio.h>
#include <stdlib.h>

void shrinkbmp24(unsigned char *buffer, unsigned int scale_num, unsigned int scale_den)
{
    int newHeight, newWidth, actWidth, actHeight, offset, actPadding, newPadding, loopWidth, loopHeight;
    int pixelIn, pixelOut;
    float scale, odwScale;

    scale = (float)scale_num / (float)scale_den;
    offset = 54;
    actWidth = 1280;
    newWidth = actWidth * scale;
    actHeight = 720;
    newHeight = actHeight * scale;
    actPadding = 4 - ((actWidth * 3) % 4);
    newPadding = 4 - ((newWidth * 3) % 4);

    //printf("newWidth = %d\n", newWidth);
    //printf("newHeight = %d\n", newHeight);

    if(actPadding == 4)
        actPadding = 0;

    if(newPadding == 4)
        newPadding = 0;

    odwScale = 1 / scale;

    loopHeight = 0;

    do
    {
        pixelOut = loopHeight * (newWidth *3 + newPadding);
        pixelIn = loopHeight * odwScale * (actWidth * 3 + actPadding);
        loopWidth = newWidth - 1;

        do
        {
            buffer[offset + pixelOut    ] =  buffer[offset + pixelIn    ];
            buffer[offset + pixelOut + 1] =  buffer[offset + pixelIn + 1];
            buffer[offset + pixelOut + 2] =  buffer[offset + pixelIn + 2];

            loopWidth--;
            pixelIn += odwScale * 3;
            pixelOut += 3;
        } while(loopWidth >= 0);

        loopHeight++;
    } while(loopHeight < newHeight);

}
