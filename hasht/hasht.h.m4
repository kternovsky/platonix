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

define(HASHT_SEQ_CTX_DEF,`dnl
struct HASHT_NAME`'_seq_ctx
{
	const struct HASHT_NAME *h;
	size_t c;
};')dnl

ifelse(`HASHT_KEY_SEQ',`!',`',`dnl
define(HASHT_CTX)dnl
HASHT_SEQ_CTX_DEF
')dnl

ifdef(`HASHT_CTX', `', `ifelse(HASHT_VAL_SEQ, `!', `', `dnl
HASHT_SEQ_CTX_DEF
')')dnl
dnl
undefine(HASHT_SEQ_CTX_DEF)dnl
undefine(HASHT_CTX)dnl
dnl
ifelse(HASHT_KEY_SEQ,`!', `', `include(hasht.kseq.h.m4)')dnl
ifelse(HASHT_VAL_SEQ,`!', `', `dnl
struct HASHT_NAME`'_vseq
{
	HASHT_VAL_SEQ seq;
	struct HASHT_NAME`'_seq_ctx ctx;
};
int HASHT_NAME`'_vals(struct HASHT_NAME`'_vseq *, const struct HASHT_NAME *);')

void HASHT_NAME`'_init(struct HASHT_NAME *);
int HASHT_NAME`'_init2(struct HASHT_NAME *, const struct HASHT_NAME *);
int HASHT_NAME`'_ins(struct HASHT_NAME *, HASHT_KEY_TYPE, HASHT_VAL_TYPE);
int HASHT_NAME`'_update(struct HASHT_NAME *, HASHT_KEY_TYPE, HASHT_VAL_TYPE);
int HASHT_NAME`'_get(struct HASHT_NAME *, HASHT_KEY_TYPE, struct HASHT_NAME`'_entry *);
int HASHT_NAME`'_del(struct HASHT_NAME *, HASHT_KEY_TYPE, struct HASHT_NAME`'_entry *);
int HASHT_NAME`'_has(struct HASHT_NAME *, HASHT_KEY_TYPE);
