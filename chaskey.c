// 2023/8/26 Zhi
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>


#define ROTL32(x,b) (unsigned)( ((x) >> (32 - (b))) | ( (x) << (b)) )


#define ROUND \
  do { \
    v[0] += v[1]; v[1]=ROTL32(v[1], 5); v[1] ^= v[0]; v[0]=ROTL32(v[0],16); \
    v[2] += v[3]; v[3]=ROTL32(v[3], 8); v[3] ^= v[2]; \
    v[0] += v[3]; v[3]=ROTL32(v[3],13); v[3] ^= v[0]; \
    v[2] += v[1]; v[1]=ROTL32(v[1], 7); v[1] ^= v[2]; v[2]=ROTL32(v[2],16); \
  } while(0)

#define PERMUTE \
  ROUND; \
  ROUND; \
  ROUND; \
  ROUND; \
  ROUND; \
  ROUND; \
  ROUND; \
  ROUND; \
  ROUND; \
  ROUND; \
  ROUND; \
  ROUND;
  
const volatile uint32_t C[2] = { 0x00, 0x87 };//Carry

#define TIMESTWO(out,in) \
  do { \
    out[0] = (in[0] << 1) ^ C[in[3] >> 31]; \
    out[1] = (in[1] << 1) | (in[0] >> 31); \
    out[2] = (in[2] << 1) | (in[1] >> 31); \
    out[3] = (in[3] << 1) | (in[2] >> 31); \
  } while(0)

//SubKeys(k1=k*2,k2=k1*2)    
void subkeys(uint32_t k1[4], uint32_t k2[4], const uint32_t k[4]) {
  TIMESTWO(k1,k);
  TIMESTWO(k2,k1);
}

void chaskey(uint32_t *k, uint32_t *m, uint32_t *v) {

	uint32_t k1[4];
	int mlen = 16;

	const volatile unsigned C[2] = { 0x00, 0x87 };
	k1[0] = (k[0] << 1) ^ C[k[3] >> 31]; 
	k1[1] = (k[1] << 1) | (k[0] >> 31); 
	k1[2] = (k[2] << 1) | (k[1] >> 31); 
	k1[3] = (k[3] << 1) | (k[2] >> 31); 

	v[0] = k[0];
	v[1] = k[1];
	v[2] = k[2];
	v[3] = k[3];

	for (int i = 0; i < mlen-4; i += 4) {//mlen-4; i+=4) {

		v[0] ^= m[i];
		v[1] ^= m[i + 1];
		v[2] ^= m[i + 2];
		v[3] ^= m[i + 3];

		for (int j = 0; j < 12; j++) {
			v[0] += v[1];
			v[1] = ROTL32(v[1], 5);
			v[1] ^= v[0];
			v[0] = ROTL32(v[0], 16);
			v[2] += v[3];
			v[3] = ROTL32(v[3], 8);
			v[3] ^= v[2];
			v[0] += v[3];
			v[3] = ROTL32(v[3], 13);
			v[3] ^= v[0];
			v[2] += v[1];
			v[1] = ROTL32(v[1], 7);
			v[1] ^= v[2];
			v[2] = ROTL32(v[2], 16);
		}
	}

	v[0] ^= m[mlen - 4];
	v[1] ^= m[mlen - 3];
	v[2] ^= m[mlen - 2];
	v[3] ^= m[mlen - 1];

	v[0] ^= k1[0];
	v[1] ^= k1[1];
	v[2] ^= k1[2];
	v[3] ^= k1[3];

	for (int j = 0; j < 12; j++) {
		v[0] += v[1];
		v[1] = ROTL32(v[1], 5);
		v[1] ^= v[0];
		v[0] = ROTL32(v[0], 16);
		v[2] += v[3];
		v[3] = ROTL32(v[3], 8);
		v[3] ^= v[2];
		v[0] += v[3];
		v[3] = ROTL32(v[3], 13);
		v[3] ^= v[0];
		v[2] += v[1];
		v[1] = ROTL32(v[1], 7);
		v[1] ^= v[2];
		v[2] = ROTL32(v[2], 16);
	}

	v[0] ^= k1[0];
	v[1] ^= k1[1];
	v[2] ^= k1[2];
	v[3] ^= k1[3];

}

int main(void) {

        uint32_t k[] = { 0x33221100,0x77665544,0xbbaa9988,0xffeeddcc };                         
        uint32_t m[16] = {
123456,234567,0x0b0a0908,0x0f0e0d0c,0x13121110,0x17161514,0x1b1a1918,0x1f1e1d1c,0x03020100,0x07060504,0x0b0a0908,0x0f0e0d0c,0x13121110,0x17161514,0x1b1a1918,0x1f1e1d1c,
};
        uint32_t v[4];
	chaskey(k, m, v);

	for (int i = 0; i < 4; i++) {
		printf("%08x ", v[i]);
		printf("%d\n", i);
	}

	return 0;
}


