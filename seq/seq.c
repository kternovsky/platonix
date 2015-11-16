#include "seq.h"
int seq_read(struct seq *s, void *r)
{
	return s->ops->read(s, r);
}
int seq_write(struct seq *s, void *v)
{
	return s->ops->write(s, v);
}
int seq_next(struct seq *s)
{
	return s->ops->next(s);
}
int seq_prev(struct seq *s)
{
	return s->ops->prev(s);
}
int seq_to(struct seq *s, const size_t i)
{
	return s->ops->to(s, i);
}
