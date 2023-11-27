#pragma once
#include <stdint.h>
#include <stdlib.h>
#ifdef __cplusplus
extern "C" {
#endif
void chaskeyMask(uint32_t *k, uint32_t *m, uint32_t *v);
void chaskey(uint32_t *k, uint32_t *m, uint32_t *v);

#ifdef __cplusplus
}
#endif