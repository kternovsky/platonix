static int HASHT_NAME`'_kseq_read(const HASHT_NAME`'_kseq *, HASHT_VAL_TYPE *);
static int HASHT_NAME`'_kseq_next(HASHT_NAME`'_kseq *);
static struct HASHT_KEY_SEQ`'_ops HASHT_NAME`'_key_ops =
{
	.read = HASHT_NAME`'_kseq_read,
	.next = HASHT_NAME`'_kseq_next
};

int HASHT_NAME`'_keys(struct HASHT_NAME`'_kseq *s, const struct HASHT_NAME *h)
{
	s->seq.ops = &ops;
	s->seq.ctx.h = h;
	s->seq.ctx.c = 0;
	return 0;
}

static int HASHT_NAME`'_kseq_read(const struct HASHT_NAME`'_kseq *s, HASHT_VAL_TYPE *v)
{
	size_t index = s->ctx.c;
	*r = s->ctx.h->data[s->ctx.h->index[c]];
	return 0;
}
static int HASHT_NAME`'_kseq_next(HASHT_NAME`'_kseq *s)
{
	if(s->ctx.h->index[s->ctx.c] != -1)
		return s->ctx.h->index[s->ctx.c++];

	while(++s->ctx.c < s->ctx.h->cap)
		if(s->ctx.h->index[s->ctx.c] != -1) return 0;

	return 1;
}
