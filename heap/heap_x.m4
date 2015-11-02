define(`HEAP_NAME', `heap_x')dnl
define(`HEAP_DATA_TYPE', `void *')dnl
define(`HEAP_COMPARE',`$1->cmpfn($1->data[$2], $1->data[$3], $1->cmpctx) > 0')dnl
define(`HEAP_HEADER', `heap_x.h')dnl
define(`HEAP_PREAMBLE', `#if __STDC_VERSION__ > 199901L
#define RESTRICT restrict
#else
#define RESTRICT
#endif')dnl
define(`HEAP_EXTRA_MEMBERS', `int (*cmpfn)(const void *RESTRICT, const void *RESTRICT, void *RESTRICT);
void *cmpctx;')dnl

