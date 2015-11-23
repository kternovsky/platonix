divert(-1)
define(`HASHT_NAME', `ACTIVE_HASHT')
define(`HASHT_KEY', `_get(`HASHT_NAMES_KEYS', ACTIVE_HASHT)')
define(`HASHT_VAL', `_get(`HASHT_NAMES_VALS', ACTIVE_HASHT)')
define(`HASHT_SUF', `HASHT_NAME`'_`$1'')
divert dnl
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
undefine(`HASHT_NAME')
undefine(`HASHT_KEY')
undefine(`HASHT_VAL')
undefine(`HASHT_SUF')
