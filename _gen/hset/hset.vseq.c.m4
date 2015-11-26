static int HSET_SUF(`vseq_read')(struct HSET_VSEQ *, HSET_VAL *);
static int HSET_SUF(`vseq_next')(struct HSET_VSEQ *);
static struct HSET_VSEQ`'_ops HSET_SUF(`val_ops') =
{
	.read = &HSET_SUF(`vseq_read'),
	.next = &HSET_SUF(`vseq_next')
};

int HSET_SUF(`iter')(struct HSET_SUF(`vseq') *s, const struct HSET_NAME *h)
{
	s->seq.ops = &HSET_SUF(`val_ops');
	s->ctx.h = h;
	s->ctx.c = 0;
	return 0;
}

static int HSET_SUF(`vseq_read')(struct HSET_VSEQ *s, HSET_VAL *r)
{
	const struct HSET_SUF(`vseq') *ss = (struct HSET_SUF(`vseq') *)s;
	const size_t idx = ss->ctx.c;
	*r = ss->ctx.h->data[ss->ctx.h->index[idx]].value;
	return 0;
}
static int HSET_SUF(`vseq_next')(struct HSET_VSEQ *s)
{
	struct HSET_SUF(`vseq') *ss = (struct HSET_SUF(`vseq') *)s;
	if(ss->ctx.h->index[ss->ctx.c] != -1)
		return ss->ctx.h->index[ss->ctx.c++];

	while(++ss->ctx.c < ss->ctx.h->cap)
		if(ss->ctx.h->index[ss->ctx.c] != -1) return 0;

	return 1;
}
