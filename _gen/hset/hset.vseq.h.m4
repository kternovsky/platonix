struct HSET_SUF(`seq_ctx')
{
	const struct HSET_NAME *h;
	size_t c;
};

struct HSET_SUF(`vseq')
{
	struct HSET_VSEQ seq;
	struct HSET_SUF(`seq_ctx') ctx;
};

int HSET_SUF(`iter')(struct HSET_SUF(`vseq') *, const struct HSET_NAME *);
