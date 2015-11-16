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

int seq_read(struct seq *, void *);
int seq_write(struct seq *, void *);
int seq_next(struct seq *);
int seq_prev(struct seq *);
int seq_to(struct seq *, const size_t);
