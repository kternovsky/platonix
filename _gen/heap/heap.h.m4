divert(-1)
define(`HEAP_NAME', `ACTIVE_HEAP')
define(`HEAP_TYPE', `_get(`HEAP_NAMES', ACTIVE_HEAP)')
define(`HEAP_SUF', `HEAP_NAME`'_`$1'')
divert dnl
struct HEAP_NAME
{
	HEAP_TYPE *data;
	size_t sz;
	size_t cap;
};

void HEAP_SUF(`push')(struct HEAP_NAME *, const HEAP_TYPE);
void HEAP_SUF(`pop')(struct HEAP_NAME *, HEAP_TYPE *);
void HEAP_SUF(`fix')(struct HEAP_NAME *);
undefine(`HEAP_NAME')
undefine(`HEAP_TYPE')
undefine(`HEAP_SUF')
