define(`SEQ_OPS',`int (*read)(void *, $1 *);
int (*next)(void *);
')dnl
define(`SEQ_BI_OPS',`int (*prev)(void *);')dnl
define(`SEQ_RAND_OPS',`int (*to)(void *, const size_t);')dnl
struct SEQ_NAME`'_ops
{
	SEQ_OPS(SEQ_TYPE)
	dnl ifdef(`SEQ_BI',SEQ_BI_OPS)
	dnl ifdef(`SEQ_RAND',SEQ_RAND_OPS)
};

struct SEQ_NAME
{
	struct SEQ_NAME`'_ops *ops;
	unsigned flags;
};
