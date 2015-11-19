define(`SEQ_OPS',`int (*read)(struct SEQ_NAME *, $1 *);
int (*next)(struct SEQ_NAME *);
')dnl
define(`SEQ_BI_OPS',`int (*prev)(struct SEQ_NAME *);')dnl
define(`SEQ_RAND_OPS',`int (*to)(struct SEQ_NAME *, const size_t);')dnl
struct SEQ_NAME;
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
