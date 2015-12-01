divert(-1)
define(`HSET_NAME', `ACTIVE_HSET')
define(`HSET_VAL', `_get(`HSET_NAMES_VALS', ACTIVE_HSET)')
define(`HSET_HASH', `_get(`HSET_HFNS', ACTIVE_HSET)')
define(`HSET_CMP', `_get(`HSET_KEY_EQ', ACTIVE_HSET)')
define(`HSET_SUF', `HSET_NAME`'_`$1'')
include(seq/seq.m4)
divert(-1)
ifdef(`append', `', `include(_util/append.m4)')
divert(-1)
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
int HSET_SUF(`del')(struct HSET_NAME *, const HSET_VAL, HSET_VAL *);
int HSET_SUF(`has')(const struct HSET_NAME *, const HSET_VAL);
ifdef(`HSET_VSEQ',`dnl
int HSET_SUF(`union')(struct HSET_NAME *, const struct HSET_NAME *, const struct HSET_NAME *);
int HSET_SUF(`intersection')(struct HSET_NAME *, const struct HSET_NAME *, const struct HSET_NAME *);
int HSET_SUF(`diff')(struct HSET_NAME *, const struct HSET_NAME *, const struct HSET_NAME *);
int HSET_SUF(`is_subset')(const struct HSET_NAME *, const struct HSET_NAME *);
include(_gen/hset/hset.vseq.h.m4)')dnl
dnl patsubst(patsubst(indir(`$$hset_generic_init'), `@$', `'), `@', `, \
dnl ')

divert(-1)
dnl define(`HSET_GENERICS', `dnl
dnl `#'def`'ine hset_init(HSet) _Generic((Hset), patsubst(patsubst(indir(`$$hset_generic_init'), `@$', `'), `@', `, \\
dnl '))(HSet)
dnl dnl
dnl `#'def`'ine hset_init2(HSet1, HSet2) _Generic((Hset1), patsubst(patsubst(indir(`$$hset_generic_init2'), `@$', `'), `@', `, \\
dnl '))(HSet1, HSet2)
dnl dnl
dnl `#'def`'ine hset_ins(HSet, Val) _Generic((Hset), patsubst(patsubst(indir(`$$hset_generic_ins'), `@$', `'), `@', `, \\
dnl '))(HSet, Val)
dnl dnl
dnl ')
undefine(`HSET_NAME')
undefine(`HSET_VAL')
undefine(`HSET_HASH')
undefine(`HSET_CMP')
undefine(`HSET_SUF')
divert dnl
