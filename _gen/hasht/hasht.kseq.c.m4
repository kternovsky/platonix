static int HASHT_SUF(`kseq_read')(struct HASHT_KSEQ *, HASHT_KEY *);
static int HASHT_SUF(`kseq_next')(struct HASHT_KSEQ *);
static struct HASHT_KSEQ`'_ops HASHT_SUF(`key_ops') =
{
	.read = &HASHT_SUF(`kseq_read'),
	.next = &HASHT_SUF(`kseq_next')
};

int HASHT_SUF(`keys')(struct HASHT_SUF(`kseq') *s, const struct HASHT_NAME *h)
{
	s->seq.ops = &HASHT_SUF(`key_ops');
	s->ctx.h = h;
	s->ctx.c = 0;
	return 0;
}

static int HASHT_SUF(`kseq_read')(struct HASHT_KSEQ *s, HASHT_KEY *r)
{
	const struct HASHT_SUF(`kseq') *ss = (struct HASHT_SUF(`kseq') *)s;
	const size_t idx = ss->ctx.c;
	*r = ss->ctx.h->data[ss->ctx.h->index[idx]].entry.key;
	return 0;
}
static int HASHT_SUF(`kseq_next')(struct HASHT_KSEQ *s)
{
	struct HASHT_SUF(`kseq') *ss = (struct HASHT_SUF(`kseq') *)s;
	if(ss->ctx.h->index[ss->ctx.c] != -1)
		return ss->ctx.h->index[ss->ctx.c++];

	while(++ss->ctx.c < ss->ctx.h->cap)
		if(ss->ctx.h->index[ss->ctx.c] != -1) return 0;

	return 1;
}
