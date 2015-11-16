`#ifndef' VEC_NAME`'_H
`#define' VEC_NAME`'_H

`#include' <stddef.h>

struct VEC_NAME
{
	VEC_VAL_TYPE *data;
	size_t cap;
	size_t sz;
	ifdef(`VEC_EXTRA_MEMBERS',VEC_EXTRA_MEMBERS)dnl
};

int VEC_NAME`'_append(struct VEC_NAME *, VEC_VAL_TYPE);
int VEC_NAME`'_appendr(struct VEC_NAME *, VEC_VAL_TYPE *, const size_t);
int VEC_NAME`'_pop(struct VEC_NAME *);
int VEC_NAME`'_popn(struct VEC_NAME *, const size_t);
int VEC_NAME`'_ins(struct VEC_NAME *, const size_t, const VEC_VAL_TYPE);
int VEC_NAME`'_insr(struct VEC_NAME *, const size_t, const VEC_VAL_TYPE *, const size_t);
int VEC_NAME`'_rem(struct VEC_NAME *, const size_t);
int VEC_NAME`'_remr(struct VEC_NAME *, const size_t, const size_t);
int VEC_NAME`'_ensure(struct VEC_NAME *v, const size_t)
`#endif'
