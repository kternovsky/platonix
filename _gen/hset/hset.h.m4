divert(-1)
define(`HSET_NAME', `ACTIVE_HSET')
define(`HSET_VAL', `_get(`HSET_NAMES_VALS', ACTIVE_HSET)')
define(`HSET_SUF', `HSET_NAME`'_`$1'')
include(seq/seq.m4)
ifelse(_get(`SEQ_TYPES', HSET_VAL), `', `', `define(`HSET_VSEQ', _get(`SEQ_TYPES', HSET_VAL))')
divert dnl

struct HSET_SUF(`data')
{
	HSET_VAL value;
	size_t hash;
	size_t next;
};

struct HSET_NAME
{
	size_t *index;
	struct HSET_SUF(`data') *data;
	size_t cap;
	size_t sz;
	size_t cursor;
	size_t free;
};

void HSET_SUF(`init')(struct HSET_NAME *);
int HSET_SUF(`init2')(struct HSET_NAME *, const struct HSET_NAME *);
int HSET_SUF(`ins')(struct HSET_NAME *, const HSET_VAL);
int HSET_SUF(`del')(struct HSET_NAME *, HSET_VAL *);
int HSET_SUF(`has')(const struct HSET_NAME *, const HSET_VAL);
ifdef(`HSET_VSEQ',`dnl
int HSET_SUF(`union')(struct HSET_NAME *, const struct HSET_NAME *, const struct HSET_NAME *);
int HSET_SUF(`intersection')(struct HSET_NAME *, const struct HSET_NAME *, const struct HSET_NAME *);
int HSET_SUF(`diff')(struct HSET_NAME *, const struct HSET_NAME *, const struct HSET_NAME *);
int HSET_SUF(`is_subset')(const struct HSET_NAME *, const struct HSET_NAME *);
include(_gen/hset/hset.vseq.h.m4)')dnl
