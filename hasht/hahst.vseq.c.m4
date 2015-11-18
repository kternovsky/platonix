static int HASHT_NAME`'_vseq_read(HASHT_VAL_SEQ *, HASHT_KEY_TYPE *);
static int HASHT_NAME`'_vseq_next(HASHT_VAL_SEQ *);
static HASHT_VAL_SEQ`'_ops HASHT_NAME`'_key_ops =
{
	.read = &`'HASHT_NAME`'_vseq_read,
	.next = &`'HASHT_NAME`'_vseq_next
};

int HASHT_NAME`'_keys(struct HASHT_NAME`'_vseq *s, const struct HASHT_NAME *h)
{
	s->seq.ops = &`'HASHT_NAME`'_key_ops;
	s->ctx.h = h;
	s->ctx.c = 0;
	return 0;
}

static int HASHT_NAME`'_vseq_read(HASHT_VAL_SEQ *s, HASHT_VAL_TYPE *r)
{
	const struct HASHT_NAME`'_vseq *ss = (struct HASHT_NAME`'_vseq *)s;
	const size_t idx = ss->ctx.c;
	*r = ss->ctx.h->data[ss->ctx.h->index[idx]].entry.key;
	return 0;
}
static int HASHT_NAME`'_vseq_next(HASHT_VAL_SEQ *s)
{
	struct HASHT_NAME`'_vseq *ss = (struct HASHT_NAME`'_vseq *)s;
	if(ss->ctx.h->index[ss->ctx.c] != -1)
		return ss->ctx.h->index[ss->ctx.c++];

	while(++ss->ctx.c < ss->ctx.h->cap)
		if(ss->ctx.h->index[ss->ctx.c] != -1) return 0;

	return 1;
}

