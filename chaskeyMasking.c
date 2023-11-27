//2023/8/30 Zhi

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>


#define ROTL32(x,b) (unsigned)( ((x) >> (32 - (b))) | ( (x) << (b)) )
#define K 32

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

unsigned BM2AM(unsigned B, unsigned rz, unsigned rB2A){
	unsigned T = B ^ rB2A;
	T = T - rB2A;
	T = T ^ B;
	rB2A = rB2A ^ rz;
	unsigned A = B ^ rB2A;
	A = A - rB2A;
	A = A ^ T;
	
	return A;
}


unsigned AM2BM(unsigned A, unsigned rz, unsigned rA2B) {
	unsigned T = rA2B << 1;
	unsigned B = rA2B ^ rz;
	unsigned O = rA2B & B;
	B = T ^ A;
	rA2B = rA2B ^ B;
	rA2B = rA2B & rz;
	O = O ^ rA2B;
	rA2B = T & A;
	O = O ^ rA2B;

	for (int k=1; k<K; k++){

		rA2B = T & rz;
		rA2B = rA2B ^ O;
		T = T & A;
		rA2B = rA2B ^ T; 
		T = rA2B << 1;
	}

	B = B ^ T;
	return B;
}

unsigned AM(unsigned A, unsigned r) {
	
	A = A - r;
	return A;
}

unsigned BM(unsigned B, unsigned r) {
	
	B = B ^ r;
	return B;
}

void chaskey(uint32_t *k, uint32_t *m, uint32_t *v) {

	uint32_t k1[4];
	int mlen = 16;
	//random number generation
	uint32_t r0 = 0x00000001;
	uint32_t r1 = 0x00000002;
	uint32_t r2 = 0x00000003;
	uint32_t r3 = 0x00000004;
	uint32_t r_B2A = 0x12345678;
	uint32_t r_A2B = 0x87654321;

	const volatile unsigned C[2] = { 0x00, 0x87 };
	k1[0] = (k[0] << 1) ^ C[k[3] >> 31]; \
	k1[1] = (k[1] << 1) | (k[0] >> 31); \
	k1[2] = (k[2] << 1) | (k[1] >> 31); \
	k1[3] = (k[3] << 1) | (k[2] >> 31); \

	v[0] = k[0];
	v[1] = k[1];
	v[2] = k[2];
	v[3] = k[3];
	
	v[0] = BM(v[0],r0);
	v[1] = BM(v[1],r1);
	v[2] = BM(v[2],r2);
	v[3] = BM(v[3],r3);
	
	for (int i = 0; i < mlen-4; i += 4) {

		v[0] ^= m[i];
		v[1] ^= m[i + 1];
		v[2] ^= m[i + 2];
		v[3] ^= m[i + 3];

		for (int j = 0; j < 12; j++) {
		
			//B2A for v[0] and v[1]			
			v[0] = BM2AM(v[0],r0,r_B2A);
			v[1] = BM2AM(v[1],r1,r_B2A);				
			v[0] += v[1];
			r0 = r0+r1;
						
			//A2B for v[1] and v[0]
			v[1] = AM2BM(v[1],r1,r_A2B);
			v[0] = AM2BM(v[0],r0,r_A2B);
			v[1] = ROTL32(v[1], 5);
			r1 = ROTL32(r1, 5);
			v[1] ^= v[0];
			r1 = r1^r0;
			
			v[0] = ROTL32(v[0], 16);
			r0 = ROTL32(r0, 16);
			
			//B2A for v[2] and v[3]			
			v[2] = BM2AM(v[2],r2,r_B2A);
			v[3] = BM2AM(v[3],r3,r_B2A);				
			v[2] += v[3];
			r2 = r2+r3;
						
			//A2B for v[2] and v[3]
			v[2] = AM2BM(v[2],r2,r_A2B);
			v[3] = AM2BM(v[3],r3,r_A2B);
			v[3] = ROTL32(v[3], 8);
			r3 = ROTL32(r3, 8);
			v[3] ^= v[2];
			r3 = r3^r2;

			//B2A for v[0] and v[3]
			v[0] = BM2AM(v[0],r0,r_B2A);
			v[3] = BM2AM(v[3],r3,r_B2A);	
			v[0] += v[3];
			r0 = r0+r3;
			
			//A2B for v[0] and v[3]
			v[0] = AM2BM(v[0],r0,r_A2B);
			v[3] = AM2BM(v[3],r3,r_A2B);
			v[3] = ROTL32(v[3], 13);
			r3 = ROTL32(r3, 13);
			v[3] ^= v[0];
			r3 = r3^r0;
			
			//B2A for v[1] and v[2]
			v[1] = BM2AM(v[1],r1,r_B2A);
			v[2] = BM2AM(v[2],r2,r_B2A);				
			v[2] += v[1];
			r2 = r2+r1;
			
			//A2B for v[1] and v[2]
			v[1] = AM2BM(v[1],r1,r_A2B);
			v[2] = AM2BM(v[2],r2,r_A2B);
			v[1] = ROTL32(v[1], 7);
			r1 = ROTL32(r1, 7);
			v[1] ^= v[2];
			r1 = r1^r2;
			
			v[2] = ROTL32(v[2], 16);
			r2 = ROTL32(r2, 16);
			
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
		
			//B2A for v[0] and v[1]			
			v[0] = BM2AM(v[0],r0,r_B2A);
			v[1] = BM2AM(v[1],r1,r_B2A);				
			v[0] += v[1];
			r0 = r0+r1;
						
			//A2B for v[1] and v[0]
			v[1] = AM2BM(v[1],r1,r_A2B);
			v[0] = AM2BM(v[0],r0,r_A2B);
			v[1] = ROTL32(v[1], 5);
			r1 = ROTL32(r1, 5);
			v[1] ^= v[0];
			r1 = r1^r0;
			
			v[0] = ROTL32(v[0], 16);
			r0 = ROTL32(r0, 16);
			
			//B2A for v[2] and v[3]			
			v[2] = BM2AM(v[2],r2,r_B2A);
			v[3] = BM2AM(v[3],r3,r_B2A);				
			v[2] += v[3];
			r2 = r2+r3;
						
			//A2B for v[2] and v[3]
			v[2] = AM2BM(v[2],r2,r_A2B);
			v[3] = AM2BM(v[3],r3,r_A2B);
			v[3] = ROTL32(v[3], 8);
			r3 = ROTL32(r3, 8);
			v[3] ^= v[2];
			r3 = r3^r2;

			//B2A for v[0] and v[3]
			v[0] = BM2AM(v[0],r0,r_B2A);
			v[3] = BM2AM(v[3],r3,r_B2A);	
			v[0] += v[3];
			r0 = r0+r3;
			
			//A2B for v[0] and v[3]
			v[0] = AM2BM(v[0],r0,r_A2B);
			v[3] = AM2BM(v[3],r3,r_A2B);
			v[3] = ROTL32(v[3], 13);
			r3 = ROTL32(r3, 13);
			v[3] ^= v[0];
			r3 = r3^r0;
			
			//B2A for v[1] and v[2]
			v[1] = BM2AM(v[1],r1,r_B2A);
			v[2] = BM2AM(v[2],r2,r_B2A);				
			v[2] += v[1];
			r2 = r2+r1;
			
			//A2B for v[1] and v[2]
			v[1] = AM2BM(v[1],r1,r_A2B);
			v[2] = AM2BM(v[2],r2,r_A2B);
			v[1] = ROTL32(v[1], 7);
			r1 = ROTL32(r1, 7);
			v[1] ^= v[2];
			r1 = r1^r2;
			
			v[2] = ROTL32(v[2], 16);
			r2 = ROTL32(r2, 16);
			
		}

	v[0] ^= k1[0];
	v[1] ^= k1[1];
	v[2] ^= k1[2];
	v[3] ^= k1[3];
	
	v[0] ^= r0;
	v[1] ^= r1;
	v[2] ^= r2;
	v[3] ^= r3;
	
}

int main(void) {

        uint32_t k[] = {0x33221100,0x77665544,0xbbaa9988,0xffeeddcc};      
                   
	uint32_t m[16] = {123456,234567,0x0b0a0908,0x0f0e0d0c,	    0x13121110,0x17161514,0x1b1a1918,0x1f1e1d1c,0x03020100,0x07060504,0x0b0a0908,0x0f0e0d0c,0x13121110,0x17161514,0x1b1a1918,0x1f1e1d1c,
	};
        uint32_t v[4];
	chaskey(k, m, v);

	for (int i = 0; i < 4; i++) {
		printf("%08x ", v[i]);
		printf("%d\n", i);
	}

	return 0;
}


