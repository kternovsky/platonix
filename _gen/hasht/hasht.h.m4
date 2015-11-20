divert(-1)
define(`HASHT_NAME', indir(`$$hasht_typename'))
define(`HASHT_KEY_TYPE', indir(`$$hasht_key_type'))
define(`HASHT_VAL_TYPE', indir(`$$hasht_val_type'))
define(`HASHT_SUF', `HASHT_NAME'_`$1')
define(`HASHT_EXTRA_MEMBERS', indir(`$$hasht_extra_members'))
ifelse(translit(indir(`$$hasht_key_seq'), ` '), `', `', `define(`HASHT_KEY_SEQ', translit(indir(`$$hasht_key_seq'), ` '))')
ifelse(translit(indir(`$$hasht_val_seq'), ` '), `', `', `define(`HASHT_VAL_SEQ', translit(indir(`$$hasht_val_seq'), ` '))')
ifelse(translit(indir(`$$hasht_kvp_seq'), ` '), `', `', `define(`HASHT_KVP_SEQ', translit(indir(`$$hasht_kvp_seq'), ` '))')
divert dnl
struct HASHT_SUF(`entry')
{
	HASHT_KEY_TYPE key;
	HASHT_VAL_TYPE value;
};

struct HASHT_SUF(`data')
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
	HASHT_EXTRA_MEMBERS
};

int HASHT_SUF(`init')(struct HASHT_NAME *);
int HASHT_SUF(`init2')(struct HASHT_NAME *, const struct HASHT_NAME *);
int HASHT_SUF(`ins')(struct HASHT_NAME *, const HASHT_KEY_TYPE, const HASHT_VAL_TYPE);
int HASHT_SUF(`update')(struct HASHT_NAME *, const HASHT_KEY_TYPE, const HASHT_VAL_TYPE);
int HASHT_SUF(`get')(struct HASHT_NAME *, const HASHT_KEY_TYPE, struct HASHT_SUF(`entry') *);
int HASHT_SUF(`del')(struct HASHT_NAME *, const HASHT_KEY_TYPE, struct HASHT_SUF(`entry') *);
int HASHT_SUF(`has')(struct HASHT_NAME *, const HASHT_KEY_TYPE);
undefine(`HASHT_NAME', indir(`$$hasht_typename'))
undefine(`HASHT_KEY_TYPE', indir(`$$hasht_key_type'))
undefine(`HASHT_VAL_TYPE', indir(`$$hasht_val_type'))
undefine(`HASHT_SUF', `HASHT_NAME'_`$1')
undefine(`HASHT_EXTRA_MEMBERS', indir(`$$hasht_extra_members'))
undefine(`HASHT_KEY_SEQ')
undefine(`HASHT_VAL_SEQ')
undefine(`HASHT_KVP_SEQ')
