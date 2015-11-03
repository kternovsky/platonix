dnl define(`HASHT_H_PREAMBLE',`')dnl
dnl define(`HASHT_EXTRA_MEMBERS',`')dnl
`#include' <stddef.h>
ifdef(`HASHT_H_PREAMBLE',HASHT_H_PREAMBLE)dnl
struct HASHT_NAME`'_entry
{
	HASHT_KEY_TYPE key;
	HASHT_VAL_TYPE value;
};

struct HASHT_NAME`'_data
{
	struct HASHT_NAME`'_entry entry;
	size_t hash;
	size_t next;
};

struct HASHT_NAME
{
	size_t *index;
	struct HASHT_NAME`'_data *data;
	size_t cap;
	size_t sz;
	size_t cursor;
	size_t free;
	ifdef(`HASHT_EXTRA_MEMBERS',HASHT_EXTRA_MEMBERS)dnl
};

void HASHT_NAME`'_init(struct HASHT_NAME *);
void HASHT_NAME`'_rehash(struct HASHT_NAME *, const size_t);
int HASHT_NAME`'_ins(struct HASHT_NAME *, HASHT_KEY_TYPE, HASHT_VAL_TYPE);
int HASHT_NAME`'_udpate(struct HASHT_NAME *, HASHT_KEY_TYPE, HASHT_VAL_TYPE);
int HASHT_NAME`'_get(struct HASHT_NAME *, HASHT_KEY_TYPE, struct HASHT_NAME`'_entry *);
int HASHT_NAME`'_del(struct HASHT_NAME *, HASHT_KEY_TYPE, struct HASHT_NAME`'_entry *);
int HASHT_NAME`'_has(struct HASHT_NAME *, HASHT_KEY_TYPE);
