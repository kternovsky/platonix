struct HASHT_SUF(`vseq')
{
	struct HASHT_VSEQ seq;
	struct HASHT_SUF(`seq_ctx') ctx;
};

int HASHT_SUF(`vals')(struct HASHT_SUF(`vseq') *, const struct HASHT_NAME *);
