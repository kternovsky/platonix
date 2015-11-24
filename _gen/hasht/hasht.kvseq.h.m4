struct HASHT_SUF(`kvseq')
{
	struct HASHT_KVSEQ seq;
	struct HASHT_SUF(`seq_ctx') ctx;
};

int HASHT_SUF(`iter')(struct HASHT_SUF(`kvseq') *, const struct HASHT_NAME *);

