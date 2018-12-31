//#include <assert.h>
#include <stdbool.h>
#include <stdio.h>

void TwosComplement(const int input[8], int output[8])
{
    //Input checking
    int i;
    // for (i = 0; i < 8; ++i)
    //     if (!(input[i] == 0 || input[i] == 1))
    //         printf("%s%d%s%d\n", "Input error. i = ", i, "\nbit value: ", input[i]);

    //Copying bits until 1 is encountered
    i = 0;
    while (input[i] != 1 && i < 8)
    {
        output[i] = input[i];
        ++i;
    }

    //Copying 1 bit if necessary, ie input != 0.0
    if (i < 8) {
        output[i] = input[i];
        ++i;
    }

    //Copying negation of rest of bits
    while (i < 8) {
        output[i] = (!input[i]);
        ++i;
    }

    //Checking output for errors
    // for (i = 0; i < 8; ++i)
    //     if (!(output[i] == 0 || output[i] == 1))
    //         printf("%s%d%s%d\n", "Output error. i = ", i, "\nbit value: ", input[i]);
}

void Dec2Bin(const float x, int bin[8])
{
    bool pos = (x >= 0.0);
    float c = (pos) ? x : -x;//c = abs(x)

    c *= 128.0;
    int pv = 128, i;
    for (i = 7; i > -1; --i)
    {
        if (c >= pv)
        {
            bin[i] = 1;
            c -= pv;
        }
        else
            bin[i] = 0;
        pv /= 2;
    }

    if (c >= 0.5)
    {
        ++bin[0];
        for (i = 0; i < 7; ++i)
            if (bin[i] > 1)
            {
                bin[i] -= 2;
                ++bin[i + 1];
            }
        if (bin[8] == 1)
            bin[8] = 0;
    }

    if (!pos) //If input was negative, take 2sC of output
    {
        int tmp[8];
        TwosComplement(bin, tmp);
        for (i = 0; i < 8; ++i)
            bin[i] = tmp[i];
    }
}


float Bin2Dec(const int bin[8])
{
    int i;
    bool pos = (!bin[7]);

    int b[8];
    if (!pos)
        TwosComplement(bin, b);
    else
    {
        for (i = 0; i < 8; ++i)
            b[i] = bin[i];
    }

    float ret = 0.0;

    for (i = 7; i > -1; --i)
    {
        ret *= 2.0;
        ret += b[i];
    }
    // i = 0;
    // while (i < 7)
    // {
    //     ret += b[i] * coeff;
    //     coeff *= 2;
    //     ++i;
    // }

    if (!pos) ret = -ret;

    ret /= 128.0;
    return ret;
}
