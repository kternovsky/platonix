#include "hasht_ii.h"
#include <stdio.h>

int main(void)
{
	int i, tmp, j;
	size_t idxs[32];
	struct hasht_ii_data data[32];
	struct hasht_ii h = { idxs, data, 32 };
	struct hasht_ii_entry existing;

	hasht_ii_init(&h);

	while(h.sz < h.cap)
	{
		if(scanf("%d", &tmp) != 1)
			break;

		if(!hasht_ii_del(&h, tmp, &existing))
		{
			hasht_ii_ins(&h, tmp, existing.value + 1);
		}
		else
		{
			hasht_ii_ins(&h, tmp, 1);
		}
	}

	for(i = 0; i < h.cap; i++)
	{
		j = h.index[i];
		while(j != -1)
		{
			printf("%d seen %d times\n", h.data[j].entry.key, h.data[j].entry.value);
			j = h.data[j].next;
		}
	}

	return 0;
}
