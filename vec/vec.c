#include "vec.h"
#include <stdlib.h>
#include <string.h>

static int vec_ensure(struct vec *, const size_t);

int vec_append(struct vec *v, const int val)
{
	if(v->sz == v->cap && vec_ensure(v, v->sz + 1))
		return 1;

	v->data[v->sz++] = val;
	return 0;
}

int vec_appendr(struct vec *v, const int *vals, const size_t n)
{
	if(v->sz > v->cap - n && vec_ensure(v, v->sz + n))
		return 1;

	memcpy(&v->data[v->sz], vals, sizeof *vals * n);
	v->sz += n;

	return 0;
}

int vec_pop(struct vec *v)
{
	if(!v->sz) return 1;

	v->sz--;
	return 0;
}

static int vec_ensure(struct vec *v, const size_t req)
{
	size_t nc = v->cap;
	void *tmp;

	while(nc < req) nc <<= 1;

	tmp = realloc(v->data, sizeof *v->data * nc);

	if(!tmp) return 1;

	v->cap = nc;
	v->data = tmp;

	return 0;
}
