`#ifndef' HASHT_NAME`'_H_
`#define' HASHT_NAME`'_H_
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
int HASHT_NAME`'_init2(struct HASHT_NAME *, const struct HASHT_NAME *);
int HASHT_NAME`'_ins(struct HASHT_NAME *, HASHT_KEY_TYPE, HASHT_VAL_TYPE);
int HASHT_NAME`'_update(struct HASHT_NAME *, HASHT_KEY_TYPE, HASHT_VAL_TYPE);
int HASHT_NAME`'_get(struct HASHT_NAME *, HASHT_KEY_TYPE, struct HASHT_NAME`'_entry *);
int HASHT_NAME`'_del(struct HASHT_NAME *, HASHT_KEY_TYPE, struct HASHT_NAME`'_entry *);
int HASHT_NAME`'_has(struct HASHT_NAME *, HASHT_KEY_TYPE);
#endif
