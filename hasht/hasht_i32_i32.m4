define(`HASHT_NAME', `hasht_i32_i32')dnl
define(`HASHT_KEY_TYPE', `int32_t')dnl
define(`HASHT_VAL_TYPE', `int32_t')dnl
define(`HASHT_KEY_CMP', `$1 == $2')dnl
define(`HASHT_HASH', `djb2($1)')dnl
define(`HASHT_HEADER', `hasht_i32_i32.h')dnl
dnl
define(`HASHT_H_PREAMBLE',`#include <stdint.h>
')dnl
dnl
define(`HASHT_C_PREAMBLE',`#include <limits.h>
static size_t djb2(const int k)
{
	size_t hash = 5381;
	int i;

	for(i = 0; i < sizeof(int) * CHAR_BIT; i ++)
		hash = ((hash << 5) + hash) + ((k >> (CHAR_BIT * i)) & (unsigned char)255);

	return hash;
}')dnl;
