divert(-1)
define(`SEQ_NAME', `ACTIVE_SEQ')
define(`SEQ_TYPE', _get(`SEQ_NAMES',ACTIVE_SEQ))
define(`SEQ_SUF', `SEQ_NAME`'_$1')
define(`SEQ_OPS',`dnl
int (*read)(struct SEQ_NAME *, $1 *);
int (*next)(struct SEQ_NAME *);
')
divert dnl
struct SEQ_NAME;
struct SEQ_SUF(`ops')
{
	SEQ_OPS(`SEQ_TYPE')
};

struct SEQ_NAME
{
	struct SEQ_SUF(`ops') *ops;
	unsigned flags;
};
undefine(`SEQ_NAME')
undefine(`SEQ_TYPE')
undefine(`SEQ_SUF')
undefine(`SEQ_OPS')
