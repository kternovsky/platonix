dnl Hash table based on Simon Cooper's discussion of the .NET Dictionary
dnl implementation
divert(-1)
define(`HASHT_NAME', `ACTIVE_HASHT')
define(`HASHT_KEY', `_get(`HASHT_NAMES_KEYS', ACTIVE_HASHT)')
define(`HASHT_VAL', `_get(`HASHT_NAMES_VALS', ACTIVE_HASHT)')
define(`HASHT_SUF', `HASHT_NAME`'_`$1'')
define(`HASHT_KEY_CMP', _get(`HASHT_KEY_EQ', ACTIVE_HASHT))
define(`HASHT_HASH', _get(`HASHT_HFNS', ACTIVE_HASHT))
divert dnl
static size_t HASHT_SUF(`next_pos')(struct HASHT_NAME *);
static int HASHT_SUF(`fetch_internal')(struct HASHT_NAME *, HASHT_KEY, size_t *, const int);
ifdef(`HASHT_KSEQ', `include(_gen/hasht/hasht.kseq.c.m4)', `')
ifdef(`HASHT_VSEQ', `include(_gen/hasht/hasht.vseq.c.m4)', `')


void HASHT_SUF(`init')(struct HASHT_NAME *t)
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

int HASHT_SUF(`ins')(struct HASHT_NAME *t, HASHT_KEY k, HASHT_VAL v)
{
	const size_t hash = HASHT_HASH(`k');
	const size_t pos = HASHT_SUF(`next_pos')(t);
	size_t idx = hash % t->cap;

	ifdef(`DEBUG',`assert(t->sz < t->cap);')dnl

	if(t->index[idx] == -1)
		t->index[idx] = pos;
	else
	{
		idx = t->index[idx];

		while(t->data[idx].next != -1) idx = t->data[idx].next;

		t->data[idx].next = pos;
	}

	t->data[pos].entry.key = k;
	t->data[pos].entry.value = v;
	t->data[pos].hash = hash;
	t->data[pos].next = -1;
	t->sz++;

	return 0;
}

int HASHT_SUF(`get')(const struct HASHT_NAME *t, HASHT_KEY k, struct HASHT_SUF(`entry') *r)
{
	size_t rp;
	if(HASHT_SUF(`fetch_internal')((struct HASHT_NAME *)t, k, &rp, 0)) return 1;
	*r = t->data[rp].entry;
	return 0;
}

int HASHT_SUF(`del')(struct HASHT_NAME *t, HASHT_KEY k, struct HASHT_SUF(`entry') *r)
{
	size_t rp;
	if(HASHT_SUF(`fetch_internal')(t, k, &rp, 1)) return 1;
	*r = t->data[rp].entry;
	return 0;
}

int HASHT_SUF(`has')(const struct HASHT_NAME *t, HASHT_KEY k)
{
	const size_t hash = HASHT_HASH(k);
	const size_t idx = hash % t->cap;
	size_t pos = t->index[idx];

	if(pos == -1) return 0;

	if(t->data[pos].hash == hash && (HASHT_KEY_CMP(k, t->data[pos].entry.key)))
		return 1;

	while(t->data[pos].next != -1)
	{
		if(t->data[t->data[pos].next].hash == hash &&
			(HASHT_KEY_CMP(t->data[t->data[pos].next].entry.key, k)))
			return 1;

		pos = t->data[pos].next;
	}

	return 0;
}

int HASHT_SUF(`update')(struct HASHT_NAME *t, HASHT_KEY k, HASHT_VAL v)
{
	size_t rp;
	if(HASHT_SUF(`fetch_internal')(t, k, &rp, 0)) return 1;

	t->data[rp].entry.value = v;
	return 0;
}

static size_t HASHT_SUF(`next_pos')(struct HASHT_NAME *t)
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

static int HASHT_SUF(`fetch_internal')(struct HASHT_NAME *t, HASHT_KEY k, size_t *rp, const int del)
{
	const size_t hash = HASHT_HASH(k);
	const size_t idx = hash % t->cap;
	size_t pos = t->index[idx];

	if(pos == -1) return 1;

	if(t->data[pos].hash == hash)
	{
		if(HASHT_KEY_CMP(k, t->data[pos].entry.key))
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
			if(HASHT_KEY_CMP(t->data[t->data[pos].next].entry.key, k))
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
