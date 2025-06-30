#include <math.h>

// Define a portable complex type
typedef struct {
    float r, i;
} complex;

void c_sin(complex* r, const complex* z)
{
    double zr = z->r;
    double zi = z->i;

    r->r = (float)(sin(zr) * cosh(zi));
    r->i = (float)(cos(zr) * sinh(zi));
}
