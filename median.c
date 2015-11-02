#include "heap_intn.h"
#include "heap_intx.h"
#include <stdio.h>
#include <stdlib.h>

#define HEAP_HAS_ROOM(h) ((h)->sz < (h)->cap)
#define HEAP_EMPTY(h) ((h)->sz)
#define HEAP_PEEK(h) ((h)->data[0])

static int init_calc(struct heap_intn *, struct heap_intx *);

int main(void)
{
	int cur, tmp;
	int med;
	int mins[32] = {0};
	int maxs[32] = {0};

	struct heap_intn minh = { mins, 0, 32 };
	struct heap_intx maxh = { maxs, 0, 32 };

	med = init_calc(&minh, &maxh);

	while(scanf("%d", &cur) == 1 && HEAP_HAS_ROOM(&minh) && HEAP_HAS_ROOM(&maxh))
	{
		if(cur < med)
		{
			heap_intx_push(&maxh, cur);

			if(maxh.sz > minh.sz + 1)
			{
				heap_intx_pop(&maxh, &tmp);
				heap_intn_push(&minh, tmp);
			}
		}
		else
		{
			heap_intn_push(&minh, cur);

			if(minh.sz > maxh.sz + 1)
			{
				heap_intn_pop(&minh, &tmp);
				heap_intx_push(&maxh, tmp);
			}
		}

		if(minh.sz > maxh.sz)
			med = HEAP_PEEK(&minh);
		else if(maxh.sz > minh.sz)
			med = HEAP_PEEK(&maxh);
		else
			med = (HEAP_PEEK(&minh) + HEAP_PEEK(&maxh)) / 2;

		printf("Median: %d\n", med);
	}

	return 0;
}

static int init_calc(struct heap_intn *n, struct heap_intx *x)
{
	int n1, n2;
	int med;

	if(scanf("%d", &n1) != 1)
		exit(1);

	printf("Median: %d\n", n1);

	if(scanf("%d", &n2) != 1)
		exit(0);

	if(n1 > n2)
	{
		heap_intn_push(n, n1);
		heap_intx_push(x, n2);
	}
	else
	{
		heap_intn_push(n, n2);
		heap_intx_push(x, n1);
	}

	med = (n1 + n2) / 2;
	return med;
}
