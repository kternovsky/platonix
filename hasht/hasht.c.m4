dnl Hash table based on Simon Cooper's discussion of the .NET Dictionary
dnl implementation
dnl define(`HASHT_C_PREAMBLE',`')dnl
dnl include(CONFIG)dnl
`#include' "HASHT_HEADER"
`#include' <assert.h>
`#include' <stdio.h>
`#include' <string.h>
`#include' <stdlib.h>
ifdef(`HASHT_C_PREAMBLE',HASHT_C_PREAMBLE)
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

dnl DO THIS DUMB WAY FIRST
void HASHT_NAME`'_rehash(struct HASHT_NAME *t, const size_t pcap)
{
	size_t i;
	size_t np;
	size_t *new_idxs = malloc(t->cap * sizeof *new_idxs);

	for(i = 0; i < t->cap; i++) new_idxs[i] = -1;

	for(i = 0; i < pcap; i++)
	{
		if(t->index[i] == -1) continue;

		np = t->data[t->index[i]].hash % t->cap;
		new_idxs[np] = t->index[i];
	}

	memcpy(t->index, new_idxs, t->cap * sizeof *new_idxs);

	free(new_idxs);
}

dnl void HASHT_NAME`'_rehash(struct HASHT_NAME *t, const size_t pcap)
dnl {
	dnl size_t i;
	dnl size_t free = t->cap - 1;
	dnl size_t np;
dnl 
	dnl for(i = pcap; i < t->cap; i++) t->index[i] = -1;
dnl 
	dnl for(i = 0; i < pcap; i++)
	dnl {
		dnl if(t->index[i] != -1)
		dnl {
			dnl np = t->data[t->index[i]].hash % t->cap;
			dnl if(np < i)
			dnl {
				dnl puts("oh look wegot a free slot behind us");
				dnl assert(t->index[np] == -1);
				dnl t->index[np] = t->index[i];
				dnl t->index[i] = -1;
			dnl }
			dnl else if(np > i)
			dnl {
				dnl puts("weirndess");
dnl dnl TODO: some math to see if it's possible to just move it to correct place
				dnl t->index[free--] = t->index[i];
				dnl t->index[i] = -1;
			dnl }
		dnl }
	dnl }
dnl 
	dnl while(++free < t->cap)
	dnl {
		dnl np = t->data[t->index[free]].hash % t->cap;
		dnl assert(t->index[np] == -1);
		dnl t->index[np] = t->index[free];
		dnl t->index[free] = -1;
	dnl }
dnl }

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
