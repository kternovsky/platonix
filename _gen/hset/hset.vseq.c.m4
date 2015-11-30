static int HSET_SUF(`vseq_read')(struct HSET_VSEQ *, HSET_VAL *);
static int HSET_SUF(`vseq_next')(struct HSET_VSEQ *);
static struct HSET_VSEQ`'_ops HSET_SUF(`val_ops') =
{
	.read = &HSET_SUF(`vseq_read'),
	.next = &HSET_SUF(`vseq_next')
};

int HSET_SUF(`iter')(struct HSET_SUF(`vseq') *s, const struct HSET_NAME *h)
{
	size_t i;
	s->seq.ops = &HSET_SUF(`val_ops');
	s->ctx.h = h;

	for(i = 0; i < h->cap; i++)
		if(h->index[i] != -1) break;

	s->ctx.b = i;
	s->ctx.d = s->ctx.h->index[i];
	return 0;
}

static int HSET_SUF(`vseq_read')(struct HSET_VSEQ *s, HSET_VAL *r)
{
	const struct HSET_SUF(`vseq') *ss = (struct HSET_SUF(`vseq') *)s;
	const size_t idx = ss->ctx.d;
	*r = ss->ctx.h->data[idx].value;
	return 0;
}
static int HSET_SUF(`vseq_next')(struct HSET_VSEQ *s)
{
	struct HSET_SUF(`vseq') *ss = (struct HSET_SUF(`vseq') *)s;
	size_t i;

	if((i = ss->ctx.h->data[ss->ctx.d].next) != -1)
	{
		ss->ctx.d = i;
		return 0;
	}
	else
	{
		for(i = ss->ctx.b + 1; i < ss->ctx.h->cap; i++)
		{
			if(ss->ctx.h->index[i] != -1)
			{
				ss->ctx.b = i;
				ss->ctx.d = ss->ctx.h->index[i];
				return 0;
			}
		}
	}

	return 1;
}
