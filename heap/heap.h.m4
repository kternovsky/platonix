define(`HEAP_EXTRA_MEMBERS',`')dnl
define(`HEAP_PREAMBLE',`')dnl
include(HEAP_CONFIG)dnl
`#ifndef' HEAP_NAME`'_H_ 
`#define' HEAP_NAME`'_H_ 
HEAP_PREAMBLE

#include <stddef.h>

struct HEAP_NAME
{
	HEAP_DATA_TYPE *data;
	size_t sz;
	size_t cap;
	HEAP_EXTRA_MEMBERS
};

void HEAP_NAME`'_push(struct HEAP_NAME *h, HEAP_DATA_TYPE val);
void HEAP_NAME`'_pop(struct HEAP_NAME *h, HEAP_DATA_TYPE *val);

#endif
