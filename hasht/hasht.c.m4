dnl Hash table based on Simon Cooper's discussion of the .NET Dictionary
dnl implementation
define(`HASHT_C_PREAMBLE',`')dnl
include(HASHT_CONFIG)dnl
`#include' "HASHT_HEADER"

HASHT_C_PREAMBLE

static size_t hasht_next_pos(struct HASHT_NAME *);
static int hasht_fetch_internal(struct HASHT_NAME *, HASHT_KEY_TYPE, struct HASHT_NAME`'_entry *, const int);

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

int HASHT_NAME`'_ins(struct HASHT_NAME *t, HASHT_KEY_TYPE k, HASHT_VAL_TYPE v)
{
	const size_t hash = HASHT_HASH(k);
	const size_t pos = hasht_next_pos(t);
	size_t idx = hash % t->cap;

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
	return hasht_fetch_internal(t, k, r, 0);
}

int HASHT_NAME`'_del(struct HASHT_NAME *t, HASHT_KEY_TYPE k, struct HASHT_NAME`'_entry *r)
{
	return hasht_fetch_internal(t, k, r, 1);
}

int HASHT_NAME`'_has(struct HASHT_NAME *t, HASHT_KEY_TYPE k)
{
	const size_t hash = HASHT_HASH(k);
	const size_t idx = hash % t->cap;
	size_t pos = t->index[idx];

	if(pos == -1) return 1;

	if(t->data[pos].hash == hash && (HASHT_KEY_CMP(k, t->data[pos].entry.key)))
		return 1;

	while(t->data[pos].next != -1)
	{
		if(t->data[t->data[pos].next].hash == hash &&
			(HASHT_KEY_CMP(t->data[t->data[pos].next].entry.key, k)))
			return 0;

		pos = t->data[pos].next;
	}
	
	return 0;
}

static size_t hasht_next_pos(struct HASHT_NAME *t)
{
dnl Find the next available data slot.
dnl If cursor < cap we still have regular room in the array and can just put
dnl data there.
	size_t idx;
	if(t->cursor < t->cap)
		return t->cursor ++;
dnl Otherwise, we're out of regular room. So we'll use the head of our free list
dnl and adjust the free list to point to the next item.
	idx = t->free;

	if(t->data[t->free].next != -1)
		t->free = t->data[t->free].next;
	else
		t->free = -1;

	return idx;
}

static int hasht_fetch_internal(struct HASHT_NAME *t, HASHT_KEY_TYPE k, struct HASHT_NAME`'_entry *r, const int del)
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
				t->free = pos;
				t->index[idx] = t->data[pos].next;
				t->sz--;
			}
			r->key = t->data[pos].entry.key;
			r->value = t->data[pos].entry.value;
			return 0;
		}
	}

	while(t->data[pos].next != -1)
	{
		if(t->data[t->data[pos].next].hash == hash)
		{
			if(HASHT_KEY_CMP(t->data[t->data[pos].next].entry.key, k))
			{
				r->key = t->data[t->data[pos].next].entry.key;
				r->value = t->data[t->data[pos].next].entry.value;
				if(del)
				{
					t->free = t->data[t->data[pos].next].next;
					t->data[pos].next = t->data[t->data[pos].next].next;
					t->sz--;
				}
				return 0;
			}
		}

		pos = t->data[pos].next;
	}

	return 1;
}
