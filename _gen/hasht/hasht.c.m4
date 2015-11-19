dnl Hash table based on Simon Cooper's discussion of the .NET Dictionary
dnl implementation
static size_t HASHT_NAME`'_next_pos(struct HASHT_NAME *);
static int HASHT_NAME`'_fetch_internal(struct HASHT_NAME *, HASHT_KEY_TYPE, size_t *, const int);

ifelse(`HASHT_KEY_SEQ',`!',`',`include(_gen/hasht/hasht.kseq.c.m4)')dnl
ifelse(`HASHT_VAL_SEQ',`!',`',`include(_gen/hasht/hasht.vseq.c.m4)')dnl

void HASHT_NAME`'_init(struct HASHT_NAME *t)
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

int HASHT_NAME`'_init2(struct HASHT_NAME *r, const struct HASHT_NAME *s)
{
	size_t i;

	if(s->sz > r->cap)
		return 1;

dnl Copy over all the real data
	memcpy(r->data, s->data, sizeof *s->data * s->cap);

	for(i = 0; i < s->sz; i++)
		if(s->index[i] != -1)
			r->index[s->data[s->index[i]].hash % r->cap] = s->index[i];

	return 0;
}

int HASHT_NAME`'_ins(struct HASHT_NAME *t, HASHT_KEY_TYPE k, HASHT_VAL_TYPE v)
{
	const size_t hash = HASHT_HASH(k);
	const size_t pos = HASHT_NAME`'_next_pos(t);
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

int HASHT_NAME`'_get(struct HASHT_NAME *t, HASHT_KEY_TYPE k, struct HASHT_NAME`'_entry *r)
{
	size_t rp;
	if(HASHT_NAME`'_fetch_internal(t, k, &rp, 0)) return 1;
	*r = t->data[rp].entry;
	return 0;
}

int HASHT_NAME`'_del(struct HASHT_NAME *t, HASHT_KEY_TYPE k, struct HASHT_NAME`'_entry *r)
{
	size_t rp;
	if(HASHT_NAME`'_fetch_internal(t, k, &rp, 1)) return 1;
	*r = t->data[rp].entry;
	return 0;
}

int HASHT_NAME`'_has(struct HASHT_NAME *t, HASHT_KEY_TYPE k)
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

int HASHT_NAME`'_update(struct HASHT_NAME *t, HASHT_KEY_TYPE k, HASHT_VAL_TYPE v)
{
	size_t rp;
	if(HASHT_NAME`'_fetch_internal(t, k, &rp, 0)) return 1;

	t->data[rp].entry.value = v;
	return 0;
}

static size_t HASHT_NAME`'_next_pos(struct HASHT_NAME *t)
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

static int HASHT_NAME`'_fetch_internal(struct HASHT_NAME *t, HASHT_KEY_TYPE k, size_t *rp, const int del)
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
