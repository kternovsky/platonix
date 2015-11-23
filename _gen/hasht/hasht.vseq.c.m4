static int HASHT_SUF(`vseq_read')(struct HASHT_VSEQ *, HASHT_VAL *);
static int HASHT_SUF(`vseq_next')(struct HASHT_VSEQ *);
static struct HASHT_VSEQ`'_ops HASHT_SUF(`val_ops') =
{
	.read = &HASHT_SUF(`vseq_read'),
	.next = &HASHT_SUF(`vseq_next')
};

int HASHT_SUF(`vals')(struct HASHT_SUF(`vseq') *s, const struct HASHT_NAME *h)
{
	s->seq.ops = &HASHT_SUF(`val_ops');
	s->ctx.h = h;
	s->ctx.c = 0;
	return 0;
}

static int HASHT_SUF(`vseq_read')(struct HASHT_VSEQ *s, HASHT_VAL *r)
{
	const struct HASHT_SUF(`vseq') *ss = (struct HASHT_SUF(`vseq') *)s;
	const size_t idx = ss->ctx.c;
	*r = ss->ctx.h->data[ss->ctx.h->index[idx]].entry.key;
	return 0;
}
static int HASHT_SUF(`vseq_next')(struct HASHT_VSEQ *s)
{
	struct HASHT_SUF(`vseq') *ss = (struct HASHT_SUF(`vseq') *)s;
	if(ss->ctx.h->index[ss->ctx.c] != -1)
		return ss->ctx.h->index[ss->ctx.c++];

	while(++ss->ctx.c < ss->ctx.h->cap)
		if(ss->ctx.h->index[ss->ctx.c] != -1) return 0;

	return 1;
}

