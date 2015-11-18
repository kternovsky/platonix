include(`seq.def.m4')dnl
include(`hasht.def.m4')dnl
`#include' <stddef.h>
SEQ_DEFINITION(`seq_cp', `char *')dnl
SEQ_INTERFACE
HASHT_DEFINITION(`hasht_si',`char *', `int', `djb2($1)', `$1 == $2', `struct seq_cp', `')dnl
dnl HASHT_DEFINITION(`hasht_cc',`char *', `char *', `djb2', `!strcmp($1, $2)', `seq_cp')dnl
HASHT_INTERFACE
HASHT_DEFINITION(`hasht_si',`char *', `int', `djb2($1)', `$1 == $2', `struct seq_cp', `')dnl
static size_t djb2(const char *);
HASHT_IMPLEMENTATION
static size_t djb2(const char *k)
{
	size_t hash = 5381;
	int c;

	while((c = *k++))
		hash = ((hash << 5) + hash) + c;

	return hash;
}
