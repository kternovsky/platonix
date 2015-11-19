define(`HASHT_NAME', indir(`$$hasht_typename'))
define(`HASHT_KEY_TYPE', indir(`$$hasht_key_type'))
define(`HASHT_VAL_TYPE', indir(`$$hasht_val_type'))
ifelse(translit(indir(`$$hasht_key_seq'), ` '), `', `', `define(`HASHT_KEY_SEQ', translit(indir(`$$hasht_key_seq'), ` '))')
ifelse(translit(indir(`$$hasht_val_seq'), ` '), `', `', `define(`HASHT_VAL_SEQ', translit(indir(`$$hasht_val_seq'), ` '))')
ifelse(translit(indir(`$$hasht_kvp_seq'), ` '), `', `', `define(`HASHT_KVP_SEQ', translit(indir(`$$hasht_kvp_seq'), ` '))')
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
ifelse(HASHT_KEY_SEQ,`!', `', `include(_gen/hasht/hasht.kseq.h.m4)')dnl
ifelse(HASHT_VAL_SEQ,`!', `', `include(_gen/hasht/hasht.vseq.h.m4)')dnl

void HASHT_NAME`'_init(struct HASHT_NAME *);
int HASHT_NAME`'_init2(struct HASHT_NAME *, const struct HASHT_NAME *);
int HASHT_NAME`'_ins(struct HASHT_NAME *, HASHT_KEY_TYPE, HASHT_VAL_TYPE);
int HASHT_NAME`'_update(struct HASHT_NAME *, HASHT_KEY_TYPE, HASHT_VAL_TYPE);
int HASHT_NAME`'_get(struct HASHT_NAME *, HASHT_KEY_TYPE, struct HASHT_NAME`'_entry *);
int HASHT_NAME`'_del(struct HASHT_NAME *, HASHT_KEY_TYPE, struct HASHT_NAME`'_entry *);
int HASHT_NAME`'_has(struct HASHT_NAME *, HASHT_KEY_TYPE);
