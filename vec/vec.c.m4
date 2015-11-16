`#include' "VEC_HEADER"
`#include' <stdlib.h>
`#include' <string.h>
int VEC_NAME`'_append(struct VEC_NAME *v, const VEC_VAL_TYPE val)
{
	if(v->sz == v->cap && VEC_NAME`'_ensure(v, v->sz + 1))
		return 1;

	v->data[v->sz++] = val;
	return 0;
}

int VEC_NAME`'_appendr(struct VEC_NAME *v, const VEC_VAL_TYPE *vals, const size_t n)
{
	if(v->sz > v->cap - n && VEC_NAME`'_ensure(v, v->sz + n))
		return 1;

	memcpy(&v->data[v->sz], vals, sizeof *vals * n);
	v->sz += n;

	return 0;
}

int VEC_NAME`'_pop(struct VEC_NAME *v)
{
	if(!v->sz) return 1;

	v->sz--;
	return 0;
}

int VEC_NAME`'_popn(struct VEC_NAME *v, const size_t n)
{
	if(v->sz < n) return 1;

	v->sz -= n;
	return 0;
}

int VEC_NAME`'_ins(struct VEC_NAME *v, const size_t i, const VEC_VAL_TYPE val)
{
	if(i > v->sz) return 1;
	if(i == v->sz) return VEC_NAME`'_append(v, val);

	memmove(&v->data[i + 1], &v->data[i], sizeof *v->data * (v->sz - i - 1));
	v->data[i] = val;

	return 0;
}

int VEC_NAME`'_insr(struct VEC_NAME *v, const size_t i, const VEC_VAL_TYPE *vals, const size_t n)
{
	if(v->sz + n > v->cap && VEC_NAME`'_ensure(v, v->sz + n)) return 1;

	dnl memcpy vs memmove here
	memmove(&v->data[i + n], &v->data[i], sizeof *v->data * (v->sz - i));
	memcpy(&v->data[i], vals, sizeof *vals * n);

	return 0;
}

int VEC_NAME`'_rem(struct VEC_NAME *v, const size_t i)
{
	if(v->sz == i) return VEC_NAME`'_pop(v);

	memmove(&v->data[i], &v->data[i + 1], sizeof *v->data * (v->sz - i - 1));
	return 0;
}

int VEC_NAME`'_remr(struct VEC_NAME *v, const size_t i, const size_t n)
{
	if(v->sz < i + n) return 1;

	if(v->sz == i + n)
	{
		v->sz = i;
		return 0;
	}

	memmove(&v->data[i], &v->data[i + n], sizeof *v->data * (v->sz - i - n));
	return 0;
}

int VEC_NAME`'_ensure(struct VEC_NAME *v, const size_t req)
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
