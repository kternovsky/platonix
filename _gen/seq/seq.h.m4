divert(-1)
define(`SEQ_NAME', indir(`$$seq_typename'))
define(`SEQ_TYPE', indir(`$$seq_type'))
define(`SEQ_SUF', `SEQ_NAME_$1')
define(`SEQ_OPS',`int (*read)(struct SEQ_NAME *, $1 *);
int (*next)(struct SEQ_NAME *);
')
divert dnl
struct SEQ_NAME;
struct SEQ_SUF(`_ops')
{
	SEQ_OPS(`SEQ_TYPE')
};

struct SEQ_NAME
{
	struct SEQ_NAME`'_ops *ops;
	unsigned flags;
};

undefine(`SEQ_NAME')
undefine(`SEQ_TYPE')
undefine(`SEQ_SUF')
undefine(`SEQ_OPS')
