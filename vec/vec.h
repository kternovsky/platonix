#ifndef VEC_H_KUFFLBVC
#define VEC_H_KUFFLBVC

#include <stddef.h>

struct vec
{
	int *data;
	size_t cap;
	size_t sz;
};

int vec_append(struct vec *, const int);
int vec_appendr(struct vec *, const int *, const size_t);
int vec_pop(struct vec *);
int vec_popn(struct vec *, const size_t);
int vec_ins(struct vec *, const size_t, const int);
int vec_insr(struct vec *, const size_t, const int *, const size_t);
int vec_rem(struct vec *, const size_t);
int vec_remr(struct vec *, const size_t, const size_t);

#endif /* end of include guard: VEC_H_KUFFLBVC */
