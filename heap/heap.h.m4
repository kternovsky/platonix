dnl define(`HEAP_EXTRA_MEMBERS',`')dnl
dnl define(`HEAP_PREAMBLE',`')dnl
`#ifndef' HEAP_NAME`'_H_ 
`#define' HEAP_NAME`'_H_ 
ifdef(`HEAP_PREAMBLE',HEAP_PREAMBLE)

#include <stddef.h>

struct HEAP_NAME
{
	HEAP_DATA_TYPE *data;
	size_t sz;
	size_t cap;
	ifdef(`HEAP_EXTRA_MEMBERS',HEAP_EXTRA_MEMBERS)dnl
};

void HEAP_NAME`'_push(struct HEAP_NAME *, HEAP_DATA_TYPE);
void HEAP_NAME`'_pop(struct HEAP_NAME *, HEAP_DATA_TYPE *);
void HEAP_NAME`'_fix(struct HEAP_NAME *);

ifdef(`HEAP_STORE_INDEX',void HEAP_NAME`'_keydn(struct HEAP_NAME *, const size_t, const size_t);
void HEAP_NAME`'_keyup(struct HEAP_NAME *, const size_t, const size_t);)dnl

#endif
