define(`HASHT_NAME', `hasht_ii')dnl
define(`HASHT_KEY_TYPE', `int')dnl
define(`HASHT_VAL_TYPE', `int')dnl
define(`HASHT_KEY_CMP', `$1 == $2')dnl
define(`HASHT_HASH', `djb2($1)')dnl
define(`HASHT_HEADER', `hasht_ii.h')dnl
dnl
define(`HASHT_C_PREAMBLE',`#include <limits.h>
static size_t djb2(const int k)
{
	size_t hash = 5381;
	int i;
	int mask = 0;

	for(i = 0; i < CHAR_BIT; i++)
		mask |= 1 << i;

	for(i = 0; i < sizeof(int) * CHAR_BIT; i ++)
		hash = ((hash << 5) + hash) + ((k >> (CHAR_BIT * i)) & mask);

	return hash;
}')dnl;
ifdef(`MODE_HEADER',`include(`hasht.h.m4')')dnl
ifdef(`MODE_IMPL',`include(`hasht.c.m4')')dnl
