divert(-1)
define(`HASHT_NAME', `ACTIVE_HASHT')
define(`HASHT_KEY', `_get(`HASHT_NAMES_KEYS', ACTIVE_HASHT)')
define(`HASHT_VAL', `_get(`HASHT_NAMES_VALS', ACTIVE_HASHT)')
define(`HASHT_SUF', `HASHT_NAME`'_`$1'')
include(seq/seq.m4)dnl
include(pair/pair.m4)dnl
divert dnl
ifelse(_get(`SEQ_TYPES', HASHT_KEY), `', `', `define(`HASHT_KSEQ', _get(`SEQ_TYPES', HASHT_KEY)) define(`HASHT_SEQUENCES',1)')
ifelse(_get(`SEQ_TYPES', HASHT_VAL), `', `', `define(`HASHT_VSEQ', _get(`SEQ_TYPES', HASHT_VAL)) define(`HASHT_SEQUENCES',1)')
ifelse(_get(`PAIR_TYPES', HASHT_KEY`'_`'HASHT_VAL), `', `', `ifelse(_get(`SEQ_TYPES', struct _get(`PAIR_TYPES', HASHT_KEY`'_`'HASHT_VAL)), `', `', `define(`HASHT_KVP', `_get(`PAIR_TYPES', HASHT_KEY`'_`'HASHT_VAL)') define(`HASHT_KVSEQ', `_get(`SEQ_TYPES', struct HASHT_KVP)')')')

struct HASHT_SUF(`entry')
{
	HASHT_KEY key;
	HASHT_VAL value;
};

struct HASHT_SUF(`data')
{
	struct HASHT_SUF(`entry') entry;
	size_t hash;
	size_t next;
};

struct HASHT_NAME
{
	size_t *index;
	struct HASHT_SUF(`data') *data;
	size_t cap;
	size_t sz;
	size_t cursor;
	size_t free;
};

void HASHT_SUF(`init')(struct HASHT_NAME *);
int HASHT_SUF(`init2')(struct HASHT_NAME *, const struct HASHT_NAME *);
int HASHT_SUF(`ins')(struct HASHT_NAME *, const HASHT_KEY, const HASHT_VAL);
int HASHT_SUF(`update')(struct HASHT_NAME *, const HASHT_KEY, const HASHT_VAL);
int HASHT_SUF(`get')(const struct HASHT_NAME *, const HASHT_KEY, struct HASHT_SUF(`entry') *);
int HASHT_SUF(`del')(struct HASHT_NAME *, const HASHT_KEY, struct HASHT_SUF(`entry') *);
int HASHT_SUF(`has')(const struct HASHT_NAME *, const HASHT_KEY);
ifdef(`HASHT_SEQUENCES', `include(_gen/hasht/hasht.seq.ctx.h.m4)')dnl
ifdef(`HASHT_KSEQ', `include(_gen/hasht/hasht.kseq.h.m4)',`')dnl
ifdef(`HASHT_VSEQ', `include(_gen/hasht/hasht.vseq.h.m4)',`')dnl
ifdef(`HASHT_KVSEQ', `include(_gen/hasht/hasht.kvseq.h.m4)',`')dnl

undefine(`HASHT_NAME')
undefine(`HASHT_KEY')
undefine(`HASHT_VAL')
undefine(`HASHT_SUF')
