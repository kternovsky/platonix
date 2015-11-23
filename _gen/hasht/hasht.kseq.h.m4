struct HASHT_SUF(`kseq')
{
	struct HASHT_KSEQ seq;
	struct HASHT_SUF(`seq_ctx') ctx;
};

int HASHT_SUF(`keys')(struct HASHT_SUF(`kseq') *, const struct HASHT_NAME *);
