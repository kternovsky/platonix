static int HASHT_NAME`'_kseq_read(HASHT_KEY_SEQ *, HASHT_KEY_TYPE *);
static int HASHT_NAME`'_kseq_next(HASHT_KEY_SEQ *);
static HASHT_KEY_SEQ`'_ops HASHT_NAME`'_key_ops =
{
	.read = &`'HASHT_NAME`'_kseq_read,
	.next = &`'HASHT_NAME`'_kseq_next
};

int HASHT_NAME`'_keys(struct HASHT_NAME`'_kseq *s, const struct HASHT_NAME *h)
{
	s->seq.ops = &`'HASHT_NAME`'_key_ops;
	s->ctx.h = h;
	s->ctx.c = 0;
	return 0;
}

static int HASHT_NAME`'_kseq_read(HASHT_KEY_SEQ *s, HASHT_KEY_TYPE *r)
{
	const struct HASHT_NAME`'_kseq *ss = (struct HASHT_NAME`'_kseq *)s;
	const size_t idx = ss->ctx.c;
	*r = ss->ctx.h->data[ss->ctx.h->index[idx]].entry.key;
	return 0;
}
static int HASHT_NAME`'_kseq_next(HASHT_KEY_SEQ *s)
{
	struct HASHT_NAME`'_kseq *ss = (struct HASHT_NAME`'_kseq *)s;
	if(ss->ctx.h->index[ss->ctx.c] != -1)
		return ss->ctx.h->index[ss->ctx.c++];

	while(++ss->ctx.c < ss->ctx.h->cap)
		if(ss->ctx.h->index[ss->ctx.c] != -1) return 0;

	return 1;
}
