dnl Simple binary heap
`#include' "HEAP_HEADER"
#define heap_parent(i) ((i - 1) / 2)
#define heap_left(i) ((2 * (i)) + 1)
#define heap_right(i) ((2 * (i)) + 2)

static void heapify_up(struct HEAP_NAME *h, const size_t);
static void heapify_down(struct HEAP_NAME *h, const size_t);

void HEAP_NAME`'_push(struct HEAP_NAME *h, HEAP_DATA_TYPE val)
{
	h->data[h->sz] = val;
	ifdef(`HEAP_STORE_INDEX',HEAP_STORE_INDEX(h, h->sz);)
	heapify_up(h, h->sz++);
}

void HEAP_NAME`'_pop(struct HEAP_NAME *h, HEAP_DATA_TYPE *val)
{
	*val = h->data[0];
	h->data[0] = h->data[--h->sz];

	if(h->sz) heapify_down(h, 0);
}

void HEAP_NAME`'_fix(struct HEAP_NAME *h)
{
	size_t sz = h->sz;

	h->sz /= 2;
	h->data += h->sz;

	while(h->sz < sz)
	{
		heapify_down(h, 0);
		h->sz++;
		h->data--;
	}
}

ifdef(`HEAP_STORE_INDEX',`
void HEAP_NAME`'_keydn(struct HEAP_NAME *h, const size_t t, const size_t k)
{
	HEAP_STORE_INDEX(h, k);
	heapify_down(h, t);
}
void HEAP_NAME`'_keyup(struct HEAP_NAME *h, const size_t t, const size_t k)
{
	HEAP_STORE_INDEX(h, k);
	heapify_up(h, t);
}')dnl

static void heapify_up(struct HEAP_NAME *h, const size_t start)
{
	HEAP_DATA_TYPE tmp;
	size_t i = start, parent;

	while(i)
	{
		parent = heap_parent(i);

		if(HEAP_COMPARE(h, i, parent))
		{
			tmp = h->data[i];
			h->data[i] = h->data[parent];
			ifdef(`HEAP_STORE_INDEX',HEAP_STORE_INDEX(h, i);)
			h->data[parent] = tmp;
			ifdef(`HEAP_STORE_INDEX',HEAP_STORE_INDEX(h, parent);)
		}

		i = parent;
	}
}

static void heapify_down(struct HEAP_NAME *h, const size_t start)
{
	size_t i = start, l, r;
	size_t maxi;
	HEAP_DATA_TYPE tmp;

	for(;;)
	{
		l = heap_left(i);
		r = heap_right(i);
		maxi = i;

		if(l < h->sz && (HEAP_COMPARE(h, l, i)))
			maxi = l;

		if(r < h->sz && (HEAP_COMPARE(h, r, maxi)))
			maxi = r;

		if(maxi == i) return;

		tmp = h->data[maxi];
		h->data[maxi] = h->data[i];
		ifdef(`HEAP_STORE_INDEX',HEAP_STORE_INDEX(h, maxi);)dnl
		h->data[i] = tmp;
		ifdef(`HEAP_STORE_INDEX',HEAP_STORE_INDEX(h, i);)dnl
		i = maxi;
	}
}

#undef heap_parent
#undef heap_left
#undef heap_right
