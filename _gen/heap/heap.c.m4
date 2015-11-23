divert(-1)
define(`HEAP_NAME', `ACTIVE_HEAP')
define(`HEAP_TYPE', `_get(`HEAP_NAMES', ACTIVE_HEAP)')
define(`HEAP_SUF', `HEAP_NAME`'_`$1'')
define(`HEAP_CMP', _get(`HEAP_KEY_CMP', ACTIVE_HEAP))
define(`HEAP_PARENT', `(($1 - 1) / 2)')
define(`HEAP_LEFT', `((2 * ($1)) + 1)')
define(`HEAP_RIGHT', `((2 * ($1)) + 2)')
divert dnl
static void HEAP_SUF(`heapify_up')(struct HEAP_NAME *, const size_t);
static void HEAP_SUF(`heapify_down')(struct HEAP_NAME *, const size_t);

void HEAP_SUF(`push')(struct HEAP_NAME *h, HEAP_TYPE val)
{
	h->data[h->sz] = val;
	HEAP_SUF(`heapify_up')(h, h->sz++);
}

void HEAP_SUF(`pop')(struct HEAP_NAME *h, HEAP_TYPE *val)
{
	*val = h->data[0];
	h->data[0] = h->data[--h->sz];

	if(h->sz) HEAP_SUF(`heapify_down')(h, 0);
}

void HEAP_SUF(`fix')(struct HEAP_NAME *h)
{
	size_t sz = h->sz;
	h->sz /= 2;
	h->data += h->sz;

	while(h->sz < sz)
	{
		HEAP_SUF(`heapify_down')(h, 0);
		h->sz++;
		h->data--;
	}
}

static void HEAP_SUF(`heapify_up')(struct HEAP_NAME *h, const size_t start)
{
	HEAP_TYPE tmp;
	size_t i = start, parent;

	while(i)
	{
		parent = HEAP_PARENT(`i');

		if(HEAP_CMP(`h', `i', `parent'))
		{
			tmp = h->data[i];
			h->data[i] = h->data[parent];
			h->data[parent] = tmp;
		}

		i = parent;
	}
}

static void HEAP_SUF(`heapify_down')(struct HEAP_NAME *, const size_t start)
{
	size_t i = start, l, r;
	size_t maxi;
	HEAP_TYPE tmp;

	for(;;)
	{
		l = HEAP_LEFT(`i');
		r = HEAP_RIGHT(`i');
		maxi = i;

		if(l < h->sz && (HEAP_CMP(`h', `l', `i')))
			maxi = l;

		if(r < h->sz && (HEAP_CMP(`h', `r', `maxi')))
			maxi = r;

		if(maxi == i) return;

		tmp = h->data[maxi];
		h->data[maxi] = h->data[i];
		h->data[i] = tmp;
		i = maxi;
	}
}
