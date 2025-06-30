#include <math.h>

// Define portable complex type
typedef struct {
    float r, i;
} complex;

void c_exp(complex* r, const complex* z)
{
    double zr = z->r;
    double zi = z->i;
    double expx = exp(zr);

    r->r = (float)(expx * cos(zi));
    r->i = (float)(expx * sin(zi));
}
