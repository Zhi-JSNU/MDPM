	.cpu cortex-m0
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 4
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"chaskey.c"
	.text
	.section	.text.subkeys,"ax",%progbits
	.align	1
	.global	subkeys
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	subkeys, %function
subkeys:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, [r2, #12]
	push	{r4, r5, r6, lr}
	lsrs	r3, r3, #31
	ldr	r5, .L2
	lsls	r3, r3, #2
	ldr	r4, [r3, r5]
	ldr	r3, [r2]
	@ sp needed
	lsls	r3, r3, #1
	eors	r3, r4
	str	r3, [r0]
	ldr	r4, [r2, #4]
	ldr	r6, [r2]
	lsls	r4, r4, #1
	lsrs	r6, r6, #31
	orrs	r4, r6
	str	r4, [r0, #4]
	ldr	r4, [r2, #8]
	ldr	r6, [r2, #4]
	lsls	r4, r4, #1
	lsrs	r6, r6, #31
	orrs	r4, r6
	str	r4, [r0, #8]
	ldr	r4, [r2, #12]
	ldr	r2, [r2, #8]
	lsls	r4, r4, #1
	lsrs	r2, r2, #31
	orrs	r2, r4
	str	r2, [r0, #12]
	lsrs	r2, r2, #31
	lsls	r2, r2, #2
	ldr	r2, [r2, r5]
	lsls	r3, r3, #1
	eors	r3, r2
	str	r3, [r1]
	ldr	r3, [r0, #4]
	ldr	r2, [r0]
	lsls	r3, r3, #1
	lsrs	r2, r2, #31
	orrs	r3, r2
	str	r3, [r1, #4]
	ldr	r3, [r0, #8]
	ldr	r2, [r0, #4]
	lsls	r3, r3, #1
	lsrs	r2, r2, #31
	orrs	r3, r2
	str	r3, [r1, #8]
	ldr	r3, [r0, #12]
	ldr	r2, [r0, #8]
	lsls	r3, r3, #1
	lsrs	r2, r2, #31
	orrs	r3, r2
	str	r3, [r1, #12]
	pop	{r4, r5, r6, pc}
.L3:
	.align	2
.L2:
	.word	.LANCHOR0
	.size	subkeys, .-subkeys
	.section	.text.chaskey,"ax",%progbits
	.align	1
	.global	chaskey
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	chaskey, %function
chaskey:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, #0
	push	{r4, r5, r6, lr}
	movs	r6, r0
	movs	r4, r2
	sub	sp, sp, #48
	str	r1, [sp]
	str	r3, [sp, #40]
	movs	r2, #8
	adds	r3, r3, #135
	add	r1, sp, #40
	add	r0, sp, #32
	str	r3, [sp, #44]
	bl	memcpy
	ldr	r3, [r6, #12]
	ldr	r0, [r6]
	lsrs	r3, r3, #31
	lsls	r3, r3, #2
	add	r2, sp, #32
	ldr	r1, [r3, r2]
	ldr	r2, [r6, #4]
	lsls	r3, r0, #1
	eors	r3, r1
	str	r3, [sp, #8]
	lsls	r1, r2, #1
	lsrs	r3, r0, #31
	orrs	r1, r3
	ldr	r3, [r6, #8]
	lsrs	r2, r2, #31
	str	r1, [sp, #12]
	lsls	r1, r3, #1
	orrs	r1, r2
	ldr	r2, [r6, #12]
	lsrs	r3, r3, #31
	str	r0, [r4]
	lsls	r2, r2, #1
	orrs	r2, r3
	ldr	r3, [r6, #4]
	ldr	r0, [sp]
	str	r3, [r4, #4]
	ldr	r3, [r6, #8]
	str	r1, [sp, #16]
	str	r3, [r4, #8]
	ldr	r3, [r6, #12]
	str	r2, [sp, #20]
	str	r3, [r4, #12]
	movs	r3, r0
	adds	r3, r3, #48
	str	r3, [sp, #28]
.L6:
	ldr	r3, [r0]
	ldr	r1, [r4]
	eors	r1, r3
	str	r1, [r4]
	ldr	r2, [r0, #4]
	ldr	r3, [r4, #4]
	eors	r3, r2
	str	r3, [r4, #4]
	ldr	r6, [r0, #8]
	ldr	r2, [r4, #8]
	eors	r2, r6
	str	r2, [r4, #8]
	ldr	r5, [r0, #12]
	ldr	r6, [r4, #12]
	eors	r6, r5
	movs	r5, #12
	mov	ip, r6
	str	r5, [sp, #4]
.L5:
	movs	r5, #27
	adds	r1, r1, r3
	rors	r3, r3, r5
	eors	r3, r1
	str	r3, [sp, #24]
	mov	r6, ip
	movs	r3, #24
	rors	r6, r6, r3
	subs	r3, r3, #8
	rors	r1, r1, r3
	add	r2, r2, ip
	eors	r6, r2
	subs	r5, r5, #8
	adds	r1, r1, r6
	rors	r6, r6, r5
	eors	r6, r1
	mov	ip, r6
	movs	r6, #25
	ldr	r3, [sp, #24]
	adds	r2, r3, r2
	rors	r3, r3, r6
	subs	r6, r6, #9
	eors	r3, r2
	rors	r2, r2, r6
	ldr	r6, [sp, #4]
	subs	r6, r6, #1
	str	r6, [sp, #4]
	cmp	r6, #0
	bne	.L5
	mov	r5, ip
	str	r5, [r4, #12]
	ldr	r5, [sp, #28]
	adds	r0, r0, #16
	str	r1, [r4]
	str	r3, [r4, #4]
	str	r2, [r4, #8]
	cmp	r5, r0
	bne	.L6
	ldr	r0, [sp]
	ldr	r0, [r0, #48]
	eors	r1, r0
	ldr	r0, [sp]
	str	r1, [r4]
	ldr	r0, [r0, #52]
	eors	r3, r0
	ldr	r0, [sp]
	str	r3, [r4, #4]
	ldr	r0, [r0, #56]
	eors	r2, r0
	ldr	r0, [sp, #8]
	str	r2, [r4, #8]
	eors	r1, r0
	ldr	r0, [sp, #12]
	eors	r3, r0
	ldr	r0, [sp, #16]
	eors	r2, r0
	ldr	r0, [sp]
	ldr	r6, [r0, #60]
	ldr	r0, [sp, #20]
	eors	r6, r0
	mov	r0, ip
	eors	r6, r0
	movs	r0, #12
.L7:
	movs	r5, #27
	adds	r1, r1, r3
	rors	r3, r3, r5
	subs	r5, r5, #3
	adds	r2, r6, r2
	rors	r6, r6, r5
	subs	r5, r5, #8
	eors	r3, r1
	rors	r1, r1, r5
	eors	r6, r2
	adds	r5, r5, #3
	adds	r1, r1, r6
	rors	r6, r6, r5
	adds	r5, r5, #6
	adds	r2, r3, r2
	rors	r3, r3, r5
	subs	r0, r0, #1
	subs	r5, r5, #9
	eors	r3, r2
	eors	r6, r1
	rors	r2, r2, r5
	cmp	r0, #0
	bne	.L7
	ldr	r0, [sp, #8]
	eors	r0, r1
	ldr	r1, [sp, #12]
	str	r0, [r4]
	eors	r1, r3
	ldr	r3, [sp, #16]
	str	r1, [r4, #4]
	eors	r3, r2
	str	r3, [r4, #8]
	ldr	r3, [sp, #20]
	eors	r3, r6
	str	r3, [r4, #12]
	add	sp, sp, #48
	@ sp needed
	pop	{r4, r5, r6, pc}
	.size	chaskey, .-chaskey
	.section	.text.BM2AM,"ax",%progbits
	.align	1
	.global	BM2AM
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	BM2AM, %function
BM2AM:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	movs	r3, r0
	movs	r4, r0
	eors	r1, r2
	eors	r3, r2
	eors	r4, r1
	subs	r2, r3, r2
	subs	r1, r4, r1
	eors	r2, r1
	eors	r0, r2
	@ sp needed
	pop	{r4, pc}
	.size	BM2AM, .-BM2AM
	.section	.text.AM2BM,"ax",%progbits
	.align	1
	.global	AM2BM
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	AM2BM, %function
AM2BM:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	lsls	r3, r2, #1
	push	{r4, r5, r6, lr}
	movs	r4, r3
	movs	r5, r2
	movs	r6, r0
	eors	r4, r0
	bics	r2, r1
	eors	r5, r4
	ands	r6, r3
	ands	r5, r1
	eors	r2, r6
	eors	r2, r5
	movs	r5, #31
	eors	r1, r0
.L13:
	ands	r3, r1
	eors	r3, r2
	subs	r5, r5, #1
	lsls	r3, r3, #1
	cmp	r5, #0
	bne	.L13
	movs	r0, r4
	@ sp needed
	eors	r0, r3
	pop	{r4, r5, r6, pc}
	.size	AM2BM, .-AM2BM
	.section	.text.AM,"ax",%progbits
	.align	1
	.global	AM
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	AM, %function
AM:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	subs	r0, r0, r1
	@ sp needed
	bx	lr
	.size	AM, .-AM
	.section	.text.BM,"ax",%progbits
	.align	1
	.global	BM
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	BM, %function
BM:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	eors	r0, r1
	@ sp needed
	bx	lr
	.size	BM, .-BM
	.section	.text.chaskeyMask,"ax",%progbits
	.align	1
	.global	chaskeyMask
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	chaskeyMask, %function
chaskeyMask:
	@ args = 0, pretend = 0, frame = 80
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, #0
	push	{r4, r5, r6, lr}
	movs	r4, r0
	sub	sp, sp, #80
	movs	r5, r2
	str	r1, [sp, #20]
	str	r3, [sp, #72]
	movs	r2, #8
	adds	r3, r3, #135
	add	r1, sp, #72
	add	r0, sp, #64
	str	r3, [sp, #76]
	bl	memcpy
	ldr	r1, [r4, #12]
	ldr	r3, [r4]
	lsrs	r2, r1, #31
	lsls	r2, r2, #2
	add	r0, sp, #64
	ldr	r0, [r2, r0]
	lsls	r2, r3, #1
	eors	r2, r0
	ldr	r0, [r4, #4]
	lsrs	r6, r3, #31
	str	r2, [sp, #40]
	lsls	r2, r0, #1
	orrs	r2, r6
	str	r2, [sp, #44]
	ldr	r2, [r4, #8]
	lsrs	r0, r0, #31
	lsls	r6, r2, #1
	orrs	r6, r0
	movs	r0, #1
	lsrs	r2, r2, #31
	lsls	r1, r1, #1
	str	r3, [r5]
	orrs	r1, r2
	str	r1, [sp, #52]
	ldr	r1, [r4, #4]
	eors	r3, r0
	str	r1, [r5, #4]
	ldr	r2, [r4, #8]
	mov	ip, r0
	str	r2, [r5, #8]
	ldr	r4, [r4, #12]
	str	r3, [r5]
	movs	r3, #4
	str	r6, [sp, #48]
	movs	r6, #2
	eors	r4, r3
	str	r3, [sp, #4]
	mov	r3, ip
	str	r4, [r5, #12]
	movs	r4, r6
	adds	r0, r0, r6
	eors	r2, r0
	str	r2, [r5, #8]
	ldr	r2, [sp, #20]
	eors	r1, r6
	str	r2, [sp, #12]
	adds	r2, r2, #48
	str	r1, [r5, #4]
	str	r2, [sp, #60]
	str	r0, [sp, #8]
	str	r3, [sp]
.L19:
	ldr	r3, [sp, #12]
	ldr	r2, [r5]
	ldr	r3, [r3]
	eors	r3, r2
	str	r3, [r5]
	str	r3, [sp, #16]
	ldr	r3, [sp, #12]
	ldr	r2, [r5, #8]
	ldr	r3, [r3, #4]
	movs	r6, r3
	ldr	r3, [r5, #4]
	eors	r6, r3
	ldr	r3, [sp, #12]
	str	r6, [r5, #4]
	ldr	r3, [r3, #8]
	eors	r3, r2
	str	r3, [r5, #8]
	str	r3, [sp, #24]
	ldr	r3, [sp, #12]
	ldr	r2, [r5, #12]
	ldr	r3, [r3, #12]
	eors	r3, r2
	str	r3, [sp, #28]
	movs	r3, #12
	str	r3, [sp, #36]
.L18:
	ldr	r1, [sp]
	ldr	r0, [sp, #16]
	ldr	r2, .L24
	bl	BM2AM
	movs	r1, r4
	str	r0, [sp, #16]
	ldr	r2, .L24
	movs	r0, r6
	bl	BM2AM
	ldr	r3, [sp, #16]
	movs	r1, r4
	adds	r3, r3, r0
	str	r3, [sp, #16]
	ldr	r3, [sp]
	ldr	r2, .L24+4
	adds	r3, r3, r4
	str	r3, [sp]
	bl	AM2BM
	ldr	r1, [sp]
	movs	r6, r0
	ldr	r2, .L24+4
	ldr	r0, [sp, #16]
	bl	AM2BM
	movs	r3, #27
	rors	r4, r4, r3
	rors	r6, r6, r3
	movs	r3, r0
	eors	r3, r6
	str	r3, [sp, #56]
	ldr	r3, [sp]
	ldr	r2, [sp]
	eors	r3, r4
	str	r3, [sp, #32]
	movs	r3, #16
	rors	r2, r2, r3
	ldr	r1, [sp, #8]
	str	r0, [sp, #16]
	str	r2, [sp]
	ldr	r0, [sp, #24]
	ldr	r2, .L24
	bl	BM2AM
	ldr	r1, [sp, #4]
	movs	r4, r0
	ldr	r2, .L24
	ldr	r0, [sp, #28]
	bl	BM2AM
	ldr	r1, [sp, #4]
	ldr	r2, [sp, #8]
	mov	ip, r1
	add	r2, r2, ip
	str	r2, [sp, #8]
	movs	r6, r0
	ldr	r1, [sp, #8]
	adds	r0, r4, r0
	ldr	r2, .L24+4
	bl	AM2BM
	ldr	r1, [sp, #4]
	str	r0, [sp, #24]
	ldr	r2, .L24+4
	movs	r0, r6
	bl	AM2BM
	movs	r2, #24
	rors	r0, r0, r2
	ldr	r6, [sp, #4]
	movs	r4, r0
	movs	r3, #16
	rors	r6, r6, r2
	ldr	r2, [sp, #24]
	ldr	r0, [sp, #16]
	eors	r4, r2
	ldr	r2, [sp, #8]
	rors	r0, r0, r3
	eors	r6, r2
	ldr	r1, [sp]
	ldr	r2, .L24
	bl	BM2AM
	movs	r1, r6
	str	r0, [sp, #4]
	ldr	r2, .L24
	movs	r0, r4
	bl	BM2AM
	ldr	r2, [sp]
	movs	r4, r0
	adds	r2, r2, r6
	str	r2, [sp]
	ldr	r2, [sp, #4]
	ldr	r1, [sp]
	adds	r0, r2, r0
	ldr	r2, .L24+4
	bl	AM2BM
	movs	r1, r6
	str	r0, [sp, #16]
	ldr	r2, .L24+4
	movs	r0, r4
	bl	AM2BM
	movs	r3, #19
	rors	r0, r0, r3
	rors	r6, r6, r3
	ldr	r2, [sp, #16]
	ldr	r1, [sp, #32]
	eors	r2, r0
	str	r2, [sp, #28]
	ldr	r2, [sp]
	ldr	r0, [sp, #56]
	eors	r2, r6
	str	r2, [sp, #4]
	ldr	r2, .L24
	bl	BM2AM
	ldr	r1, [sp, #8]
	movs	r4, r0
	ldr	r2, .L24
	ldr	r0, [sp, #24]
	bl	BM2AM
	ldr	r1, [sp, #32]
	ldr	r2, [sp, #8]
	mov	ip, r1
	add	r2, r2, ip
	adds	r6, r4, r0
	str	r2, [sp, #8]
	movs	r0, r4
	ldr	r2, .L24+4
	bl	AM2BM
	ldr	r1, [sp, #8]
	movs	r4, r0
	ldr	r2, .L24+4
	movs	r0, r6
	bl	AM2BM
	movs	r2, #25
	movs	r3, #16
	rors	r4, r4, r2
	ldr	r1, [sp, #32]
	eors	r4, r0
	rors	r1, r1, r2
	ldr	r2, [sp, #8]
	rors	r0, r0, r3
	rors	r2, r2, r3
	ldr	r3, [sp, #36]
	movs	r6, r4
	ldr	r4, [sp, #8]
	subs	r3, r3, #1
	eors	r4, r1
	str	r0, [sp, #24]
	str	r2, [sp, #8]
	str	r3, [sp, #36]
	cmp	r3, #0
	beq	.LCB642
	b	.L18	@long jump
.LCB642:
	ldr	r3, [sp, #16]
	str	r6, [r5, #4]
	str	r3, [r5]
	ldr	r3, [sp, #28]
	str	r0, [r5, #8]
	str	r3, [r5, #12]
	ldr	r3, [sp, #12]
	adds	r3, r3, #16
	str	r3, [sp, #12]
	ldr	r2, [sp, #12]
	ldr	r3, [sp, #60]
	cmp	r3, r2
	beq	.LCB655
	b	.L19	@long jump
.LCB655:
	ldr	r3, [sp, #20]
	ldr	r3, [r3, #48]
	str	r3, [sp, #12]
	ldr	r2, [sp, #12]
	ldr	r3, [sp, #16]
	eors	r3, r2
	ldr	r2, [sp, #20]
	str	r3, [r5]
	ldr	r2, [r2, #52]
	eors	r6, r2
	ldr	r2, [sp, #20]
	str	r6, [r5, #4]
	ldr	r2, [r2, #56]
	eors	r0, r2
	ldr	r2, [sp, #40]
	str	r0, [r5, #8]
	eors	r2, r3
	ldr	r3, [sp, #44]
	str	r2, [sp, #12]
	eors	r6, r3
	ldr	r3, [sp, #48]
	eors	r3, r0
	str	r3, [sp, #24]
	ldr	r3, [sp, #20]
	ldr	r0, [r3, #60]
	ldr	r3, [sp, #52]
	eors	r0, r3
	ldr	r3, [sp, #28]
	eors	r3, r0
	str	r3, [sp, #20]
	movs	r3, #12
	str	r3, [sp, #28]
.L20:
	ldr	r1, [sp]
	ldr	r0, [sp, #12]
	ldr	r2, .L24
	bl	BM2AM
	movs	r1, r4
	str	r0, [sp, #12]
	ldr	r2, .L24
	movs	r0, r6
	bl	BM2AM
	ldr	r3, [sp, #12]
	movs	r1, r4
	adds	r3, r3, r0
	str	r3, [sp, #12]
	ldr	r3, [sp]
	ldr	r2, .L24+4
	adds	r3, r3, r4
	str	r3, [sp]
	bl	AM2BM
	ldr	r1, [sp]
	movs	r6, r0
	ldr	r2, .L24+4
	ldr	r0, [sp, #12]
	bl	AM2BM
	movs	r3, #27
	rors	r4, r4, r3
	rors	r6, r6, r3
	movs	r3, r0
	eors	r3, r6
	str	r3, [sp, #32]
	ldr	r3, [sp]
	ldr	r2, [sp]
	eors	r3, r4
	str	r3, [sp, #16]
	movs	r3, #16
	rors	r2, r2, r3
	ldr	r1, [sp, #8]
	str	r0, [sp, #12]
	str	r2, [sp]
	ldr	r0, [sp, #24]
	ldr	r2, .L24
	bl	BM2AM
	ldr	r1, [sp, #4]
	movs	r4, r0
	ldr	r2, .L24
	ldr	r0, [sp, #20]
	bl	BM2AM
	ldr	r1, [sp, #4]
	ldr	r2, [sp, #8]
	mov	ip, r1
	add	r2, r2, ip
	str	r2, [sp, #8]
	movs	r6, r0
	ldr	r1, [sp, #8]
	adds	r0, r4, r0
	ldr	r2, .L24+4
	bl	AM2BM
	ldr	r1, [sp, #4]
	str	r0, [sp, #24]
	ldr	r2, .L24+4
	movs	r0, r6
	bl	AM2BM
	movs	r3, #24
	rors	r0, r0, r3
	ldr	r6, [sp, #4]
	movs	r4, r0
	rors	r6, r6, r3
	ldr	r2, [sp, #24]
	ldr	r0, [sp, #12]
	eors	r4, r2
	ldr	r2, [sp, #8]
	subs	r3, r3, #8
	eors	r6, r2
	rors	r0, r0, r3
	ldr	r1, [sp]
	ldr	r2, .L24
	bl	BM2AM
	movs	r1, r6
	str	r0, [sp, #4]
	ldr	r2, .L24
	movs	r0, r4
	bl	BM2AM
	ldr	r2, [sp]
	movs	r4, r0
	adds	r2, r2, r6
	str	r2, [sp]
	ldr	r2, [sp, #4]
	ldr	r1, [sp]
	adds	r0, r2, r0
	ldr	r2, .L24+4
	bl	AM2BM
	movs	r1, r6
	str	r0, [sp, #12]
	ldr	r2, .L24+4
	movs	r0, r4
	bl	AM2BM
	movs	r3, #19
	rors	r0, r0, r3
	rors	r6, r6, r3
	ldr	r2, [sp, #12]
	ldr	r1, [sp, #16]
	eors	r2, r0
	str	r2, [sp, #20]
	ldr	r2, [sp]
	ldr	r0, [sp, #32]
	eors	r2, r6
	str	r2, [sp, #4]
	ldr	r2, .L24
	bl	BM2AM
	ldr	r1, [sp, #8]
	movs	r4, r0
	ldr	r2, .L24
	ldr	r0, [sp, #24]
	bl	BM2AM
	ldr	r1, [sp, #16]
	ldr	r2, [sp, #8]
	mov	ip, r1
	add	r2, r2, ip
	adds	r6, r4, r0
	str	r2, [sp, #8]
	movs	r0, r4
	ldr	r2, .L24+4
	bl	AM2BM
	ldr	r1, [sp, #8]
	movs	r4, r0
	ldr	r2, .L24+4
	movs	r0, r6
	bl	AM2BM
	movs	r2, #25
	rors	r4, r4, r2
	movs	r3, #16
	movs	r6, r4
	ldr	r1, [sp, #16]
	eors	r6, r0
	rors	r1, r1, r2
	ldr	r2, [sp, #8]
	rors	r0, r0, r3
	rors	r2, r2, r3
	ldr	r3, [sp, #28]
	ldr	r4, [sp, #8]
	subs	r3, r3, #1
	eors	r4, r1
	str	r0, [sp, #24]
	str	r2, [sp, #8]
	str	r3, [sp, #28]
	cmp	r3, #0
	beq	.LCB845
	b	.L20	@long jump
.LCB845:
	ldr	r2, [sp]
	ldr	r3, [sp, #12]
	eors	r6, r4
	eors	r3, r2
	ldr	r2, [sp, #40]
	eors	r3, r2
	str	r3, [r5]
	ldr	r3, [sp, #44]
	ldr	r2, [sp, #8]
	eors	r6, r3
	movs	r3, r0
	eors	r3, r2
	ldr	r2, [sp, #48]
	str	r6, [r5, #4]
	eors	r3, r2
	str	r3, [r5, #8]
	ldr	r6, [sp, #20]
	ldr	r3, [sp, #4]
	eors	r6, r3
	ldr	r3, [sp, #52]
	eors	r6, r3
	str	r6, [r5, #12]
	add	sp, sp, #80
	@ sp needed
	pop	{r4, r5, r6, pc}
.L25:
	.align	2
.L24:
	.word	305419896
	.word	-2023406815
	.size	chaskeyMask, .-chaskeyMask
	.global	C
	.section	.data.C,"aw",%progbits
	.align	2
	.set	.LANCHOR0,. + 0
	.type	C, %object
	.size	C, 8
C:
	.word	0
	.word	135
	.ident	"GCC: (GNU MCU Eclipse ARM Embedded GCC, 64-bit) 7.3.1 20180622 (release) [ARM/embedded-7-branch revision 261907]"
