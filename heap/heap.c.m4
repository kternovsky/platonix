dnl Simple binary heap
include(HEAP_CONFIG)dnl
`#include' "HEAP_HEADER"
#define heap_parent(i) ((i - 1) / 2)
#define heap_left(i) ((2 * (i)) + 1)
#define heap_right(i) ((2 * (i)) + 2)

static void heapify_up(struct HEAP_NAME *h);
static void heapify_down(struct HEAP_NAME *h);

void HEAP_NAME`'_push(struct HEAP_NAME *h, HEAP_DATA_TYPE val)
{
	h->data[h->sz++] = val;
	heapify_up(h);
}

void HEAP_NAME`'_pop(struct HEAP_NAME *h, HEAP_DATA_TYPE *val)
{
	*val = h->data[0];
	h->data[0] = h->data[--h->sz];

	if(h->sz) heapify_down(h);
}

static void heapify_up(struct HEAP_NAME *h)
{
	HEAP_DATA_TYPE tmp;
	size_t i = h->sz - 1, parent;

	while(i)
	{
		parent = heap_parent(i);

		if(HEAP_COMPARE(h, i, parent))
		{
			tmp = h->data[i];
			h->data[i] = h->data[parent];
			h->data[parent] = tmp;
		}

		i = parent;
	}
}

static void heapify_down(struct HEAP_NAME *h)
{
	size_t i = 0, l, r;
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
		h->data[i] = tmp;
		i = maxi;
	}
}

#undef heap_parent
#undef heap_left
#undef heap_right
