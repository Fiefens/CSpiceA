#include <math.h>

// Define the 'complex' type if not already available
typedef struct {
    float r;  // real part
    float i;  // imaginary part
} complex;

void c_cos(complex* r, const complex* z)
{
    double zr = z->r;
    double zi = z->i;

    r->r = cos(zr) * cosh(zi);
    r->i = -sin(zr) * sinh(zi);
}
