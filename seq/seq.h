#include <stddef.h>
struct seq_ops
{
	int (*read)(void *, void *);
	int (*write)(void *, void *);
	int (*next)(void *);
	int (*prev)(void *);
	int (*to)(void *, const size_t);
};

struct seq
{
	struct seq_ops *ops;
	unsigned flags;
};
