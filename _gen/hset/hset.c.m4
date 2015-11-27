divert(-1)
define(`HSET_NAME', `ACTIVE_HSET')
define(`HSET_VAL', `_get(`HSET_NAMES_VALS', ACTIVE_HSET)')
define(`HSET_SUF', `HSET_NAME`'_`$1'')
define(`HSET_CMP', _get(`HSET_KEY_EQ', ACTIVE_HSET))
define(`HSET_HASH', _get(`HSET_HFNS', ACTIVE_HSET))
include(seq/seq.m4)
ifelse(_get(`SEQ_TYPES', HSET_VAL), `', `', `define(`HSET_VSEQ', _get(`SEQ_TYPES', HSET_VAL))')
divert dnl
static size_t HSET_SUF(`next_pos')(struct HSET_NAME *);
static int HSET_SUF(`fetch_internal')(struct HSET_NAME *, const HSET_VAL, size_t *, const int);
ifdef(`HSET_VSEQ', `include(_gen/hset/hset.vseq.c.m4)', `')


void HSET_SUF(`init')(struct HSET_NAME *t)
{
	size_t i;

	for(i = 0; i < t->cap; i++)
	{
		t->index[i] = -1;
		t->data[i].next = -1;
	}

	t->sz = 0;
	t->cursor = 0;
	t->free = -1;
}

int HSET_SUF(`ins')(struct HSET_NAME *t, HSET_VAL v)
{
	const size_t hash = HSET_HASH(`v');
	const size_t pos = HSET_SUF(`next_pos')(t);
	size_t idx = hash % t->cap;

	ifdef(`DEBUG',`assert(t->sz < t->cap);')dnl

	if(t->index[idx] == -1)
		t->index[idx] = pos;
	else
	{
		idx = t->index[idx];

		dnl TODO: equality comparison
		while(t->data[idx].next != -1) idx = t->data[idx].next;

		t->data[idx].next = pos;
	}

	t->data[pos].value = v;
	t->data[pos].hash = hash;
	t->data[pos].next = -1;
	t->sz++;

	return 0;
}

int HSET_SUF(`del')(struct HSET_NAME *t, const HSET_VAL k, HSET_VAL *v)
{
	size_t rp;
	if(HSET_SUF(`fetch_internal')(t, k, &rp, 1)) return 1;
	*v = t->data[rp].value;
	return 0;
}

int HSET_SUF(`has')(const struct HSET_NAME *t, HSET_VAL v)
{
	const size_t hash = HSET_HASH(`v');
	const size_t idx = hash % t->cap;
	size_t pos = t->index[idx];

	if(pos == -1) return 0;

	if(t->data[pos].hash == hash && (HSET_CMP(`v', `t->data[pos].value')))
		return 1;

	while(t->data[pos].next != -1)
	{
		if(t->data[t->data[pos].next].hash == hash &&
			(HSET_CMP(`t->data[t->data[pos].next].value', `v')))
			return 1;

		pos = t->data[pos].next;
	}

	return 0;
}

int HSET_SUF(`union')(struct HSET_NAME *r, const struct HSET_NAME *s1, const struct HSET_NAME *s2)
{
	size_t sz = 0;
	const struct HSET_NAME *b, *s;
	struct HSET_SUF(`vseq') bs, ss;

	if(s1->sz > s2->sz)
	{
		b = s1;
		s = s2;
	}
	else
	{
		b = s2;
		s = s1;
	}

	if(!HSET_SUF(`iter')(&bs, b) || !HSET_SUF(`iter')(&ss, s)) return 1;

	if(b->sz)
		do
		{
			HSET_VAL tmp;
			if(bs.seq.ops->read(&bs.seq, &tmp)) return 1;

			HSET_SUF(`ins')(r, tmp);
			sz++;
		} while(!bs.seq.ops->next(&bs.seq));

	if(s->sz)
		do
		{
			HSET_VAL tmp;
			if(ss.seq.ops->read(&ss.seq, &tmp)) return 1;

			if(HSET_SUF(`has')(s1, tmp)) continue;

			HSET_SUF(`ins')(r, tmp);
			sz++;
		} while(!ss.seq.ops->next(&ss.seq));

	r->sz = sz;
	return 0;
}

int HSET_SUF(`intersection')(struct HSET_NAME *r, const struct HSET_NAME *s1, const struct HSET_NAME *s2)
{
	size_t sz = 0;
	const struct HSET_NAME *b, *s;
	struct HSET_SUF(`vseq') ss;

	if(s1->sz > s2->sz)
	{
		b = s1;
		s = s2;
	}
	else
	{
		b = s2;
		s = s1;
	}

	if(s1->sz == 0 || s2->sz == 0)
	{
		r->sz = 0;
		return 0;
	}

	if(!HSET_SUF(`iter')(&ss, s)) return 1;

	do
	{
		HSET_VAL tmp;

		if(ss.seq.ops->read(&ss.seq, &tmp)) return 1;

		if(!HSET_SUF(`has')(b, tmp)) continue;

		HSET_SUF(`ins')(r, tmp);
	} while(!ss.seq.ops->next(&ss.seq));

	r->sz = sz;
	return 0;
}

dnl r = s1 \ s2
int HSET_SUF(`diff')(struct HSET_NAME *r, const struct HSET_NAME *s1, const struct HSET_NAME *s2)
{
	size_t sz = 0;
	struct HSET_SUF(`vseq') se;
	if(s1->sz == 0)
	{
		r->sz = 0;
		return 0;
	}

	if(HSET_SUF(`iter')(&se, s1)) return 1;

	if(s2->sz == 0)
	{
		do
		{
			HSET_VAL tmp;

			if(se.seq.ops->read(&se.seq, &tmp)) return 1;

			HSET_SUF(`ins')(r, tmp);
		} while(!se.seq.ops->next(&se.seq));

		return 0;
	}

	do
	{
		HSET_VAL tmp;

		if(se.seq.ops->read(&se.seq, &tmp)) return 1;

		if(HSET_SUF(`has')(s2, tmp)) continue;

		HSET_SUF(`ins')(r, tmp);
	} while(!se.seq.ops->next(&se.seq));

	return 0;

}

int HSET_SUF(`is_subset')(const struct HSET_NAME *s1, const struct HSET_NAME *s2)
{
	struct HSET_SUF(`vseq') se;
	if(s2->sz < s1->sz) return 0;

	if(HSET_SUF(`iter')(&se, s1)) return -1;

	do
	{
		HSET_VAL tmp;

		if(se.seq.ops->read(&se.seq, &tmp)) return -1;

		if(!HSET_SUF(`has')(s2, tmp)) return 0;
	} while(!se.seq.ops->next(&se.seq));

	return 1;
}

static size_t HSET_SUF(`next_pos')(struct HSET_NAME *t)
{
dnl Find the next available data slot.
dnl If cursor < cap we still have regular room in the array and can just put
dnl data there.
	size_t idx;
	if(t->cursor < t->cap)
		return t->cursor ++;
dnl Otherwise, we're out of regular room. So we'll use the head of our free list
dnl and adjust the free list to point to the next item.
	ifdef(`DEBUG',`assert(t->sz < t->cap)');
	ifdef(`DEBUG',`assert(t->free != -1)');
	idx = t->free;

	if(t->data[t->free].next != -1)
		t->free = t->data[t->free].next;
	else
		t->free = -1;

	return idx;
}

static int HSET_SUF(`fetch_internal')(struct HSET_NAME *t, HSET_VAL v, size_t *rp, const int del)
{
	const size_t hash = HSET_HASH(`v');
	const size_t idx = hash % t->cap;
	size_t pos = t->index[idx];

	if(pos == -1) return 1;

	if(t->data[pos].hash == hash)
	{
		if(HSET_CMP(`v', `t->data[pos].value'))
		{
			if(del)
			{
				t->index[idx] = t->data[pos].next;
				t->data[pos].next = t->free;
				t->free = pos;
				t->sz--;
			}
			*rp = pos;
			return 0;
		}
	}

	while(t->data[pos].next != -1)
	{
		if(t->data[t->data[pos].next].hash == hash)
		{
			if(HSET_CMP(`t->data[t->data[pos].next].value', `v'))
			{
				size_t actual = t->data[pos].next;
				*rp = actual;
				if(del)
				{
					t->data[pos].next = t->data[actual].next;
					t->data[actual].next = t->free;
					t->free = actual;
					t->sz--;
				}
				return 0;
			}
		}

		pos = t->data[pos].next;
	}

	return 1;
}
divert(-1) dnl
undefine(`HSET_NAME')
undefine(`HSET_VAL')
undefine(`HSET_SUF')
undefine(`HSET_CMP')
undefine(`HSET_HASH')
divert dnl
