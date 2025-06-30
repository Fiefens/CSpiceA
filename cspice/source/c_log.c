#include <math.h>

typedef struct { float r, i; } complex;

double f__cabs(double x, double y) {
    return hypot(x, y);
}

void c_log(complex* r, complex* z)
{
    double zi;
    r->i = atan2(zi = z->i, z->r);
    r->r = log(f__cabs(z->r, zi));
}
