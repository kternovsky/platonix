static int HASHT_SUF(`kvseq_read')(struct HASHT_KVSEQ *, HASHT_KEY *);
static int HASHT_SUF(`kvseq_next')(struct HASHT_KVSEQ *);
static struct HASHT_KVSEQ`'_ops HASHT_SUF(`kv_ops') =
{
	.read = &HASHT_SUF(`kvseq_read'),
	.next = &HASHT_SUF(`kvseq_next')
};

int HASHT_SUF(`iter')(struct HASHT_SUF(`kvseq') *s, const struct HASHT_NAME *h)
{
	s->seq.ops = &HASHT_SUF(`kv_ops');
	s->ctx.h = h;
	s->ctx.c = 0;
	return 0;
}

static int HASHT_SUF(`kvseq_read')(struct HASHT_KVSEQ *s, HASHT_KVP *r)
{
	const struct HASHT_SUF(`kvseq') *ss = (struct HASHT_SUF(`kvseq') *)s;
	const size_t idx = ss->ctx.c;
	r->first = ss->ctx.h->data[ss->ctx.h->index[idx]].entry.key;
	r->second = ss->ctx.h->data[ss->ctx.h->index[idx]].entry.value;
	return 0;
}
static int HASHT_SUF(`kvseq_next')(struct HASHT_KVSEQ *s)
{
	struct HASHT_SUF(`kvseq') *ss = (struct HASHT_SUF(`kvseq') *)s;
	if(ss->ctx.h->index[ss->ctx.c] != -1)
		return ss->ctx.h->index[ss->ctx.c++];

	while(++ss->ctx.c < ss->ctx.h->cap)
		if(ss->ctx.h->index[ss->ctx.c] != -1) return 0;

	return 1;
}

