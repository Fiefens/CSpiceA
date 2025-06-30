#include "SpiceUsr.h"

void load_cspice_kernels() {
    furnsh_c("naif0012.tls");
    furnsh_c("de440s.bsp");
}

void get_body_position(const char* target, const char* observer, const char* timeStr, double* outPositionKm) {
    SpiceDouble et, state[6], lt;
    str2et_c(timeStr, &et);
    spkezr_c(target, et, "J2000", "NONE", observer, state, &lt);
    outPositionKm[0] = state[0];
    outPositionKm[1] = state[1];
    outPositionKm[2] = state[2];
}
