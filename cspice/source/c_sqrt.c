#include <math.h>

// Define a portable complex type
typedef struct {
    float r;  // real part
    float i;  // imaginary part
} complex;

// Replaces f__cabs from f2c
static double complex_abs(double x, double y) {
    return sqrt(x * x + y * y);
}

void c_sqrt(complex* r, const complex* z)
{
    double zr = z->r;
    double zi = z->i;
    double mag = complex_abs(zr, zi);

    if (mag == 0.0) {
        r->r = 0.0f;
        r->i = 0.0f;
    }
    else if (zr > 0.0) {
        double t = sqrt(0.5 * (mag + zr));
        r->r = (float)t;
        r->i = (float)(zi / (2.0 * t));
    }
    else {
        double t = sqrt(0.5 * (mag - zr));
        if (zi < 0.0)
            t = -t;
        r->i = (float)t;
        r->r = (float)(zi / (2.0 * t));
    }
}
